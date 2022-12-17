// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Dec 12 14:57:27 2022
//  Last Modified : <221217.1137>
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

#ifndef __CDI_HXX
#define __CDI_HXX
#include "sdkconfig.h"

#include "NodeIdConfigurationGroup.hxx"
#include "WiFiConfigurationGroup.hxx"
#include "ControlStandConfigurationGroup.hxx"
#include "openlcb/ConfiguredConsumer.hxx"
#include "openlcb/ConfiguredProducer.hxx"
#include "openlcb/ConfigRepresentation.hxx"
#include "openlcb/MemoryConfig.hxx"

namespace esp32s3controlstand
{
constexpr uint8_t NUM_OUTPUTS = 8;
constexpr uint8_t NUM_INPUTS = 8;
using AllConsumers = openlcb::RepeatedGroup<openlcb::ConsumerConfig, NUM_OUTPUTS>;
using AllProducers = openlcb::RepeatedGroup<openlcb::ProducerConfig, NUM_INPUTS>;
CDI_GROUP(mcpConfiguration);
CDI_GROUP_ENTRY(consumers, AllConsumers, Name("LEDS"), RepName("Led"));
CDI_GROUP_ENTRY(producers, AllProducers, Name("Buttons"), RepName("Button"));
CDI_GROUP_END();

/// Modify this value every time the EEPROM needs to be cleared on the node
/// after an update.
static constexpr uint16_t CANONICAL_VERSION = 0x1000;

/// Defines the main segment in the configuration CDI. This is laid out at
/// origin 128 to give space for the ACDI user data at the beginning.
CDI_GROUP(IoBoardSegment, Segment(openlcb::MemoryConfigDefs::SPACE_CONFIG), Offset(128));
/// Each entry declares the name of the current entry, then the type and then
/// optional arguments list.
CDI_GROUP_ENTRY(internal_config, openlcb::InternalConfigData);
#if defined(CONFIG_IO_BUTTON_LED_BOARD_1)
CDI_GROUP_ENTRY(mcp0,mcpConfiguration,Name("MCP23017 #1 Configuration"));
#endif
#if defined(CONFIG_IO_BUTTON_LED_BOARD_2)
CDI_GROUP_ENTRY(mcp1,mcpConfiguration,Name("MCP23017 #2 Configuration"));
#endif
CDI_GROUP_ENTRY(controlstand,ESP32ControlStandConfig,Name("ESP32 Control Stand Configuration"));
CDI_GROUP_END();
/// This segment is only needed temporarily until there is program code to set
/// the ACDI user data version byte.
CDI_GROUP(VersionSeg, Segment(openlcb::MemoryConfigDefs::SPACE_CONFIG),
          Name("Version information"));
CDI_GROUP_ENTRY(acdi_user_version, openlcb::Uint8ConfigEntry,
                Name("ACDI User Data version"), Description("Set to 2 and do not change."));
CDI_GROUP_END();

/// The main structure of the CDI. ConfigDef is the symbol we use in main.cxx
/// to refer to the configuration defined here.
CDI_GROUP(ConfigDef, MainCdi());
/// Adds the <identification> tag with the values from SNIP_STATIC_DATA above.
CDI_GROUP_ENTRY(ident, openlcb::Identification);
/// Adds an <acdi> tag.
CDI_GROUP_ENTRY(acdi, openlcb::Acdi);
/// Adds a segment for changing the values in the ACDI user-defined
/// space. UserInfoSegment is defined in the system header.
CDI_GROUP_ENTRY(userinfo, openlcb::UserInfoSegment,Name("User Info"));
/// Adds the main configuration segment.
CDI_GROUP_ENTRY(seg, IoBoardSegment,Name("General Configuration Settings"));
CDI_GROUP_ENTRY(node, NodeIdConfig, Name("Node ID"));
#if defined(CONFIG_ESP32_WIFI_ENABLED)
CDI_GROUP_ENTRY(wifi, WiFiConfiguration, Name("WiFi Configuration"));
#endif
/// Adds the versioning segment.
CDI_GROUP_ENTRY(version, VersionSeg);
CDI_GROUP_END();

}

#endif // __CDI_HXX

