//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Jul 31 11:43:58 2017
//  Last Modified : <170802.0844>
//
//  Description	
//
//  Notes
//
//  History
//	
/////////////////////////////////////////////////////////////////////////////
//
//    Copyright (C) 2017  Robert Heller D/B/A Deepwoods Software
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

#include <ControlStandReport.h>


_debouncedSwitchMomentary::_debouncedSwitchMomentary(int pin)
{
    switchPin = pin;
    lastSwitchState = HIGH;
    switchState = HIGH;
    lastDebounceTime = 0;
    debounceDelay = 200;
    pinMode(switchPin, INPUT_PULLUP);
}

bool _debouncedSwitchMomentary::On()
{
    switch (checkstate()) {
        case -1:
        case 0: return false;
        case 1: return true;
    }
    return false;
}

bool _debouncedSwitchMomentary::Off()
{
    switch (checkstate()) {
        case 1:
        case 0: return false;
        case -1: return true;
    }
    return false;
}

int _debouncedSwitchMomentary::checkstate()
{
    int result = 0;
    int reading = digitalRead(switchPin);
    if (reading != lastSwitchState) {
        lastDebounceTime = millis();
    }
    if ((((long) millis()) - lastDebounceTime) > debounceDelay) {
        if (reading != switchState) {
            switchState = reading;
            if (switchState == HIGH) {
                result = -1;
            } else {
                result = 1;
            }
        }
    }
    lastSwitchState = reading;
    return result;
}

_debouncedSwitchNonMomentary::_debouncedSwitchNonMomentary(int pin)
{
    switchPin = pin;
    lastSwitchState = HIGH;
    switchState = HIGH;
    lastDebounceTime = 0;
    debounceDelay = 200;
    pinMode(switchPin, INPUT_PULLUP);
}

bool _debouncedSwitchNonMomentary::On()
{
    checkstate();
    return (switchState != HIGH);
}

bool _debouncedSwitchNonMomentary::Off()
{
    checkstate();
    return (switchState == HIGH);
}

int _debouncedSwitchNonMomentary::checkstate()
{
    int result = 0;
    int reading = digitalRead(switchPin);
    if (reading != lastSwitchState) {
        lastDebounceTime = millis();
    }
    if ((((long) millis()) - lastDebounceTime) > debounceDelay) {
        if (reading != switchState) {
            switchState = reading;
            if (switchState == HIGH) {
                result = -1;
            } else {
                result = 1;
            }
        }
    }
    lastSwitchState = reading;
    return result;
}

const char *ControlStandReport::HelpText[] = {
    "Control Stand Report 0.0",
    "",
    "Commands:",
    "R", "  Read",
    "H", "  Print this help",
    "", NULL
};

ControlStandReport::ControlStandReport() {
    throttle = 0;
    autobrake = 0;
    indbrake = 0;
    reverser = 0;
    uselup = _debouncedSwitchMomentary(USELUP);
    useldown = _debouncedSwitchMomentary(USELDOWN);
    unitSelect = Off;
    horn = _debouncedSwitchNonMomentary(HORN);
    pinMode(USELD0,OUTPUT); digitalWrite(USELD0,LOW);
    pinMode(USELD1,OUTPUT); digitalWrite(USELD1,LOW);
    pinMode(USELD2,OUTPUT); digitalWrite(USELD2,LOW);
}

void ControlStandReport::ReadControls() {
    //char buffer[80];
    throttle = analogRead(THROTTLE);
    autobrake = analogRead(AUTOBRAKE);
    indbrake = analogRead(INDBRAKE);
    reverser = analogRead(REVERSER);
    //sprintf(buffer,"*** ControlStandReport::ReadControls(): throttle = %u",throttle);
    //Serial.println(buffer);
    //sprintf(buffer,"*** ControlStandReport::ReadControls(): autobrake = %u",autobrake);
    //Serial.println(buffer);
    //sprintf(buffer,"*** ControlStandReport::ReadControls(): indbrake = %u",indbrake);
    //Serial.println(buffer);
    //sprintf(buffer,"*** ControlStandReport::ReadControls(): reverser = %u",reverser);
    //Serial.println(buffer);
    if (uselup.On()) {
        switch (unitSelect) {
        case Brake: unitSelect = Off; break;
        case Off: unitSelect = U1; break;
        case U1: unitSelect = U2; break;
        case U2: unitSelect = U3; break;
        case U3: unitSelect = U4; break;
        case U4: unitSelect = U5; break;
        default: break;
        }
    }
    if (useldown.On()) {
        switch (unitSelect) {
        case Off: unitSelect = Brake; break;
        case U1: unitSelect = Off; break;
        case U2: unitSelect = U1; break;
        case U3: unitSelect = U2; break;
        case U4: unitSelect = U3; break;
        case U5: unitSelect = U4; break;    
        default: break;
        }
    }
    switch (unitSelect) {
    case Brake: digitalWrite(USELD0,LOW); digitalWrite(USELD1,HIGH); 
        digitalWrite(USELD2,HIGH); break;
    case Off: digitalWrite(USELD0,LOW); digitalWrite(USELD1,LOW); 
        digitalWrite(USELD2,LOW); break;
    case U1: digitalWrite(USELD0,HIGH); digitalWrite(USELD1,LOW);
        digitalWrite(USELD2,LOW); break;
    case U2:digitalWrite(USELD0,LOW); digitalWrite(USELD1,HIGH);
        digitalWrite(USELD2,LOW); break;
    case U3: digitalWrite(USELD0,HIGH); digitalWrite(USELD1,HIGH);
        digitalWrite(USELD2,LOW); break;
    case U4:digitalWrite(USELD0,LOW); digitalWrite(USELD1,LOW);
        digitalWrite(USELD2,HIGH); break;
    case U5: digitalWrite(USELD0,HIGH); digitalWrite(USELD1,LOW);
        digitalWrite(USELD2,HIGH); break;
    }
}

void ControlStandReport::ProcessSerialCLI() {
    char buffer[256];
    int len;
    Commands c;
    
    if (Serial.available() > 0) {
        //sprintf(buffer,"*** ControlStandReport::ProcessSerialCLI(): throttle = %u",throttle);
        //Serial.println(buffer);
        len = Serial.readBytesUntil('\r',buffer,sizeof(buffer)-1);
        if (len == 0) return;
        buffer[len] = '\0';
        c = (Commands) toupper(buffer[0]);
        //sprintf(buffer,"*** ControlStandReport::ProcessSerialCLI(): c = %u",c);
        //Serial.println(buffer);
        //sprintf(buffer,"*** ControlStandReport::ProcessSerialCLI(): throttle = %u",throttle);
        //Serial.println(buffer);
        switch (c) {
        case HELP:
            //Serial.println("*** ControlStandReport::ProcessSerialCLI(): case HELP");
            {
                int i, n = sizeof(HelpText) / sizeof(HelpText[0]);
                for (i = 0; i < n && HelpText[i]; i++) {
                    Serial.println(HelpText[i]);
                }
                break;
            }
        case READ:
            //Serial.println("*** ControlStandReport::ProcessSerialCLI(): case READ");
            sprintf(buffer,"THROTTLE: %u, AUTOBRAKE: %u, INDBRAKE: %u, REVERSER: %u, UNITSELECT: %d, HORN: %u",throttle,autobrake,indbrake,reverser,unitSelect,horn.On());
            Serial.println("");
            Serial.println(buffer);
            break;
        default:
            Serial.println("");
            Serial.println("Unknown Command.");
        }
        Serial.print(">>");
        Serial.flush();
    }
}

