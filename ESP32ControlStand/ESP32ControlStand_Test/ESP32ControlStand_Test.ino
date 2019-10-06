// -!- C++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Sun Oct 6 09:53:58 2019
//  Last Modified : <191006.1024>
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

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Adafruit_MCP23017.h>

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
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);



static const char rcsid[] = "@(#) : $Id$";

void setup() {
    // put your setup code here, to run once:
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
    pinMode(L_OFF,INPUT_PULLUP);
    pinMode(L_DIM,INPUT_PULLUP);
    pinMode(L_BRIGHT,INPUT_PULLUP);
    pinMode(L_DITCH,INPUT_PULLUP);
}
                
void loop() {
    // put your main code here, to run repeatedly:
}    
