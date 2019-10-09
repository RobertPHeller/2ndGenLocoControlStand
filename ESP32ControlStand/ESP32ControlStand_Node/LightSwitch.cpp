// -!- C++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Tue Oct 8 21:09:53 2019
//  Last Modified : <191008.2110>
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
#include "LightSwitch.h"

LightSwitch::LightSwitch(uint8_t offPin, uint8_t dimPin, uint8_t brightPin, uint8_t ditchPin)
      : _offPin(offPin)
, _dimPin(dimPin)
, _brightPin(brightPin)
, _ditchPin(ditchPin)
,  _delay(500)
, _state(Unknown)
, _ignore_until(0)
, _has_changed(false)
{
}

void LightSwitch::begin()
{
    pinMode(_offPin, INPUT_PULLUP);
    pinMode(_dimPin, INPUT_PULLUP);
    pinMode(_brightPin, INPUT_PULLUP);
    pinMode(_ditchPin, INPUT_PULLUP);
}

LightSwitch::Position LightSwitch::read()
{
    if (_ignore_until > millis())
    {
    }
    else {
        switch (_state) {
        case Unknown: // no previous state -- get initial state.
            _ignore_until = millis() + _delay;
            if (digitalRead(_offPin) == LOW)
                _state = Off;
            else if (digitalRead(_dimPin) == LOW)
                _state = Dim;
            else if (digitalRead(_brightPin) == LOW)
                _state = Bright;
            else if (digitalRead(_ditchPin) == LOW)
                _state = Ditch;
            break;
        case Off:
            if (digitalRead(_dimPin) == LOW)
                _state = Dim;
            else if (digitalRead(_brightPin) == LOW)
                _state = Bright;
            else if (digitalRead(_ditchPin) == LOW)
                _state = Ditch;
            else 
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                
        case Dim:
            if (digitalRead(_offPin) == LOW)
                _state = Off;
            else if (digitalRead(_brightPin) == LOW)
                _state = Bright;
            else if (digitalRead(_ditchPin) == LOW)
                _state = Ditch;
            else
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                                  
        case Bright:
            if (digitalRead(_offPin) == LOW)
                _state = Off;
            else if (digitalRead(_dimPin) == LOW)
                _state = Dim;
            else if (digitalRead(_ditchPin) == LOW)
                _state = Ditch;
            else
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                                  
        case Ditch:
            if (digitalRead(_offPin) == LOW)
                _state = Off;
            else if (digitalRead(_dimPin) == LOW)
                _state = Dim;
            else if (digitalRead(_brightPin) == LOW)
                _state = Bright;
            else
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                                  
        }
    }
    return _state;
}

bool LightSwitch::has_changed()
{
    if (_has_changed == true)
    {
        _has_changed = false;
        return true;
    }
    return false;
}

