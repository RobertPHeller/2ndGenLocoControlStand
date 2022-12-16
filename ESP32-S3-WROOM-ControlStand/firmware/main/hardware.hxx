// -!- c++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Dec 12 12:18:47 2022
//  Last Modified : <221214.1106>
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

#ifndef __HARDWARE_HXX
#define __HARDWARE_HXX

#include <freertos_drivers/arduino/DummyGPIO.hxx>
#include <freertos_drivers/esp32/Esp32Gpio.hxx>
#include <os/Gpio.hxx>
#include <utils/GpioInitializer.hxx>

#include "sdkconfig.h"

// Digital pins:

// Buttons
GPIO_PIN(BUTTON_A, GpioInputPU, GPIO_NUM_6);
GPIO_PIN(BUTTON_B, GpioInputPU, GPIO_NUM_7);
GPIO_PIN(BUTTON_C, GpioInputPU, GPIO_NUM_8);
GPIO_PIN(BUTTON_D, GpioInputPU, GPIO_NUM_9);

// Status LEDs
GPIO_PIN(STATUS_R, GpioInputNP, GPIO_NUM_10);
GPIO_PIN(STATUS_G, GpioInputNP, GPIO_NUM_11);

// Throttle Encoder
GPIO_PIN(THROTTLEA, GpioInputPU, GPIO_NUM_12);
GPIO_PIN(THROTTLEB, GpioInputPU, GPIO_NUM_13);

// Light switch
GPIO_PIN(L_OFF,    GpioInputPU, GPIO_NUM_14);
GPIO_PIN(L_DIM,    GpioInputPU, GPIO_NUM_15);
GPIO_PIN(L_BRIGHT, GpioInputPU, GPIO_NUM_21);
GPIO_PIN(L_DITCH,  GpioInputPU, GPIO_NUM_35);

// Bell
GPIO_PIN(BELL, GpioInputPU, GPIO_NUM_36);

// ADC Pins:

ADC_PIN(HORN, ADC2_CHANNEL_7, ADC_ATTEN_DB_11, ADC_WIDTH_BIT_12);
ADC_PIN(BRAKE, ADC2_CHANNEL_6, ADC_ATTEN_DB_11, ADC_WIDTH_BIT_12);
ADC_PIN(REVERSER, ADC2_CHANNEL_5, ADC_ATTEN_DB_11, ADC_WIDTH_BIT_12);


// On-board LEDs:

GPIO_PIN(ACT1, GpioInputNP, GPIO_NUM_37);
GPIO_PIN(ACT2, GpioInputNP, GPIO_NUM_38);


/// GPIO Pin initializer.
typedef GpioInitializer<BUTTON_A_Pin, BUTTON_B_Pin, BUTTON_C_Pin, BUTTON_D_Pin,
                        STATUS_R_Pin, STATUS_G_Pin, THROTTLEA_Pin, THROTTLEB_Pin,
                        L_OFF_Pin, L_DIM_Pin, L_BRIGHT_Pin, L_DITCH_Pin,
                        BELL_Pin, HORN_Pin, BRAKE_Pin, REVERSER_Pin,
                        ACT1_Pin, ACT2_Pin> GpioInit;

/// GPIO Pin used for I2C SDA.
static constexpr gpio_num_t CONFIG_SDA_PIN = GPIO_NUM_2;

/// GPIO Pin used for I2C SCL.
static constexpr gpio_num_t CONFIG_SCL_PIN = GPIO_NUM_3;

// I2C addresses:
static constexpr uint8_t BLPANEL1_ADDR = 0x20; /* MCP23017 #0 */
static constexpr uint8_t BLPANEL2_ADDR = 0x21; /* MCP23017 #1 */
static constexpr uint8_t KEYPAD_ADDR   = 0x34; /* tca8418 */
static constexpr uint8_t DISPLAY_ADDR  = 0x3C; /* 128x32 SSD1306 display */

/// GPIO Pin connected to the TWAI (CAN) Transceiver RX pin.
static constexpr gpio_num_t CONFIG_TWAI_RX_PIN = GPIO_NUM_4;

/// GPIO Pin connected to the TWAI (CAN) Transceiver TX pin.
static constexpr gpio_num_t CONFIG_TWAI_TX_PIN = GPIO_NUM_5;


#endif // __HARDWARE_HXX

