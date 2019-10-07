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
//  Last Modified : <191007.1907>
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
#include <OpenMRNLite.h>
#include "openlcb/TractionThrottle.hxx"
#include "openlcb/RefreshLoop.hxx"
#include "ESP32ControlStand.h"

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


uint8_t ESP32ControlStand::checkThrottle()
{
    uint8_t newQuadrature;
    newQuadrature = digitalRead(THROTTLEA) | (digitalRead(THROTTLEB) << 1);
    uint8_t quadratureUp[] = {1, 3, 0, 2};
    uint8_t quadratureDown[] = {2, 0, 3, 1};
    if (newQuadrature != throttleQuadrature_)
    {
        if (newQuadrature == quadratureUp[throttleQuadrature & 0x03])
        {
            if (throttlePosition_ > 0)
                throttlePosition_--;
        }
        else if (newQuadrature == quadratureDown[throttleQuadrature & 0x03])
        {
            if (throttlePosition_ < 8)
                throttlePosition_++;
        }
        else
            throttlePosition_ = 0;
    }
    throttleQuadrature_ = newQuadrature & 0x03;
    return throttlePosition_;
}

uint16_t ESP32ControlStand::readBrake() {
    return analogRead(BRAKE);
}

uint16_t ESP32ControlStand::readHorn() {
    return analogRead(HORN);
}

uint16_t ESP32ControlStand::readReverser() {
    return analogRead(REVERSER);
}
void ESP32ControlStand::hw_init()
{
    pinMode(HORN,INPUT);
    pinMode(BRAKE,INPUT);
    pinMode(BUTTON_A,INPUT_PULLUP);
    pinMode(BUTTON_B,INPUT_PULLUP);
    pinMode(BUTTON_C,INPUT_PULLUP);
    pinMode(BUTTON_D,INPUT_PULLUP);
    pinMode(BELL,INPUT_PULLUP);
    pinMode(REVERSER,INPUT);
    pinMode(STATUS_R,OUTPUT);
    digitalWrite(STATUS_R,LOW);
    pinMode(STATUS_G,OUTPUT);
    digitalWrite(STATUS_G,LOW);
    pinMode(THROTTLEA,INPUT_PULLUP);
    pinMode(THROTTLEB,INPUT_PULLUP);
    throttleQuadrature = digitalRead(THROTTLEA) | (digitalRead(THROTTLEB) << 1);
    pinMode(L_OFF,INPUT_PULLUP);
    pinMode(L_DIM,INPUT_PULLUP);
    pinMode(L_BRIGHT,INPUT_PULLUP);
    pinMode(L_DITCH,INPUT_PULLUP);
}
