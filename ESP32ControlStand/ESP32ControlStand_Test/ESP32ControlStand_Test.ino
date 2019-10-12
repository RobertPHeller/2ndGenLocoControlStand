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
//  Last Modified : <191012.1543>
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
#define STATUS_G  32
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

Adafruit_MCP23017 mcp;

uint8_t throttlePosition = 0;
uint8_t throttleQuadrature;

void checkThrottle()
{
    uint8_t newQuadrature;
    newQuadrature = digitalRead(THROTTLEA) | (digitalRead(THROTTLEB) << 1);
    uint8_t quadratureUp[] = {1, 3, 0, 2};
    uint8_t quadratureDown[] = {2, 0, 3, 1};
    if (newQuadrature != throttleQuadrature)
    {
        if (newQuadrature == quadratureUp[throttleQuadrature & 0x03])
        {
            if (throttlePosition > 0)
                throttlePosition--;
        }
        else if (newQuadrature == quadratureDown[throttleQuadrature & 0x03])
        {
            if (throttlePosition < 8)
                throttlePosition++;
        }
        else
            throttlePosition = 0;
    }
    throttleQuadrature = newQuadrature & 0x03;
}

uint16_t readBrake() {
    return analogRead(BRAKE);
}

uint16_t readHorn() {
    return analogRead(HORN);
}

uint16_t readReverser() {
    return analogRead(REVERSER);
}

uint8_t StatusColor = 1;

uint8_t LedNumber = -1;

uint16_t LedUpdateCount = 100;

static const char rcsid[] = "@(#) : $Id$";

void setup() {
    // put your setup code here, to run once:
    Serial.begin(9600);
    
    // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
    if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) { // Address 0x3C for 128x32
        Serial.println(F("SSD1306 allocation failed"));
        for(;;); // Don't proceed, loop forever
    }
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
    mcp.begin();
    for (int i=0; i< 8; i++) {
        mcp.pinMode(i,OUTPUT);  // LED i
        mcp.digitalWrite(i,LOW);
        mcp.pinMode(i+8,INPUT_PULLUP); // Button i
    }
    // Show initial display buffer contents on the screen --
    // the library initializes this with an Adafruit splash screen.
    display.display();
    delay(2000); // Pause for 2 seconds
    
    // Clear the buffer
    display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(WHITE);
    display.cp437(true);
}
                
void loop() {
    // put your main code here, to run repeatedly:
    if (LedUpdateCount >= 100) {
        if (LedNumber >= 0) {
            mcp.digitalWrite(LedNumber,LOW);
        }
        LedNumber++;
        if (LedNumber >= 8) LedNumber = 0;
        mcp.digitalWrite(LedNumber,HIGH);
        switch (StatusColor) {
        case 0:
            digitalWrite(STATUS_R,LOW);
            digitalWrite(STATUS_G,LOW);
            break;
        case 1:
            digitalWrite(STATUS_R,HIGH);
            digitalWrite(STATUS_G,LOW);
            break;
        case 2:
            digitalWrite(STATUS_R,LOW);
            digitalWrite(STATUS_G,HIGH);
            break;
        case 3:
            digitalWrite(STATUS_R,HIGH);
            digitalWrite(STATUS_G,HIGH);
            break;
        }
        StatusColor++;
        if (StatusColor > 3) StatusColor = 0;
        LedUpdateCount = 0;
    }
    display.clearDisplay();
    display.setCursor(0, 0);
    checkThrottle();
    display.print("Throttle: ");display.println(throttlePosition);
    display.print("Brake:    ");display.println(readBrake());
    display.print("Horn:     ");display.println(readHorn());
    display.print("Reverser: ");display.println(readReverser());
    display.display();
    LedUpdateCount++;
    delay(10);
}    
