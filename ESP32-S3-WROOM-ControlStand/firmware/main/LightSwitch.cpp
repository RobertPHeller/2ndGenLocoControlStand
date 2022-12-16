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
//  Last Modified : <221215.1054>
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

#include <os/Gpio.hxx>
#include <esp_timer.h>

#include "LightSwitch.hxx"

inline static unsigned long millis()
{
    return (unsigned long) (esp_timer_get_time() / 1000ULL);
}

LightSwitch::LightSwitch(const Gpio *offPin, const Gpio *dimPin, 
                         const Gpio *brightPin, const Gpio *ditchPin)
      : _offPin(offPin)
, _dimPin(dimPin)
, _brightPin(brightPin)
, _ditchPin(ditchPin)
,  _delay(500)
, _state(Unknown)
, _has_changed(false)
, _ignore_until(0)
{
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
            if (_offPin->read() == Gpio::VLOW)
                _state = Off;
            else if (_dimPin->read() == Gpio::VLOW)
                _state = Dim;
            else if (_brightPin->read() == Gpio::VLOW)
                _state = Bright;
            else if (_ditchPin->read() == Gpio::VLOW)
                _state = Ditch;
            break;
        case Off:
            if (_dimPin->read() == Gpio::VLOW)
                _state = Dim;
            else if (_brightPin->read() == Gpio::VLOW)
                _state = Bright;
            else if (_ditchPin->read() == Gpio::VLOW)
                _state = Ditch;
            else 
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                
        case Dim:
            if (_offPin->read() == Gpio::VLOW)
                _state = Off;
            else if (_brightPin->read() == Gpio::VLOW)
                _state = Bright;
            else if (_ditchPin->read() == Gpio::VLOW)
                _state = Ditch;
            else
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                                  
        case Bright:
            if (_offPin->read() == Gpio::VLOW)
                _state = Off;
            else if (_dimPin->read() == Gpio::VLOW)
                _state = Dim;
            else if (_ditchPin->read() == Gpio::VLOW)
                _state = Ditch;
            else
                break;
            _ignore_until = millis() + _delay;
            _has_changed = true;
            break;                                  
        case Ditch:
            if (_offPin->read() == Gpio::VLOW)
                _state = Off;
            else if (_dimPin->read() == Gpio::VLOW)
                _state = Dim;
            else if (_brightPin->read() == Gpio::VLOW)
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

