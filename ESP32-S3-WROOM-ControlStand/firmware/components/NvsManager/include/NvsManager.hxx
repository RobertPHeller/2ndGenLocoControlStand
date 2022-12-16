// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Fri Dec 16 10:47:59 2022
//  Last Modified : <221216.1052>
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

#ifndef __NVSMANAGER_HXX
#define __NVSMANAGER_HXX

namespace openlcb
{
    class Node;
    class SimpleStackBase;
}
namespace openmrn_arduino
{
    class Esp32WiFiManager;
}

namespace esp32s3controlstand {

class NvsManager : public Singleton<NvsManager>
{
public:
    void init(uint8_t reset_reason);
    bool should_reset_config();
    bool should_reset_events();
    bool start_stack();
    void force_factory_reset();
    void force_reset_events();
    
    uint64_t node_id();
    void node_id(uint64_t node_id);
    wifi_mode_t wifi_mode();
    void wifi_mode(wifi_mode_t mode);
    const char *station_ssid();
    const char *station_password();
    const char *hostname_prefix();
};

}
#endif // __NVSMANAGER_HXX

