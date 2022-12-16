// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Wed Dec 14 11:58:57 2022
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

#ifndef __BUTTON_HXX
#define __BUTTON_HXX

#include <os/Gpio.hxx> 

class Button
{
	public:
		Button(const Gpio *pin);
		bool read();
		bool toggled();
		bool pressed();
		bool released();
		bool has_changed();
		
		const static bool PRESSED = Gpio::VLOW;
		const static bool RELEASED = Gpio::VHIGH;
	
	private:
		const Gpio * _pin;
		uint16_t _delay;
		bool     _state;
		bool     _has_changed;
		uint32_t _ignore_until;
};


#endif // __BUTTON_HXX

