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
//  Last Modified : <221215.1230>
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

#include <freertos_drivers/esp32/Esp32WiFiConfiguration.hxx>
#include "openlcb/ConfiguredConsumer.hxx"
#include "openlcb/ConfiguredProducer.hxx"
#include "openlcb/ConfigRepresentation.hxx"
#include "openlcb/MemoryConfig.hxx"
#include "ESP32ControlStand.hxx"

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
#if defined(CONFIG_ESP32_WIFI_ENABLED)
CDI_GROUP_ENTRY(wifi, WiFiConfiguration, Name("WiFi Configuration"));
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
/// Adds the versioning segment.
CDI_GROUP_ENTRY(version, VersionSeg);
CDI_GROUP_END();

}

namespace openlcb {

extern const char CDI_DATA[];
const char CDI_DATA[] = R"xmlpayload(<?xml version="1.0" encoding="utf-8"?>
<cdi xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://openlcb.org/schema/cdi/1/1/cdi.xsd">
<identification>
<manufacturer>)xmlpayload" SNIP_PROJECT_PAGE R"xmlpayload(</manufacturer>
<model>)xmlpayload" SNIP_PROJECT_NAME R"xmlpayload(</model>
<hardwareVersion>)xmlpayload" SNIP_HW_VERSION R"xmlpayload(</hardwareVersion>
<softwareVersion>)xmlpayload" SNIP_SW_VERSION R"xmlpayload(</softwareVersion>
</identification>
<acdi/>
<segment space='251' origin='1'>
<name>User Info</name>
<string size='63'>
<name>User Name</name>
<description>This name will appear in network browsers for this device.</description>
</string>
<string size='64'>
<name>User Description</name>
<description>This description will appear in network browsers for this device.</description>
</string>
</segment>
<segment space='253' origin='128'>
<name>General Configuration Settings</name>
<group>
<name>Internal data</name>
<description>Do not change these settings.</description>
<int size='2'>
<name>Version</name>
</int>
<int size='2'>
<name>Next event ID</name>
</int>
</group>)xmlpayload"
#if defined(CONFIG_IO_BUTTON_LED_BOARD_1)
R"xmlpayload(<group>
<name>MCP23017 #1 Configuration</name>
<group replication='8'>
<name>LEDS</name>
<repname>Led</repname>
<string size='8'>
<name>Description</name>
<description>User name of this output.</description>
</string>
<eventid>
<name>Event On</name>
<description>Receiving this event ID will turn the output on.</description>
</eventid>
<eventid>
<name>Event Off</name>
<description>Receiving this event ID will turn the output off.</description>
</eventid>
</group>
<group replication='8'>
<name>Buttons</name>
<repname>Button</repname>
<string size='15'>
<name>Description</name>
<description>User name of this input.</description>
</string>
<int size='1'>
<name>Debounce parameter</name>
<description>Amount of time to wait for the input to stabilize before producing the event. Unit is 30 msec of time. Usually a value of 2-3 works well in a non-noisy environment. In high noise (train wheels for example) a setting between 8 -- 15 makes for a slower response time but a more stable signal.
Formally, the parameter tells how many times of tries, each 30 msec apart, the input must have the same value in order for that value to be accepted and the event transition produced.</description>
<default>3</default>
</int>
<eventid>
<name>Event On</name>
<description>This event will be produced when the input goes to HIGH.</description>
</eventid>
<eventid>
<name>Event Off</name>
<description>This event will be produced when the input goes to LOW.</description>
</eventid>
</group>
</group>)xmlpayload"
#endif
#if defined(CONFIG_IO_BUTTON_LED_BOARD_2)
R"xmlpayload(<group>
<name>MCP23017 #2 Configuration</name>
<group replication='8'>
<name>LEDS</name>
<repname>Led</repname>
<string size='8'>
<name>Description</name>
<description>User name of this output.</description>
</string>
<eventid>
<name>Event On</name>
<description>Receiving this event ID will turn the output on.</description>
</eventid>
<eventid>
<name>Event Off</name>
<description>Receiving this event ID will turn the output off.</description>
</eventid>
</group>
<group replication='8'>
<name>Buttons</name>
<repname>Button</repname>
<string size='15'>
<name>Description</name>
<description>User name of this input.</description>
</string>
<int size='1'>
<name>Debounce parameter</name>
<description>Amount of time to wait for the input to stabilize before producing the event. Unit is 30 msec of time. Usually a value of 2-3 works well in a non-noisy environment. In high noise (train wheels for example) a setting between 8 -- 15 makes for a slower response time but a more stable signal.
Formally, the parameter tells how many times of tries, each 30 msec apart, the input must have the same value in order for that value to be accepted and the event transition produced.</description>
<default>3</default>
</int>
<eventid>
<name>Event On</name>
<description>This event will be produced when the input goes to HIGH.</description>
</eventid>
<eventid>
<name>Event Off</name>
<description>This event will be produced when the input goes to LOW.</description>
</eventid>
</group>
</group>)xmlpayload"
#endif
#if defined(CONFIG_ESP32_WIFI_ENABLED)
R"xmlpayload(<group>
<name>WiFi Configuration</name>
<int size='1'>
<name>WiFi Power Savings Mode</name>
<description>When enabled this allows the ESP32 WiFi radio to use power savings mode which puts the radio to sleep except to receive beacon updates from the connected SSID. This should generally not need to be enabled unless you are powering the ESP32 from a battery.</description>
<min>0</min>
<max>1</max>
<default>0</default>
<map><relation><property>0</property><value>No</value></relation><relation><property>1</property><value>Yes</value></relation></map>
</int>
<int size='1'>
<name>Connection Mode</name>
<description>Defines whether to allow accepting connections (according to the Hub configuration), making a connection (according to the Uplink configuration), or both.
This setting can be set to Disabled if the ESP32 will be using the TWAI (CAN) driver instead for the connection to other nodes.
Note: it is not recommended to enable the Hub functionality on single-core ESP32 models.</description>
<min>0</min>
<max>3</max>
<default>1</default>
<map><relation><property>0</property><value>Disabled</value></relation><relation><property>1</property><value>Uplink Only</value></relation><relation><property>2</property><value>Hub Only</value></relation><relation><property>3</property><value>Hub+Uplink</value></relation></map>
</int>
<group>
<name>Hub Configuration</name>
<description>Configuration settings for an OpenLCB Hub</description>
<int size='2'>
<name>Hub Listener Port</name>
<description>Defines the TCP/IP listener port this node will use when operating as a hub. Most of the time this does not need to be changed.</description>
<min>1</min>
<max>65535</max>
<default>12021</default>
</int>
<string size='48'>
<name>mDNS Service</name>
<description>mDNS or Bonjour service name, such as _openlcb-can._tcp</description>
</string>
<group offset='6'/>
</group>
<group>
<name>Node Uplink Configuration</name>
<description>Configures how this node will connect to other nodes.</description>
<int size='1'>
<name>Search Mode</name>
<description>Defines the order of how to locate the server to connect to. 'auto' uses the mDNS protocol to find the IP address automatically. 'manual' uses the IP address entered in this settings.</description>
<min>0</min>
<max>3</max>
<default>0</default>
<map><relation><property>0</property><value>Auto, Manual</value></relation><relation><property>1</property><value>Manual, Auto</value></relation><relation><property>2</property><value>Auto Only</value></relation><relation><property>3</property><value>Manual Only</value></relation></map>
</int>
<group>
<name>Manual Address</name>
<description>Set IP address here if auto-detection does not work.</description>
<string size='32'>
<name>IP Address</name>
<description>Enter the server IP address. Example: 192.168.0.55</description>
</string>
<int size='2'>
<name>Port Number</name>
<description>TCP port number of the server. Most of the time this does not need to be changed.</description>
<min>1</min>
<max>65535</max>
<default>12021</default>
</int>
</group>
<group>
<name>Auto Address</name>
<description>Advanced settings for the server IP address auto-detection (mDNS).</description>
<string size='48'>
<name>mDNS Service</name>
<description>mDNS or Bonjour service name, such as _openlcb-can._tcp</description>
</string>
<string size='48'>
<name>Only Hostname</name>
<description>Use when multiple servers provide the same service on the network. If set, selects this specific host name; the connection will fail if none of the servers have this hostname (use correct capitalization!). Example: My JMRI Railroad</description>
</string>
</group>
<int size='1'>
<name>Reconnect</name>
<description>If enabled, tries the last known good IP address before searching for the server.</description>
<min>0</min>
<max>1</max>
<default>1</default>
<map><relation><property>0</property><value>Disabled</value></relation><relation><property>1</property><value>Enabled</value></relation></map>
</int>
<group offset='34'/>
</group>
<group offset='6'/>
</group>)xmlpayload"
#endif
R"xmlpayload(<group>
<name>ESP32 Control Stand Configuration</name>
<int size='1'>
<name>Entropy Factor</name>
<default>1</default>
</int>
<int size='1'>
<name>Acceleration Factor</name>
<default>1</default>
</int>
<int size='1'>
<name>Brake Factor</name>
<default>1</default>
</int>
<int size='1'>
<name>Maximum Speed</name>
<default>45</default>
</int>
</group>
</segment>
<segment space='253'>
<name>Version information</name>
<int size='1'>
<name>ACDI User Data version</name>
<description>Set to 2 and do not change.</description>
</int>
</segment>
</cdi>)xmlpayload";
extern const size_t CDI_SIZE;
const size_t CDI_SIZE = sizeof(CDI_DATA);
extern const uint16_t CDI_EVENT_OFFSETS[] = {
#if defined(CONFIG_IO_BUTTON_LED_BOARD_1)
    140, 148, 164, 172, 188, 196, 212, 220, 236, 244, 260, 268, 284, 292, 308,
    316, 340, 348, 372, 380, 404, 412, 436, 444, 468, 476, 500, 508, 532, 540, 
    564, 572, 
#endif
#if defined(CONFIG_IO_BUTTON_LED_BOARD_2)
    588, 596, 612, 620, 636, 644, 660, 668, 684, 692, 708, 716, 732, 740, 756, 
    764, 788, 796, 820, 828, 852, 860, 884, 892, 916, 924, 948, 956, 980, 988, 
    1012, 1020, 
#endif
    0};
} // namespace openlcb

#endif // __CDI_HXX

