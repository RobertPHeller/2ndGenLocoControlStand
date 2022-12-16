// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Oct 7 18:43:06 2019
//  Last Modified : <221216.1232>
//
//  Description	
//
//  Notes
//
//  History
//	
/////////////////////////////////////////////////////////////////////////////
//
//    Copyright (C) 2019  Robert Heller D/B/A Deepwoods Software
//			51 Locke Hill Road
//			Wendell, MA 01379-9728
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 2 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//
// 
//
//////////////////////////////////////////////////////////////////////////////

#ifndef __ESP32CONTROLSTAND_H
#define __ESP32CONTROLSTAND_H

#include "openlcb/TractionThrottle.hxx"
#include "openlcb/Velocity.hxx"
#include "openlcb/RefreshLoop.hxx"
#include "openlcb/EventHandlerTemplates.hxx"
#include "openlcb/EventService.hxx"
#include "openlcb/IfCan.hxx"
#include "openlcb/ConfigRepresentation.hxx"
#include "executor/Notifiable.hxx"
#include "executor/StateFlow.hxx"
#include "utils/ConfigUpdateListener.hxx"
#include "utils/ConfigUpdateService.hxx"
#include "ControlStandConfigurationGroup.hxx"
#include "Adafruit_SSD1306.h"
#include "Button.hxx"
#include "LightSwitch.hxx"
#ifndef CDIONLY
#include "hardware.hxx"
#endif
#include "SNIPClient.hxx"
#include <map>
#include <string>

using TrainIDMap   = std::map<openlcb::NodeID, std::string>;


#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 32 // OLED display height, in pixels

// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
#define OLED_RESET     -1 // Reset pin # (or -1 if sharing Arduino reset pin)

#define BROWSELOCOS 0
#define SEARCHFORLOCO 1
#define REFRESHLOCOLIST 2
#define FUNCTIONS 3
#define CONSIST 4
#define SETTINGS 5
#define _MAINMENUMIN BROWSELOCOS
#define _MAINMENUP1MAX REFRESHLOCOLIST
#define _MAINMENUP2MAX SETTINGS
#define _MAINMENUMAX SETTINGS
#define ENTROPYFACTOR 0
#define ACCELERATIONFACTOR 1
#define BRAKEFACTOR 2
#define MAXIMUMSPEED 3
#define _SETTINGSMIN ENTROPYFACTOR
#define _SETTINGSMAX MAXIMUMSPEED
#define _FUNCTIONSMIN 0
#define _FUNCTIONSMAX 28


#define _POLLCOUNT 16

#define currentTrain target_node()

class ESP32ControlStand : public openlcb::TractionThrottle, public openlcb::Polling, openlcb::SimpleEventHandler, public ConfigUpdateListener {
public:
    ESP32ControlStand(openlcb::Node *node, 
                      const ESP32ControlStandConfig &cfg)
                : TractionThrottle(node)
          , cfg_(cfg)
          , display_(SCREEN_WIDTH, SCREEN_HEIGHT, OLED_RESET)
          , throttlea_(THROTTLEA_Pin::instance())
          , throttleb_(THROTTLEB_Pin::instance())
          , a_(BUTTON_A_Pin::instance())
          , b_(BUTTON_B_Pin::instance())
          , c_(BUTTON_C_Pin::instance())
          , d_(BUTTON_D_Pin::instance())          
          , bell_(BELL_Pin::instance())
          , lightSwitch_(L_OFF_Pin::instance(),L_DIM_Pin::instance(),L_BRIGHT_Pin::instance(),L_DITCH_Pin::instance())
          , currentLS_(LightSwitch::Unknown)
          , throttlePosition_(0)
          , brake_(0)
          , horn_(0)
          , reverser_(0)
          , currentState_(Welcome)
          , selection_(_MAINMENUMIN)
          , snipClient_(throttle_node()->iface())
          , entropyFactor_(1)
          , accelerationFactor_(1)
          , brakeFactor_(1)
          , maximumSpeed_(45)
          , currentVelocity_(0)
          , reverserPosition_(Neutral)
          , pollCount_(0)
    { 
        register_handler(); 
        ConfigUpdateService::instance()->register_update_listener(this);
    }

    ~ESP32ControlStand() 
    {
        unregister_handler();
    }
    void hw_init();
    void poll_33hz(openlcb::WriteHelper *helper, Notifiable *done) OVERRIDE;
    void welcomeScreen();
    void handle_event_report(const openlcb::EventRegistryEntry &entry, 
                             EventReport *event,
                             BarrierNotifiable *done) override;
    void handle_identify_global(const openlcb::EventRegistryEntry &registry_entry, 
                                EventReport *event, BarrierNotifiable *done) override;
    void handle_producer_identified(const openlcb::EventRegistryEntry &entry,
                                  EventReport *event,
                                  BarrierNotifiable *done) override;
    void SendIsTrainEventQuery()
    {
        write_helper[0].WriteAsync(throttle_node(),
                                   openlcb::Defs::MTI_PRODUCER_IDENTIFY,
                                   openlcb::WriteHelper::global(),
                                   openlcb::eventid_to_buffer(openlcb::TractionDefs::IS_TRAIN_EVENT),
                                   this);
    }
    virtual UpdateAction apply_configuration(int fd, 
                                             bool initial_load,
                                             BarrierNotifiable *done) override
    {
        AutoNotify n(done);
        entropyFactor_ = cfg_.entropy().read(fd);
        accelerationFactor_ = cfg_.acceleration().read(fd);
        brakeFactor_ = cfg_.brake().read(fd);
        maximumSpeed_ = cfg_.maximumspeed().read(fd);
        return UPDATED;
    }
    virtual void factory_reset(int fd) 
    {
        CDI_FACTORY_RESET(cfg_.entropy);
        CDI_FACTORY_RESET(cfg_.acceleration);
        CDI_FACTORY_RESET(cfg_.brake);
        CDI_FACTORY_RESET(cfg_.maximumspeed);
    }
    
private:
    const ESP32ControlStandConfig cfg_;
    Adafruit_SSD1306 display_;
    const Gpio *throttlea_, *throttleb_;
    Button a_;
    Button b_;
    Button c_;
    Button d_;
    Button bell_;
    LightSwitch lightSwitch_;
    LightSwitch::Position currentLS_;
    uint8_t throttlePosition_;
    uint16_t brake_;
    uint16_t horn_;
    uint16_t reverser_;
    enum Pressed {None=0, A, B, C, D};
    enum MenuState {Welcome, MainMenu, Browse, Search, Functions, Consist, Settings, Idle} currentState_;
    int selection_;
    uint8_t throttleQuadrature_;
    TrainIDMap   trainsByID_;
    TrainIDMap::const_iterator selectedTrain_;
    openlcb::WriteHelper write_helper[4];
    SNIPClient snipClient_;
    openlcb::NodeHandle tempTrain_;
    uint16_t entropyFactor_, 
          accelerationFactor_, 
          brakeFactor_, 
          maximumSpeed_;
    openlcb::Velocity currentVelocity_;
    enum {Reverse, Neutral, Forward} reverserPosition_;
    uint8_t pollCount_;
    uint8_t searchStringIndex_, letterIndex_;
    char searchString_[21];
    bool updateSetting_;
    bool checkThrottle();
    bool readBrake();
    bool readHorn();
    bool readReverser();
    void pollMenu();
    void ringBell() {}
    void updateReverserPosition() {}
    Pressed button() {
        a_.read();
        b_.read();
        c_.read();
        d_.read();
        if (a_.pressed()) return(A);
        else if (b_.pressed()) return(B);
        else if (c_.pressed()) return(C);
        else if (d_.pressed()) return(D);
        else return(None);
    }
    void mainMenu();
    void idleScreen();
    void BrowseScreen();
    void FunctionScreen();
    void ConsistScreen();
    void highlightChar() {
        int y = 0;
        int x = 6*searchStringIndex_;
        if (searchStringIndex_ == 20) 
            display_.drawChar(x,y,' ',BLACK,WHITE,1);
        else
            display_.drawChar(x,y,searchString_[searchStringIndex_],BLACK,WHITE,1);
    }
    void unHighlightChar() {
        int y = 0;
        int x = 6*searchStringIndex_;
        if (searchStringIndex_ == 20)
            display_.drawChar(x,y,' ',WHITE,BLACK,1);
        else
            display_.drawChar(x,y,searchString_[searchStringIndex_],WHITE,BLACK,1);
    }
    void highlightLetter() {
        int x,y;
        //unsigned char ch;
        if (letterIndex_ < 20) 
        {
            y = 8;
            x = 6*letterIndex_;
        } else {
            y = 16;
            x = 6*(letterIndex_-20);
        }
        //if (letterIndex_ < 26) ch = 'A' + letterIndex_;
        //else if (letterIndex_ < 36) ch = '0' + (letterIndex_-26);
        //else if (letterIndex_ == 36) ch = ' ';
        //else if (letterIndex_ == 37) ch = '-';
        //else if (letterIndex_ == 38) ch = '.';
        //else if (letterIndex_ == 39) ch = '<';
        display_.drawChar(x,y,searchString_[searchStringIndex_],BLACK,WHITE,1);
    }
    void unHighlightLetter() {
        int x,y;
        //unsigned char ch;
        if (letterIndex_ < 20) 
        {
            y = 8;
            x = 6*letterIndex_;
        } else {
            y = 16;
            x = 6*(letterIndex_-20);
        }
        //if (letterIndex_ < 26) ch = 'A' + letterIndex_;
        //else if (letterIndex_ < 36) ch = '0' + (letterIndex_-26);
        //else if (letterIndex_ == 36) ch = ' ';
        //else if (letterIndex_ == 37) ch = '-';
        //else if (letterIndex_ == 38) ch = '.';
        //else if (letterIndex_ == 39) ch = '<';
        display_.drawChar(x,y,searchString_[searchStringIndex_],WHITE,BLACK,1);
    }
    bool match_(std::string trainname)
    {
        for (int i=0;i < searchStringIndex_; i++) {
            if (i >= trainname.length()) return false;
            if (toupper(trainname[i]) != searchString_[i]) return false;
        }
        return true;
    }
    void SearchScreen();
    void SettingsScreen();
    void register_handler();
    void unregister_handler();
    void AddTrain(openlcb::NodeHandle train) {
        tempTrain_ = train;
        start_flow(STATE(getSNIP));
    }
    Action getSNIP()
    {
        snipClient_.request(tempTrain_,throttle_node(),this);
        return wait_and_call(STATE(snip_response));
    }
    Action snip_response()
    {
        if (snipClient_.error_code() != SNIPClient::OPERATION_SUCCESS) {
            LOG(INFO,
                "SNIP request failed. Error code: %" PRIx32 ". Using blank name.",
                snipClient_.error_code());
        }
        if (tempTrain_.id != 0) {
            trainsByID_[tempTrain_.id] = snipClient_.response()->user_name;
        } else {
            openlcb::NodeIdLookupFlow nodeIdLookup_((openlcb::IfCan*)(throttle_node()->iface()));
            auto result = invoke_flow(&nodeIdLookup_,throttle_node(),tempTrain_);
            if (result->data()->resultCode == 0) {
                trainsByID_[result->data()->handle.id] = snipClient_.response()->user_name;
            }
        }
        return release_and_exit();
    }
    
    void AcquireTrain(openlcb::NodeID train)
    {
        tempTrain_.id=train;
        start_flow(STATE(send_assign));
    }
    Action send_assign()
    {
        return invoke_subflow_and_wait(this, STATE(assign_done),
                                       openlcb::TractionThrottleCommands::ASSIGN_TRAIN, 
                                       tempTrain_.id, false);
    }

    Action assign_done()
    {
        notify();
        return release_and_exit();
    }
    void load_speed_from_train_node()
    {
        if (currentTrain == 0) return;
        else start_flow(STATE(send_load_state));
    }
    Action send_load_state()
    {
        return invoke_subflow_and_wait(this, STATE(load_speed_done),
                                       openlcb::TractionThrottleCommands::LOAD_STATE);
    }
    Action load_speed_done()
    {
        return release_and_exit();
    }
};

#endif // __ESP32CONTROLSTAND_H

