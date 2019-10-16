// -!- C++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Oct 7 18:47:11 2019
//  Last Modified : <191016.1304>
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

static const char rcsid[] = "@(#) : $Id$";

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Button.h>
#include <OpenMRNLite.h>
#include "openlcb/TractionThrottle.hxx"
#include "openlcb/RefreshLoop.hxx"
#include "openlcb/EventHandlerTemplates.hxx"
#include "openlcb/EventService.hxx"
#include "ESP32ControlStand.h"


bool ESP32ControlStand::checkThrottle()
{
    bool changedP = false;
    uint8_t newQuadrature;
    newQuadrature = digitalRead(THROTTLEA) | (digitalRead(THROTTLEB) << 1);
    uint8_t quadratureUp[] = {1, 3, 0, 2};
    uint8_t quadratureDown[] = {2, 0, 3, 1};
    if (newQuadrature != throttleQuadrature_)
    {
        changedP = true;
        if (newQuadrature == quadratureUp[throttleQuadrature_ & 0x03])
        {
            if (throttlePosition_ > 0)
                throttlePosition_--;
        }
        else if (newQuadrature == quadratureDown[throttleQuadrature_ & 0x03])
        {
            if (throttlePosition_ < 8)
                throttlePosition_++;
        }
        else
            throttlePosition_ = 0;
    }
    throttleQuadrature_ = newQuadrature & 0x03;
    return changedP;
}

bool ESP32ControlStand::readBrake() {
    uint16_t newBrake = analogRead(BRAKE);
    if (newBrake != brake_) {
        brake_ = newBrake;
        return (true);
    } else {
        return (false);
    }
}

bool ESP32ControlStand::readHorn() {
    uint16_t newHorn = analogRead(HORN);
    if (newHorn != horn_) {
        horn_ = newHorn;
        return (true);
    } else {
        return (false);
    }
}

bool ESP32ControlStand::readReverser() {
    uint16_t newReverser = analogRead(REVERSER);
    if (newReverser != reverser_) {
        reverser_ = newReverser;
        return (true);
    } else {
        return (false);
    }
}
void ESP32ControlStand::hw_init()
{
    // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
    if(!display_.begin(SSD1306_SWITCHCAPVCC, 0x3C)) { // Address 0x3C for 128x32
        Serial.println(F("SSD1306 allocation failed"));
        // blink red
        digitalWrite(STATUS_G,LOW);
        for(;;) { // Don't proceed, loop forever
            digitalWrite(STATUS_R,LOW);
            delay(500);
            digitalWrite(STATUS_R,HIGH);
            delay(1000);
        }
    }
    pinMode(HORN,INPUT);
    pinMode(BRAKE,INPUT);
    a_.begin();
    b_.begin();
    c_.begin();
    d_.begin();
    bell_.begin();
    lightSwitch_.begin();
    pinMode(REVERSER,INPUT);
    pinMode(THROTTLEA,INPUT_PULLUP);
    pinMode(THROTTLEB,INPUT_PULLUP);
    throttleQuadrature_ = digitalRead(THROTTLEA) | (digitalRead(THROTTLEB) << 1);
}

void ESP32ControlStand::poll_33hz(openlcb::WriteHelper *helper, Notifiable *done)
{
    checkThrottle();
    readBrake();
    readHorn();
    readReverser();
    if (pollCount_ == _POLLCOUNT) {
        // Update train
        if (currentTrain != 0 && reverserPosition_ != Neutral) {
            int reduction = entropyFactor_+brakeFactor_*brake_;
            int increase  = throttlePosition_*accelerationFactor_;
            int delta = increase - reduction;
            bool curveldir = currentVelocity_.direction();
            float newspeed = currentVelocity_.speed() + delta;
            if (newspeed < 0) {
                newspeed = 0;
            } else if (newspeed > maximumSpeed_) {
                newspeed = maximumSpeed_;
            }
            currentVelocity_ = newspeed;
            currentVelocity_.set_direction(curveldir);
            set_speed(currentVelocity_);
            if (throttlePosition_ == 0 && currentVelocity_.speed() == 0) {
                updateReverserPosition();
            }
        }
        if (currentState_ == Idle &&
            button() == None && 
            currentTrain != 0) idleScreen();
        pollCount_ = 0;
    }
    if (currentTrain != 0) {
        if (bell_.pressed()) {
            ringBell();
        }
        LightSwitch::Position newpos = lightSwitch_.read();
        if (lightSwitch_.has_changed()) {
            switch (currentLS_) {
            case LightSwitch::Off:
                break;
            case LightSwitch::Dim:
                break;
            case LightSwitch::Bright:
                break;
            case LightSwitch::Ditch:
                break;
            }
            switch (newpos) {
                break;
            case LightSwitch::Off:
                break;
            case LightSwitch::Dim:
                break;
            case LightSwitch::Bright:
                break;
            case LightSwitch::Ditch:
                break;
            }
            currentLS_ = newpos;
        }
    }
    pollMenu();  // Other tasks
    pollCount_++;
}

void ESP32ControlStand::pollMenu()
{
    switch (currentState_) {
    case Idle:
    case Welcome: 
        if (button() != None) {
            selection_ = _MAINMENUMIN;
            currentState_ = MainMenu;
            mainMenu();
        }
        break;
    case MainMenu:
        switch (button()) {
        case A:
            if (selection_ > _MAINMENUMIN) {
                selection_--;
                mainMenu();
            }
            break;
        case B:
            switch (selection_) {
            case BROWSELOCOS:
                selectedTrain_ = trainsByID_.begin();
                currentState_ = Browse;
                BrowseScreen();
                break;
            case SEARCHFORLOCO:
                currentState_ = Search;
                SearchScreen();
                break;
            case SETTINGS:
                currentState_ = Settings;
                selection_ = _SETTINGSMIN;
                updateSetting_ = false;
                SettingsScreen();
                break;
            }
            break;
        case C:
            if (selection_ < _MAINMENUMAX) {
                selection_++;
                mainMenu();
            }
            break;
        case D:
            currentState_ = Idle;
            idleScreen();
            break;
        case None: 
            break;
        }
        break;
    case Browse:
        switch (button()) {
        case A:
            if (selectedTrain_ != trainsByID_.begin()) {
                selectedTrain_--;
                BrowseScreen();
            }
            break;
        case B:
            AcquireTrain(selectedTrain_->first);
            currentState_ = Idle;
            idleScreen();
            break;
        case C:
            selectedTrain_++;
            if (selectedTrain_ == trainsByID_.end()) selectedTrain_--;
            BrowseScreen();
            break;
        case D:
            currentState_ = MainMenu;
            mainMenu();
            break;
        }
        break;
    case Search:
        switch (button()) {
        case A:
            if (letterIndex_ > 0) {
                unHighlightLetter();
                letterIndex_--;
                highlightLetter();
                display_.display();
            }
            break;
        case B:
            if (letterIndex_ == 39) // backspace
            {
                if (searchStringIndex_ > 0) {
                    searchString_[searchStringIndex_] = '_';
                    unHighlightChar();
                    searchStringIndex_--;
                    highlightChar();
                    display_.display();
                }
            } else if (searchStringIndex_ < 20) {
                char ch;
                if (letterIndex_ < 26) ch = 'A' + letterIndex_;
                else if (letterIndex_ < 36) ch = '0' + (letterIndex_-26); 
                else if (letterIndex_ == 36) ch = ' ';
                else if (letterIndex_ == 37) ch = '-';
                else if (letterIndex_ == 38) ch = '.';
                searchString_[searchStringIndex_] = ch;
                unHighlightChar();
                searchStringIndex_++;
                highlightChar();
                display_.display();
            }
            break;
        case C:
            if (letterIndex_ < 39) {
                unHighlightLetter();
                letterIndex_++;
                highlightLetter();
                display_.display();
            }
            break;
        case D:
            for (selectedTrain_ = trainsByID_.begin();
                 selectedTrain_ != trainsByID_.end();
                 selectedTrain_++) {
                if (match_(selectedTrain_->second)) break;
            }
            if (selectedTrain_ != trainsByID_.end()) 
            {
                AcquireTrain(selectedTrain_->first);
                currentState_ = Idle;
                idleScreen();
            }
            break;
        }
        break;
    case Settings:
        switch (button()) {
        case A: 
            if (updateSetting_) {
                switch (selection_) {
                case ENTROPYFACTOR: 
                    if (entropyFactor_ > 1) entropyFactor_--;
                    break;
                case ACCELERATIONFACTOR:
                    if (accelerationFactor_ > 1) accelerationFactor_--;
                    break;
                case BRAKEFACTOR:
                    if (brakeFactor_ > 1) brakeFactor_--;
                    break;
                case MAXIMUMSPEED:
                    if (maximumSpeed_ > 1) maximumSpeed_--;
                    break;
                }
            } else {
                if (selection_ > _SETTINGSMIN) selection_--;
            }
            break;
        case B:
            updateSetting_ = !updateSetting_;
            break;
        case C:
            if (updateSetting_) {
                switch (selection_) {
                case ENTROPYFACTOR: 
                    if (entropyFactor_ < 255) entropyFactor_++;
                    break;
                case ACCELERATIONFACTOR:
                    if (accelerationFactor_ < 255) accelerationFactor_++;
                    break;
                case BRAKEFACTOR:
                    if (brakeFactor_ < 255) brakeFactor_++;
                    break;
                case MAXIMUMSPEED:
                    if (maximumSpeed_ < 255) maximumSpeed_++;
                    break;
                }
            } else {
                if (selection_ < _SETTINGSMAX) selection_++;
            }
            break;
        case D:
            selection_ = SETTINGS;
            currentState_ = MainMenu;
            mainMenu();
            break;
        }
        break;
    }
}

void ESP32ControlStand::welcomeScreen()
{
    display_.clearDisplay();
    display_.setTextSize(2);
    display_.setTextColor(WHITE); // Draw white text
    display_.setCursor(0,0);
    display_.println("Welcome");
    display_.setTextSize(1);
    openlcb::NodeID address = throttle_node()->node_id();
    uint8_t addressbytes[6];
    addressbytes[0] = (address >> 40) & 0x0FF;
    addressbytes[1] = (address >> 32) & 0x0FF;
    addressbytes[2] = (address >> 24) & 0x0FF;
    addressbytes[3] = (address >> 16) & 0x0FF;
    addressbytes[4] = (address >>  8) & 0x0FF;
    addressbytes[5] = (address >>  0) & 0x0FF;
    display_.println(mac_to_string(addressbytes,true).c_str());
    display_.println("Any button => menu.");
    //                123456789012345678901
    display_.display(); 
}

void ESP32ControlStand::idleScreen()
{
    display_.clearDisplay();
    if (currentTrain == 0) {
        display_.setTextSize(2);
        display_.setTextColor(WHITE); // Draw white text
        display_.setCursor(0,0);
        display_.println("IDLING");
        display_.setTextSize(1);
        openlcb::NodeID address = throttle_node()->node_id();
        uint8_t addressbytes[6];
        addressbytes[0] = (address >> 40) & 0x0FF;
        addressbytes[1] = (address >> 32) & 0x0FF;
        addressbytes[2] = (address >> 24) & 0x0FF;
        addressbytes[3] = (address >> 16) & 0x0FF;
        addressbytes[4] = (address >>  8) & 0x0FF;
        addressbytes[5] = (address >>  0) & 0x0FF;
        display_.println(mac_to_string(addressbytes,true).c_str());
    } else {
        load_speed_from_train_node();
        display_.setTextSize(1);
        display_.setTextColor(WHITE); // Draw white text
        display_.setCursor(0,0);
        display_.println("LOCOMOTIVE");
        display_.println(trainsByID_[currentTrain].c_str());
        uint8_t addressbytes[6];
        addressbytes[0] = (currentTrain >> 40) & 0x0FF;
        addressbytes[1] = (currentTrain >> 32) & 0x0FF;
        addressbytes[2] = (currentTrain >> 24) & 0x0FF;
        addressbytes[3] = (currentTrain >> 16) & 0x0FF;
        addressbytes[4] = (currentTrain >>  8) & 0x0FF;
        addressbytes[5] = (currentTrain >>  0) & 0x0FF;
        display_.println(mac_to_string(addressbytes,true).c_str());
        display_.print(get_speed().mph());
        display_.print("MPH");
        if (get_speed().direction() == openlcb::Velocity::FORWARD) {
            display_.println(" FWD");
        } else {
            display_.println(" REV");
        }
    }
    display_.println("Any button => menu.");
    //                123456789012345678901
    display_.display();
}

void ESP32ControlStand::mainMenu()
{
    display_.clearDisplay();
    display_.setTextColor(WHITE); // Draw white text
    display_.setTextSize(1);
    display_.setCursor(0,0);
    if (selection_ == BROWSELOCOS)
        display_.println(">>Browse Trains");
    else
        display_.println("  Browse Trains");
    if (selection_ == SEARCHFORLOCO)
        display_.println(">>Search Trains");
    else
        display_.println("  Search Trains");
    if (selection_ == SETTINGS)
        display_.println(">>Settings");
    else
        display_.println("  Settings");
    display_.println("Prev Sele Next Back");
    display_.display();
}

void ESP32ControlStand::BrowseScreen()
{
    display_.clearDisplay();
    display_.setTextColor(WHITE); // Draw white text 
    display_.setTextSize(1);
    display_.setCursor(0,0);
    TrainIDMap::const_iterator iTrain = selectedTrain_;
    if (iTrain != trainsByID_.begin()) iTrain--;
    for (int i = 0; i++; i < 3) {
        if (iTrain == selectedTrain_) display_.print(">>");
        else display_.print("  ");
        if (iTrain != trainsByID_.end()) 
            display_.println(iTrain->second.c_str());
        else display_.println("");
    }
    display_.println("Prev Sele Next Back");
    display_.display();
}

void ESP32ControlStand::SearchScreen()
{
    display_.clearDisplay();
    display_.setTextColor(WHITE); // Draw white text
    display_.setTextSize(1);
    display_.setCursor(0,0);
    display_.println("____________________");
    searchStringIndex_ = 0;
    letterIndex_ = 0;
    for (int i=0; i < 20; i++) searchString_[i] = '_';
    searchString_[20] = '\0';
    display_.println("ABCDEFGHIJKLMNOPQRST");
    display_.println("UVWXYZ0123456789 -.<");
    display_.println("Prev Sele Next Sear");
    highlightChar();
    highlightLetter();
    display_.display();
}

void ESP32ControlStand::SettingsScreen()
{
    display_.clearDisplay();
    display_.setTextColor(WHITE); // Draw white text
    display_.setTextSize(1);
    display_.setCursor(0,0);
    if (selection_ < MAXIMUMSPEED) {
        if (selection_ == ENTROPYFACTOR) {
            if (updateSetting_) display_.print("**Entropy: ");
            else display_.print(">>Entropy: ");
        } else {
            display_.print("  Entropy: ");
        }
        display_.println(entropyFactor_);
        if (selection_ == ACCELERATIONFACTOR) {
            if (updateSetting_) display_.print("**Acceler: ");
            else display_.print(">>Acceler: ");
        } else {
            display_.print("  Acceler: ");
        }
        display_.println(accelerationFactor_);
        if (selection_ == BRAKEFACTOR) {
            if (updateSetting_) display_.print("**Brake:   ");
            else display_.print(">>Brake:   ");
        } else {
            display_.print("  Brake:   ");
        }
        display_.println(brakeFactor_);
    } else {
        if (selection_ == ACCELERATIONFACTOR) {
            if (updateSetting_) display_.print("**Acceler: ");
            else display_.print(">>Acceler: ");
        } else {
            display_.print("  Acceler: ");
        }
        display_.println(accelerationFactor_);
        if (selection_ == BRAKEFACTOR) {
            if (updateSetting_) display_.print("**Brake:   ");
            else display_.print(">>Brake:   ");
        } else {
            display_.print("  Brake:   ");
        }
        display_.println(brakeFactor_);
        if (selection_ == MAXIMUMSPEED) {
            if (updateSetting_) display_.print("**MxSpeed: ");
            else display_.print(">>MxSpeed: ");
        } else {
            display_.print("  MxSpeed: ");
        }
        display_.println(maximumSpeed_);
    }
    if (updateSetting_) display_.println("++++ Done ---- Back");
    else                display_.println("Prev Sele Next Back");
}

void ESP32ControlStand::register_handler()
{
    openlcb::EventRegistry::instance()->register_handler(
            openlcb::EventRegistryEntry(this, 
                                        openlcb::TractionDefs::IS_TRAIN_EVENT),
                                        0);
                                                         
}

void ESP32ControlStand::unregister_handler()
{
    openlcb::EventRegistry::instance()->unregister_handler(this);
}
void ESP32ControlStand::handle_event_report(const openlcb::EventRegistryEntry &entry, 
                                            EventReport *event,
                                            BarrierNotifiable *done)
{
    if (event->dst_node && event->dst_node != throttle_node())
    {
        done->notify();
        return;
    }
    done->notify();
    if (event->event == openlcb::TractionDefs::IS_TRAIN_EVENT)
        AddTrain(event->src_node);
}
 
void ESP32ControlStand::handle_identify_global(const openlcb::EventRegistryEntry &registry_entry, 
                                               EventReport *event, BarrierNotifiable *done)
{
    if (event->dst_node && event->dst_node != throttle_node())
    {
        done->notify();
        return;
    }
    done->notify();
    if (event->event == openlcb::TractionDefs::IS_TRAIN_EVENT)
        AddTrain(event->src_node);
}

void ESP32ControlStand::handle_producer_identified(const openlcb::EventRegistryEntry &entry,
                                                   EventReport *event,
                                                   BarrierNotifiable *done)
{
    if (event->dst_node && event->dst_node != throttle_node())
    {
        done->notify();
        return;
    }
    done->notify();
    if (event->event == openlcb::TractionDefs::IS_TRAIN_EVENT)
        AddTrain(event->src_node);
}



