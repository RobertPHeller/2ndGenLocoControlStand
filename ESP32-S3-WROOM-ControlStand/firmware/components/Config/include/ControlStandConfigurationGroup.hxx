// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Fri Dec 16 12:31:11 2022
//  Last Modified : <221216.1232>
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

#ifndef __CONTROLSTANDCONFIGURATIONGROUP_HXX
#define __CONTROLSTANDCONFIGURATIONGROUP_HXX

#include "openlcb/ConfigRepresentation.hxx"

/// CDI Configuration for a @ref ESP32ControlStand
CDI_GROUP(ESP32ControlStandConfig)
CDI_GROUP_ENTRY(entropy,openlcb::Uint8ConfigEntry,
                Name("Entropy Factor"),Default(1)); // about 2 scale mph
CDI_GROUP_ENTRY(acceleration,openlcb::Uint8ConfigEntry,
                Name("Acceleration Factor"),Default(1)); // about 2 scale mph
CDI_GROUP_ENTRY(brake,openlcb::Uint8ConfigEntry,
                Name("Brake Factor"),Default(1)); // about 2 scale mph
CDI_GROUP_ENTRY(maximumspeed,openlcb::Uint8ConfigEntry,
                Name("Maximum Speed"),Default(45)); // about 100 scale MPH
CDI_GROUP_END();
                


#endif // __CONTROLSTANDCONFIGURATIONGROUP_HXX

