// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Jul 31 11:42:50 2017
//  Last Modified : <170802.0831>
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

#ifndef __CONTROLSTANDREPORT_H
#define __CONTROLSTANDREPORT_H

#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_MCP23008.h>

class _debouncedSwitchMomentary {
public:
    _debouncedSwitchMomentary() {}
    _debouncedSwitchMomentary(int pin);
    bool On();
    bool Off();
private:
    int switchPin;
    int switchState;
    int lastSwitchState;
    long lastDebounceTime;
    long debounceDelay;
    int checkstate();
};

class _debouncedSwitchNonMomentary {
public:
    _debouncedSwitchNonMomentary() {}
    _debouncedSwitchNonMomentary(int pin);
    bool On();
    bool Off();
private:
    int switchPin;
    int switchState;
    int lastSwitchState;
    long lastDebounceTime;
    long debounceDelay;
    int checkstate();
};

class ControlStandReport {
    enum Commands {READ='R', HELP='H'};
    enum Inputs {THROTTLE=A0, AUTOBRAKE=A1, INDBRAKE=A2, REVERSER=A3,
              USELUP=2, USELDOWN=3, HORN=4, USELD0=5, USELD1=6, USELD2=7};
    
private:
    Adafruit_MCP23008 *mcp;
    unsigned short throttle;
    unsigned short autobrake;
    unsigned short indbrake;
    unsigned short reverser;
    _debouncedSwitchMomentary uselup;
    _debouncedSwitchMomentary useldown;
    enum {Brake=-1, Off=0, U1=1, U2=2, U3=3, U4=4, U5=5} unitSelect;
    _debouncedSwitchNonMomentary horn;
    static const char *HelpText[];
    
public:
    ControlStandReport();
    void ProcessSerialCLI();
    void ReadControls();
    void SetMcp(Adafruit_MCP23008 *_mcp) {mcp = _mcp;}
    Adafruit_MCP23008 *GetMcp() {return mcp;}
};



#endif // __CONTROLSTANDREPORT_H

