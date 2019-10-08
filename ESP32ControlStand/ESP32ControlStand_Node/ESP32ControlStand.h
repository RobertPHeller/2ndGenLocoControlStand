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
//  Last Modified : <191008.1105>
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

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Button.h>
#include <OpenMRNLite.h>
#include "openlcb/TractionThrottle.hxx"
#include "openlcb/RefreshLoop.hxx"

#define HORN      A0
#define BRAKE     A3
#define BUTTON_A  34
#define BUTTON_B  35
#define BUTTON_C  33
#define BUTTON_D  25
#define BELL      26
#define REVERSER  A17
#define STATUS_R  12
#define STATUS_G  13
#define THROTTLEA 22
#define THROTTLEB 19
#define L_OFF     18
#define L_DIM     17
#define L_BRIGHT  16
#define L_DITCH    0

class LightSwitch {
public:
    enum Position {Unknown=0, Off, Dim, Bright, Ditch};
    LightSwitch(uint8_t offPin, uint8_t dimPin, uint8_t brightPin, uint8_t ditchPin);
    void begin();
    Position read();
    bool has_changed();
    bool isOff();
    bool isDim();
    bool isBright();
    bool isDitch();
private:
    uint8_t _offPin, _dimPin, _brightPin, _ditchPin;
    uint16_t _delay;
    Position _state;
    bool     _has_changed;
    uint32_t _ignore_until;
};

class ESP32ControlStand : public openlcb::TractionThrottle, public openlcb::Polling {
public:
    ESP32ControlStand(openlcb::Node *node, Adafruit_GFX *display) 
                : TractionThrottle(node)
          , display_(display)
          , a_(BUTTON_A)
          , b_(BUTTON_B)
          , c_(BUTTON_C)
          , d_(BUTTON_D)
          , bell_(BELL)
          , lightSwitch_(L_OFF,L_DIM,L_BRIGHT,L_DITCH)
          , throttlePosition_(0)
          , brake_(0)
          , horn_(0)
          , reverser_(0)
    { }
    void hw_init();
    void poll_33hz(openlcb::WriteHelper *helper, Notifiable *done) OVERRIDE;
private:
    Adafruit_GFX *display_;
    Button a_;
    Button b_;
    Button c_;
    Button d_;
    Button bell_;
    LightSwitch lightSwitch_;
    uint8_t throttlePosition_;
    uint8_t throttleQuadrature_;
    uint16_t brake_;
    uint16_t horn_;
    uint16_t reverser_;
    bool checkThrottle();
    bool readBrake();
    bool readHorn();
    bool readReverser();
};

#endif // __ESP32CONTROLSTAND_H

