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
//  Last Modified : <191008.2246>
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
#include "LightSwitch.h"

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

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 32 // OLED display height, in pixels

// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
#define OLED_RESET     -1 // Reset pin # (or -1 if sharing Arduino reset pin)

class ESP32ControlStand : public openlcb::TractionThrottle, public openlcb::Polling {
public:
    enum Pressed {None=0, A, B, C, D};
    ESP32ControlStand(openlcb::Node *node) 
                : TractionThrottle(node)
          , display_(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET)
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
    Adafruit_SSD1306 display_;
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
    void pollMenu();
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
    void welcomeScreen();
};

#endif // __ESP32CONTROLSTAND_H

