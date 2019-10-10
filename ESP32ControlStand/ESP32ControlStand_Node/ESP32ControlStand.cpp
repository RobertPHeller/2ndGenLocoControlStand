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
//  Last Modified : <191010.0954>
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
        for(;;); // Don't proceed, loop forever
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
    pinMode(STATUS_R,OUTPUT);
    digitalWrite(STATUS_R,LOW);
    pinMode(STATUS_G,OUTPUT);
    digitalWrite(STATUS_G,LOW);
    pinMode(THROTTLEA,INPUT_PULLUP);
    pinMode(THROTTLEB,INPUT_PULLUP);
    throttleQuadrature_ = digitalRead(THROTTLEA) | (digitalRead(THROTTLEB) << 1);
}

void ESP32ControlStand::poll_33hz(openlcb::WriteHelper *helper, Notifiable *done)
{
    if (checkThrottle() || readBrake() || readHorn() || 
        readReverser() || (bell_.read(), bell_.has_changed()) ||
        (lightSwitch_.read(), lightSwitch_.has_changed()))
    {
        // Update train
    }
    pollMenu();  // Other tasks
}

void ESP32ControlStand::idleScreen()
{
}

void ESP32ControlStand::mainMenu()
{
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
        break;
    case Search:
        break;
    case Settings:
        break;
    case Status:
        break;
    case RunLoco:
        break;
    }
}

void ESP32ControlStand::welcomeScreen()
{
    display_.clearDisplay();
    display_.setTextSize(2);
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



