// -!- C++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Sun Oct 6 09:53:40 2019
//  Last Modified : <191007.1047>
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

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <SPIFFS.h>

#include <OpenMRNLite.h>
#include "openlcb/ConfiguredConsumer.hxx"
#include "openlcb/ConfiguredProducer.hxx"
#include "openlcb/MultiConfiguredConsumer.hxx"
#include "utils/GpioInitializer.hxx"
#include "openlcb/TractionThrottle.hxx"
#include <Adafruit_MCP23017.h>

// Configuration defines

// 1: How to connect to OpenLCB/LCC -- CAN or WiFi

// Pick an operating mode below, if you select USE_WIFI it will expose
// this node on WIFI if you select USE_CAN, this node will be available
// on CAN.
// Enabling both options will allow the ESP32 to be accessible from
// both WiFi and CAN interfaces.

#define USE_WIFI
//#define USE_CAN


// 2: Which (if any) of the MCP23017 button/LED boards is connected?
#define MCP23017_0
//#define MCP23017_1



#include "config.h"
#include "NODEID.h" // Get nodeid from an externally generated header file
#include "ArduinoExtenderGpio.h"


using mcp23017Gpio = ArduinoExtenderGpioTemplate<Adafruit_MCP23017>;


#if defined(USE_WIFI)
// Configuring WiFi accesspoint name and password
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// There are two options:
// 1) edit the sketch to set this information just below. Use quotes:
//     const char* ssid     = "linksys";
//     const char* password = "superSecret";
// 2) add a new file to the sketch folder called something.cpp with the
// following contents:
//     #include <OpenMRNLite.h>
//
//     char WIFI_SSID[] = "linksys";
//     char WIFI_PASS[] = "theTRUEsupers3cr3t";

/// This is the name of the WiFi network (access point) to connect to.
const char *ssid = WIFI_SSID;

/// Password of the wifi network.
const char *password = WIFI_PASS;

/// This is the hostname which the ESP32 will advertise via mDNS, it should be
/// unique.
const char *hostname = "esp32mrn";

// Uncomment this line to enable usage of ::select() within the Grid Connect
// code.
//OVERRIDE_CONST_TRUE(gridconnect_tcp_use_select);

#endif // USE_WIFI

#if defined(USE_CAN)
/// This is the ESP32 pin connected to the SN65HVD23x/MCP2551 R (RX) pin.
/// Recommended pins: 4, 16, 21.
/// Note: Any pin can be used for this other than 6-11 which are connected to
/// the onboard flash.
/// Note: If you are using a pin other than 4 you will likely need to adjust
/// the GPIO pin definitions for the outputs.
constexpr gpio_num_t CAN_RX_PIN = GPIO_NUM_4;

/// This is the ESP32 pin connected to the SN65HVD23x/MCP2551 D (TX) pin.
/// Recommended pins: 5, 17, 22.
/// Note: Any pin can be used for this other than 6-11 which are connected to
/// the onboard flash and 34-39 which are input only.
/// Note: If you are using a pin other than 5 you will likely need to adjust
/// the GPIO pin definitions for the outputs.
constexpr gpio_num_t CAN_TX_PIN = GPIO_NUM_5;

#endif // USE_CAN

/// This is the primary entrypoint for the OpenMRN/LCC stack.
OpenMRN openmrn(NODE_ID);

// note the dummy string below is required due to a bug in the GCC compiler
// for the ESP32
string dummystring("abcdef");

/// ConfigDef comes from config.h and is specific to this particular device and
/// target. It defines the layout of the configuration memory space and is also
/// used to generate the cdi.xml file. Here we instantiate the configuration
/// layout. The argument of offset zero is ignored and will be removed later.
static constexpr openlcb::ConfigDef cfg(0);

#if defined(USE_WIFI)
Esp32WiFiManager wifi_mgr(ssid, password, openmrn.stack(), cfg.seg().wifi());
#endif // USE_WIFI

#ifdef MCP23017_0
extern const mcp23017Gpio 
LED00_Pin, LED01_Pin, LED02_Pin, LED03_Pin, 
LED04_Pin, LED05_Pin, LED06_Pin, LED07_Pin, 
BUT00_Pin, BUT01_Pin, BUT02_Pin, BUT03_Pin,
BUT04_Pin, BUT05_Pin, BUT06_Pin, BUT07_Pin;

Adafruit_MCP23017 mcp0;

constexpr const mcp23017Gpio LED00_Pin(&mcp0,0,true,false);
constexpr const mcp23017Gpio LED01_Pin(&mcp0,1,true,false);
constexpr const mcp23017Gpio LED02_Pin(&mcp0,2,true,false);
constexpr const mcp23017Gpio LED03_Pin(&mcp0,3,true,false);
constexpr const mcp23017Gpio LED04_Pin(&mcp0,4,true,false);
constexpr const mcp23017Gpio LED05_Pin(&mcp0,5,true,false);
constexpr const mcp23017Gpio LED06_Pin(&mcp0,6,true,false);
constexpr const mcp23017Gpio LED07_Pin(&mcp0,7,true,false);
constexpr const mcp23017Gpio BUT00_Pin(&mcp0,8,false,true);
constexpr const mcp23017Gpio BUT01_Pin(&mcp0,9,false,true);
constexpr const mcp23017Gpio BUT02_Pin(&mcp0,10,false,true);
constexpr const mcp23017Gpio BUT03_Pin(&mcp0,11,false,true);
constexpr const mcp23017Gpio BUT04_Pin(&mcp0,12,false,true);
constexpr const mcp23017Gpio BUT05_Pin(&mcp0,13,false,true);
constexpr const mcp23017Gpio BUT06_Pin(&mcp0,14,false,true);
constexpr const mcp23017Gpio BUT07_Pin(&mcp0,15,false,true);

constexpr const Gpio *const LED0_set[] = {
    &LED00_Pin, &LED01_Pin, &LED02_Pin, &LED03_Pin, 
    &LED04_Pin, &LED05_Pin, &LED06_Pin, &LED07_Pin
};

openlcb::MultiConfiguredConsumer gpio_consumers(openmrn.stack()->node(),
    LED0_set, ARRAYSIZE(LED0_set), cfg.seg().mcp0().consumers());

openlcb::ConfiguredProducer BUT00_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<0>(), BUT00_Pin);
openlcb::ConfiguredProducer BUT01_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<1>(), BUT01_Pin);
openlcb::ConfiguredProducer BUT02_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<2>(), BUT02_Pin);
openlcb::ConfiguredProducer BUT03_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<3>(), BUT03_Pin);
openlcb::ConfiguredProducer BUT04_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<4>(), BUT04_Pin);
openlcb::ConfiguredProducer BUT05_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<5>(), BUT05_Pin);
openlcb::ConfiguredProducer BUT06_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<6>(), BUT06_Pin);
openlcb::ConfiguredProducer BUT07_producer(openmrn.stack()->node(), cfg.seg().mcp0().producers().entry<7>(), BUT07_Pin);

// The producers need to be polled repeatedly for changes and to execute the
// debouncing algorithm. This class instantiates a refreshloop and adds the
// producers to it.
openlcb::RefreshLoop BUT0_refresh_loop(openmrn.stack()->node(),
    {
        BUT00_producer.polling(),
        BUT01_producer.polling(),
        BUT02_producer.polling(),
        BUT03_producer.polling(),
        BUT04_producer.polling(),
        BUT05_producer.polling(),
        BUT06_producer.polling(),
        BUT07_producer.polling()
    }
);
#endif

#ifdef MCP23017_1
extern const mcp23017Gpio 
LED10_Pin, LED11_Pin, LED12_Pin, LED13_Pin, 
LED14_Pin, LED15_Pin, LED16_Pin, LED17_Pin, 
BUT10_Pin, BUT11_Pin, BUT12_Pin, BUT13_Pin,
BUT14_Pin, BUT15_Pin, BUT16_Pin, BUT17_Pin;

Adafruit_MCP23017 mcp1;

constexpr const mcp23017Gpio LED10_Pin(&mcp1,0,true,false);
constexpr const mcp23017Gpio LED11_Pin(&mcp1,1,true,false);
constexpr const mcp23017Gpio LED12_Pin(&mcp1,2,true,false);
constexpr const mcp23017Gpio LED13_Pin(&mcp1,3,true,false);
constexpr const mcp23017Gpio LED14_Pin(&mcp1,4,true,false);
constexpr const mcp23017Gpio LED15_Pin(&mcp1,5,true,false);
constexpr const mcp23017Gpio LED16_Pin(&mcp1,6,true,false);
constexpr const mcp23017Gpio LED17_Pin(&mcp1,7,true,false);
constexpr const mcp23017Gpio BUT10_Pin(&mcp1,8,false,true);
constexpr const mcp23017Gpio BUT11_Pin(&mcp1,9,false,true);
constexpr const mcp23017Gpio BUT12_Pin(&mcp1,10,false,true);
constexpr const mcp23017Gpio BUT13_Pin(&mcp1,11,false,true);
constexpr const mcp23017Gpio BUT14_Pin(&mcp1,12,false,true);
constexpr const mcp23017Gpio BUT15_Pin(&mcp1,13,false,true);
constexpr const mcp23017Gpio BUT16_Pin(&mcp1,14,false,true);
constexpr const mcp23017Gpio BUT17_Pin(&mcp1,15,false,true);

constexpr const Gpio *const LED1_set[] = {
    &LED10_Pin, &LED11_Pin, &LED12_Pin, &LED13_Pin, 
    &LED14_Pin, &LED15_Pin, &LED16_Pin, &LED17_Pin
};

openlcb::MultiConfiguredConsumer gpio_consumers(openmrn.stack()->node(),
    LED1_set, ARRAYSIZE(LED1_set), cfg.seg().mcp1().consumers());

openlcb::ConfiguredProducer BUT10_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<0>(), BUT10_Pin);
openlcb::ConfiguredProducer BUT11_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<1>(), BUT11_Pin);
openlcb::ConfiguredProducer BUT12_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<2>(), BUT12_Pin);
openlcb::ConfiguredProducer BUT13_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<3>(), BUT13_Pin);
openlcb::ConfiguredProducer BUT14_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<4>(), BUT14_Pin);
openlcb::ConfiguredProducer BUT15_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<5>(), BUT15_Pin);
openlcb::ConfiguredProducer BUT16_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<6>(), BUT16_Pin);
openlcb::ConfiguredProducer BUT17_producer(openmrn.stack()->node(), cfg.seg().mcp1().producers().entry<7>(), BUT17_Pin);

// The producers need to be polled repeatedly for changes and to execute the
// debouncing algorithm. This class instantiates a refreshloop and adds the
// producers to it.
openlcb::RefreshLoop BUT1_refresh_loop(openmrn.stack()->node(),
    {
        BUT10_producer.polling(),
        BUT11_producer.polling(),
        BUT12_producer.polling(),
        BUT13_producer.polling(),
        BUT14_producer.polling(),
        BUT15_producer.polling(),
        BUT16_producer.polling(),
        BUT17_producer.polling()
    }
);
#endif

#define HORN      A0
#define BRAKE     A3
#define BUTTON_A  34
#define BUTTON_B  35
#define BUTTON_C  33
#define BUTTON_D  25
#define BELL      26
#define REVERSER  A17
#define STATUS_R  12
#define STATUS_G  13
#define THROTTLEA 22
#define THROTTLEB 19
#define L_OFF     18
#define L_DIM     17
#define L_BRIGHT  16
#define L_DITCH    0

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 32 // OLED display height, in pixels

// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
#define OLED_RESET     -1 // Reset pin # (or -1 if sharing Arduino reset pin)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

static const char rcsid[] = "@(#) : $Id$";

void setup() {
    
#ifdef MCP23017_0
    mcp0.begin(0x20);
    LED00_Pin.hw_init();
    LED01_Pin.hw_init();
    LED02_Pin.hw_init();
    LED03_Pin.hw_init();
    LED04_Pin.hw_init();
    LED05_Pin.hw_init();
    LED06_Pin.hw_init();
    LED07_Pin.hw_init();
    BUT00_Pin.hw_init();
    BUT01_Pin.hw_init();
    BUT02_Pin.hw_init();
    BUT03_Pin.hw_init();
    BUT04_Pin.hw_init();
    BUT05_Pin.hw_init();
    BUT06_Pin.hw_init();
    BUT07_Pin.hw_init();
#endif
#ifdef MCP23017_1
    mcp1.begin(0x21);
    LED10_Pin.hw_init();
    LED11_Pin.hw_init();
    LED12_Pin.hw_init();
    LED13_Pin.hw_init();
    LED14_Pin.hw_init();
    LED15_Pin.hw_init();
    LED16_Pin.hw_init();
    LED17_Pin.hw_init();
    BUT10_Pin.hw_init();
    BUT11_Pin.hw_init();
    BUT12_Pin.hw_init();
    BUT13_Pin.hw_init();
    BUT14_Pin.hw_init();
    BUT15_Pin.hw_init();
    BUT16_Pin.hw_init();
    BUT17_Pin.hw_init();
#endif
    // put your setup code here, to run once:
}
                
void loop() {
    // put your main code here, to run repeatedly:
}    
