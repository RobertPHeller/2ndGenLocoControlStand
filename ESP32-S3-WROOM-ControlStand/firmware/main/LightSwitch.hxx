// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Tue Oct 8 21:09:24 2019
//  Last Modified : <221215.1159>
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

#ifndef __LIGHTSWITCH_H
#define __LIGHTSWITCH_H

#include <os/Gpio.hxx> 


class LightSwitch {
public:
    enum Position {Unknown=0, Off, Dim, Bright, Ditch};
    LightSwitch(const Gpio *offPin, const Gpio *dimPin, const Gpio *brightPin, 
                const Gpio *ditchPin);
    Position read();
    bool has_changed();
    bool isOff();
    bool isDim();
    bool isBright();
    bool isDitch();
private:
    const Gpio *_offPin, *_dimPin, *_brightPin, *_ditchPin;
    uint16_t _delay;
    Position _state;
    bool     _has_changed;
    uint32_t _ignore_until;
};



#endif // __LIGHTSWITCH_H

