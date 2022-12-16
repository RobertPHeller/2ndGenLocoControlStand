// -!- C++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Wed Dec 14 12:04:05 2022
//  Last Modified : <221214.1211>
//
//  Description	
//
//  Notes
//
//  History
//	
/////////////////////////////////////////////////////////////////////////////
//
//    Copyright (C) 2022  Robert Heller D/B/A Deepwoods Software
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
#include "Button.hxx"

inline static unsigned long millis()
{
    return (unsigned long) (esp_timer_get_time() / 1000ULL);
}

Button::Button(const Gpio *pin)
:  _pin(pin)
,  _delay(500)
,  _state(Gpio::VHIGH)
,  _has_changed(false)
,  _ignore_until(0)
{
}

// 
// public methods
// 

bool Button::read()
{
	// ignore pin changes until after this delay time
	if (_ignore_until > millis())
	{
		// ignore any changes during this period
	}
	
	// pin has changed 
	else if (_pin->read() != _state)
	{
		_ignore_until = millis() + _delay;
		_state = !_state;
		_has_changed = true;
	}
	
	return _state;
}

// has the button been toggled from on -> off, or vice versa
bool Button::toggled()
{
	read();
	return has_changed();
}

// mostly internal, tells you if a button has changed after calling the read() function
bool Button::has_changed()
{
	if (_has_changed == true)
	{
		_has_changed = false;
		return true;
	}
	return false;
}

// has the button gone from off -> on
bool Button::pressed()
{
	if (read() == PRESSED && has_changed() == true)
		return true;
	else
		return false;
}

// has the button gone from on -> off
bool Button::released()
{
	if (read() == RELEASED && has_changed() == true)
		return true;
	else
		return false;
}
