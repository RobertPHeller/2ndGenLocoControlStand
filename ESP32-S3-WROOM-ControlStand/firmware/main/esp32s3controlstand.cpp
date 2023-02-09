// -!- C++ -!- //////////////////////////////////////////////////////////////
//
//  System        : 
//  Module        : 
//  Object Name   : $RCSfile$
//  Revision      : $Revision$
//  Date          : $Date$
//  Author        : $Author$
//  Created By    : Robert Heller
//  Created       : Mon Dec 12 13:38:08 2022
//  Last Modified : <230102.0921>
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

#include "sdkconfig.h"
#include "cdi.hxx"
#include "cdidata.hxx"
#include "DelayRebootHelper.hxx"
#include "EventBroadcastHelper.hxx"
#include "FactoryResetHelper.hxx"
#include "HealthMonitor.hxx"
#include "fs.hxx"
#include "hardware.hxx"
#include "NodeRebootHelper.hxx"

#include <algorithm>
#include <driver/i2c.h>
#include <driver/uart.h>
#include <esp_err.h>
#include <esp_log.h>
#include <esp_ota_ops.h>
#include <esp_system.h>
#include <esp_task_wdt.h>
#include <esp32s3/rom/rtc.h>
#include <freertos_includes.h>
#include <freertos_drivers/esp32/Esp32HardwareTwai.hxx>
#include <freertos_drivers/esp32/Esp32WiFiManager.hxx>
#include <freertos_drivers/esp32/Esp32BootloaderHal.hxx>
#include <freertos_drivers/esp32/Esp32SocInfo.hxx>
#include <openlcb/MemoryConfigClient.hxx>
#include <openlcb/RefreshLoop.hxx>
#include <openlcb/SimpleStack.hxx>
#include <openlcb/MultiConfiguredConsumer.hxx>
#include "MultiConfiguredProducer.hxx"
#include <utils/constants.hxx>
#include <utils/format_utils.hxx>
#include "Esp32HardwareI2C.hxx"
#include "MCP23017Gpio.hxx"
#include "Adafruit_TCA8418.hxx"
#include "NvsManager.hxx"
#include "BootPauseHelper.hxx"
#include "ESP32ControlStand.hxx"

///////////////////////////////////////////////////////////////////////////////
// Increase the CAN RX frame buffer size to reduce overruns when there is high
// traffic load (ie: large datagram transport).
///////////////////////////////////////////////////////////////////////////////
OVERRIDE_CONST(can_rx_buffer_size, 64);

esp32s3controlstand::ConfigDef cfg(0);
Esp32HardwareTwai twai(CONFIG_TWAI_RX_PIN, CONFIG_TWAI_TX_PIN);
Esp32HardwareI2C i2c0(CONFIG_SDA_PIN, CONFIG_SCL_PIN, 0, "/dev/i2c/i2c0");


namespace openlcb
{
    /// Name of CDI.xml to generate dynamically.
    const char CDI_FILENAME[] = "/fs/cdi.xml";

    // Path to where OpenMRN should persist general configuration data.
    const char *const CONFIG_FILENAME = "/fs/config";

    // The size of the memory space to export over the above device.
    const size_t CONFIG_FILE_SIZE =
        cfg.seg().size() + cfg.seg().offset();

    // Default to store the dynamic SNIP data is stored in the same persistant
    // data file as general configuration data.
    const char *const SNIP_DYNAMIC_FILENAME = "/fs/config";

    /// Defines the identification information for the node. The arguments are:
    ///
    /// - 4 (version info, always 4 by the standard
    /// - Manufacturer name
    /// - Model name
    /// - Hardware version
    /// - Software version
    ///
    /// This data will be used for all purposes of the identification:
    ///
    /// - the generated cdi.xml will include this data
    /// - the Simple Node Ident Info Protocol will return this data
    /// - the ACDI memory space will contain this data.
    const SimpleNodeStaticValues SNIP_STATIC_DATA =
    {
        4,
        SNIP_PROJECT_PAGE,
        SNIP_PROJECT_NAME,
        SNIP_HW_VERSION,
        SNIP_SW_VERSION
    };

} // namespace openlcb

extern "C"
{

void *node_reboot(void *arg)
{
    Singleton<esp32s3controlstand::NodeRebootHelper>::instance()->reboot();
    return nullptr;
}

void reboot()
{
    os_thread_create(nullptr, nullptr, uxTaskPriorityGet(NULL) + 1, 2048
                   , node_reboot, nullptr);
}

ssize_t os_get_free_heap()
{
    return heap_caps_get_free_size(MALLOC_CAP_8BIT);
}

/// Verifies that the bootloader has been requested.
///
/// @return true (always).
///
/// NOTE: On the ESP32 this defaults to always return true since this code will
/// not be invoked through normal node startup.
bool request_bootloader(void)
{
    LOG(VERBOSE, "[Bootloader] request_bootloader");
    // Default to allow bootloader to run since we are not entering the
    // bootloader loop unless requested by app_main.
    return true;
}



/// Updates the state of a status LED.
///
/// @param led is the LED to update.
/// @param value is the new state of the LED.
///
/// NOTE: Currently the following mapping is being used for the LEDs:
/// LED_ACTIVE -> Bootloader LED
/// LED_WRITING -> Bootloader Write LED
/// LED_REQUEST -> Used only as a hook for printing bootloader startup.
void bootloader_led(enum BootloaderLed led, bool value)
{
    LOG(VERBOSE, "[Bootloader] bootloader_led(%d, %d)", led, value);
    if (led == LED_ACTIVE)
    {
        ACT1_Pin::instance()->write(value);
    }
    else if (led == LED_WRITING)
    {
        ACT2_Pin::instance()->write(value);
    }
    else if (led == LED_REQUEST)
    {
        //LOG(INFO, "[Bootloader] Preparing to receive firmware");
        //LOG(INFO, "[Bootloader] Current partition: %s", current->label);
        //LOG(INFO, "[Bootloader] Target partition: %s", target->label);
    }
}

/// Initializes the node specific bootloader hardware (LEDs)
void bootloader_hw_set_to_safe(void)
{
    LOG(VERBOSE, "[Bootloader] bootloader_hw_set_to_safe");
    ACT1_Pin::hw_init();
    ACT2_Pin::hw_init();
}

namespace esp32s3controlstand {

ConfigUpdateListener::UpdateAction FactoryResetHelper::apply_configuration(
    int fd, bool initial_load, BarrierNotifiable *done)
{
    // nothing to do here as we do not load config
    AutoNotify n(done);
    LOG(VERBOSE, "[CFG] apply_configuration(%d, %d)", fd, initial_load);

    return ConfigUpdateListener::UpdateAction::UPDATED;
}

void FactoryResetHelper::factory_reset(int fd)
{
    LOG(VERBOSE, "[CFG] factory_reset(%d)", fd);
    // set the name of the node to the SNIP model name
    cfg.userinfo().name().write(fd, openlcb::SNIP_STATIC_DATA.model_name);
    cfg.userinfo().description().write(fd, "");
    
#if defined(CONFIG_IO_BUTTON_LED_BOARD_1)
    for(int i = 0; i < NUM_OUTPUTS; i++)
    {
        cfg.seg().mcp0().consumers().entry(i).description().write(fd, "");
    }
    for(int i = 0; i < NUM_INPUTS; i++)
    {
        cfg.seg().mcp0().producers().entry(i).description().write(fd, "");
        CDI_FACTORY_RESET(cfg.seg().mcp0().producers().entry(i).debounce);
    }
#endif
#if defined(CONFIG_IO_BUTTON_LED_BOARD_2)
    for(int i = 0; i < NUM_OUTPUTS; i++)
    {
        cfg.seg().mcp1().consumers().entry(i).description().write(fd, "");
    }
    for(int i = 0; i < NUM_INPUTS; i++)
    {
        cfg.seg().mcp1().producers().entry(i).description().write(fd, "");
        CDI_FACTORY_RESET(cfg.seg().mcp1().producers().entry(i).debounce);
    }
#endif
}

}

#if defined(CONFIG_IO_BUTTON_LED_BOARD_1) || defined(CONFIG_IO_BUTTON_LED_BOARD_2)
Executor<1> io_executor("io_thread", 1, 1300);
#endif

#if defined(CONFIG_IO_BUTTON_LED_BOARD_1)
MCP23017 gpioChip0(&io_executor, 0, 0, 0);
constexpr const MCP23017Gpio LED00_Pin(&gpioChip0,MCP23017::PORTA, 0);
constexpr const MCP23017Gpio LED01_Pin(&gpioChip0,MCP23017::PORTA, 1);
constexpr const MCP23017Gpio LED02_Pin(&gpioChip0,MCP23017::PORTA, 2);
constexpr const MCP23017Gpio LED03_Pin(&gpioChip0,MCP23017::PORTA, 3);
constexpr const MCP23017Gpio LED04_Pin(&gpioChip0,MCP23017::PORTA, 4);
constexpr const MCP23017Gpio LED05_Pin(&gpioChip0,MCP23017::PORTA, 5);
constexpr const MCP23017Gpio LED06_Pin(&gpioChip0,MCP23017::PORTA, 6);
constexpr const MCP23017Gpio LED07_Pin(&gpioChip0,MCP23017::PORTA, 7);

constexpr const Gpio *const LED0_set[] = {
    &LED00_Pin, &LED01_Pin, &LED02_Pin, &LED03_Pin, 
    &LED04_Pin, &LED05_Pin, &LED06_Pin, &LED07_Pin
};

constexpr const MCP23017Gpio BUT00_Pin(&gpioChip0,MCP23017::PORTB, 0);
constexpr const MCP23017Gpio BUT01_Pin(&gpioChip0,MCP23017::PORTB, 1);
constexpr const MCP23017Gpio BUT02_Pin(&gpioChip0,MCP23017::PORTB, 2);
constexpr const MCP23017Gpio BUT03_Pin(&gpioChip0,MCP23017::PORTB, 3);
constexpr const MCP23017Gpio BUT04_Pin(&gpioChip0,MCP23017::PORTB, 4);
constexpr const MCP23017Gpio BUT05_Pin(&gpioChip0,MCP23017::PORTB, 5);
constexpr const MCP23017Gpio BUT06_Pin(&gpioChip0,MCP23017::PORTB, 6);
constexpr const MCP23017Gpio BUT07_Pin(&gpioChip0,MCP23017::PORTB, 7);

constexpr const static Gpio *const Button0_set[] = {
    &BUT00_Pin, &BUT01_Pin, &BUT02_Pin, &BUT03_Pin,
    &BUT04_Pin, &BUT05_Pin, &BUT06_Pin, &BUT07_Pin
};
#endif
#if defined(CONFIG_IO_BUTTON_LED_BOARD_2)
MCP23017 gpioChip1(&io_executor, 0, 0, 0);
constexpr const MCP23017Gpio LED10_Pin(&gpioChip1,MCP23017::PORTA, 0);
constexpr const MCP23017Gpio LED11_Pin(&gpioChip1,MCP23017::PORTA, 1);
constexpr const MCP23017Gpio LED12_Pin(&gpioChip1,MCP23017::PORTA, 2);
constexpr const MCP23017Gpio LED13_Pin(&gpioChip1,MCP23017::PORTA, 3);
constexpr const MCP23017Gpio LED14_Pin(&gpioChip1,MCP23017::PORTA, 4);
constexpr const MCP23017Gpio LED15_Pin(&gpioChip1,MCP23017::PORTA, 5);
constexpr const MCP23017Gpio LED16_Pin(&gpioChip1,MCP23017::PORTA, 6);
constexpr const MCP23017Gpio LED17_Pin(&gpioChip1,MCP23017::PORTA, 7);

constexpr const Gpio *const LED1_set[] = {
    &LED10_Pin, &LED11_Pin, &LED12_Pin, &LED13_Pin, 
    &LED14_Pin, &LED15_Pin, &LED16_Pin, &LED17_Pin
};

constexpr const MCP23017Gpio BUT10_Pin(&gpioChip1,MCP23017::PORTB, 0);
constexpr const MCP23017Gpio BUT11_Pin(&gpioChip1,MCP23017::PORTB, 1);
constexpr const MCP23017Gpio BUT12_Pin(&gpioChip1,MCP23017::PORTB, 2);
constexpr const MCP23017Gpio BUT13_Pin(&gpioChip1,MCP23017::PORTB, 3);
constexpr const MCP23017Gpio BUT14_Pin(&gpioChip1,MCP23017::PORTB, 4);
constexpr const MCP23017Gpio BUT15_Pin(&gpioChip1,MCP23017::PORTB, 5);
constexpr const MCP23017Gpio BUT16_Pin(&gpioChip1,MCP23017::PORTB, 6);
constexpr const MCP23017Gpio BUT17_Pin(&gpioChip1,MCP23017::PORTB, 7);

constexpr const static Gpio *const Button1_set[] = {
    &BUT10_Pin, &BUT11_Pin, &BUT12_Pin, &BUT13_Pin,
    &BUT14_Pin, &BUT15_Pin, &BUT16_Pin, &BUT17_Pin
};
#endif

/// Application main entry point.
void app_main()
{
    const esp_app_desc_t *app_data = esp_ota_get_app_description();
    LOG(INFO, "\n\nESP32 2ndGen Loco Control Stand (a LCC Throttle) starting up...");
    LOG(INFO, "Compiled on %s %s using IDF %s", app_data->date, app_data->time,
        app_data->idf_ver);
    LOG(INFO, "Running from: %s", esp_ota_get_running_partition()->label);
    LOG(INFO, "ESP32 2ndGen Loco Control Stand uses the OpenMRN library\n"
        "Copyright (c) 2019-2022, OpenMRN\n"
        "All rights reserved.");
    LOG(INFO, "[SNIP] version:%d, manufacturer:%s, model:%s, hw-v:%s, sw-v:%s",
        openlcb::SNIP_STATIC_DATA.version,
        openlcb::SNIP_STATIC_DATA.manufacturer_name,
        openlcb::SNIP_STATIC_DATA.model_name,
        openlcb::SNIP_STATIC_DATA.hardware_version,
        openlcb::SNIP_STATIC_DATA.software_version);
    LOG(INFO, "[CDI] Size: %zu, Version:%04x", openlcb::CDI_SIZE, CDI_VERSION);
    uint8_t reset_reason = Esp32SocInfo::print_soc_info();
    bool reset_events = false;
    bool run_bootloader = false;
    bool cleanup_config_tree = false;
    GpioInit::hw_init();
    Esp32HardwareI2C::Mount("/dev/i2c");
    i2c0.hw_init();
    
    esp32s3controlstand::NvsManager nvs;
    nvs.init(reset_reason);
    // Ensure the LEDs are both ON for PauseCheck
    ACT1_Pin::instance()->set();
    ACT2_Pin::instance()->set();
    
    LOG(INFO, "[BootPauseHelper] starting...");
    
    esp32s3controlstand::BootPauseHelper pause;
    
    pause.CheckPause();
    LOG(INFO, "[BootPauseHelper] returned...");
    
    // Ensure the LEDs are both OFF when we startup.
    ACT1_Pin::instance()->clr();
    ACT2_Pin::instance()->clr();
    
    // Check for and reset factory reset flag.
    if (nvs.should_reset_config())
    {
        cleanup_config_tree = true;
        nvs.clear_factory_reset();
    }
    
    if (nvs.should_start_bootloader())
    {
        run_bootloader = true;
        // reset the flag so we start in normal operating mode next time.
        nvs.clear_bootloader();
    }
    
    if (nvs.should_reset_events())
    {
        reset_events = true;
        // reset the flag so we start in normal operating mode next time.
        nvs.clear_reset_events();
    }
    nvs.CheckPersist();
    
    if (run_bootloader)
    {
        LOG(VERBOSE, "[Bootloader] bootloader_hw_set_to_safe");
        ACT1_Pin::hw_init();
        ACT2_Pin::hw_init();
        esp32_bootloader_run(nvs.node_id(), CONFIG_TWAI_TX_PIN, CONFIG_TWAI_RX_PIN, true);
        esp_restart();
    }
    else
    {
        nvs.DisplayNvsConfiguration();
        mount_fs(cleanup_config_tree);
        LOG(INFO, "[esp32s3controlstand] about to start the Simple Can Stack");
        openlcb::SimpleCanStack stack(nvs.node_id());
        LOG(INFO, "[esp32s3controlstand] stack started");
        stack.set_tx_activity_led(ACT1_Pin::instance());
        LOG(INFO, "[esp32s3controlstand] set activity led");
#if CONFIG_OLCB_PRINT_ALL_PACKETS
        stack.print_all_packets();
#endif
        nvs.register_virtual_memory_spaces(&stack);
        openlcb::MemoryConfigClient memory_client(stack.node(), stack.memory_config_handler());
        LOG(INFO, "[esp32s3controlstand] MemoryConfigClient done.");
#ifdef CONFIG_ESP32_WIFI_ENABLED
        openmrn_arduino::Esp32WiFiManager wifi_manager(
                                      nvs.station_ssid(), 
                                      nvs.station_pass(),
                                      &stack, 
                                      cfg.seg().olbcwifi(), 
                                      nvs.wifi_mode(),
                                      (uint8_t)CONFIG_OLCB_WIFI_MODE, /* uplink / hub mode */
                                      nvs.hostname_prefix());
        wifi_manager.set_status_led(ACT2_Pin::instance());
#endif
        esp32s3controlstand::FactoryResetHelper factory_reset_helper();
        LOG(INFO, "[esp32s3controlstand] FactoryResetHelper done.");
        esp32s3controlstand::EventBroadcastHelper event_helper();
        LOG(INFO, "[esp32s3controlstand] EventBroadcastHelper done.");
        esp32s3controlstand::DelayRebootHelper delayed_reboot(stack.service());
        LOG(INFO, "[esp32s3controlstand] DelayRebootHelper done.");
        esp32s3controlstand::HealthMonitor health_mon(stack.service());
        LOG(INFO, "[esp32s3controlstand] HealthMonitor done.");
        
#if defined(CONFIG_IO_BUTTON_LED_BOARD_1) || defined(CONFIG_IO_BUTTON_LED_BOARD_2)
        int i2cfd = ::open("/dev/i2c/i2c0",O_RDWR);
#if defined(CONFIG_IO_BUTTON_LED_BOARD_1)
        gpioChip0.init(i2cfd);
        openlcb::MultiConfiguredConsumer leds1(stack.node(),
                                               LED0_set,
                                               ARRAYSIZE(LED0_set),
                                               cfg.seg().mcp0().consumers());
        MultiConfiguredProducer buttons1(stack.node(),
                                         Button0_set,
                                         ARRAYSIZE(Button0_set),
                                         cfg.seg().mcp0().producers());
        openlcb::RefreshLoop loop0(stack.node(),{buttons1.polling()});
#endif
#if defined(CONFIG_IO_BUTTON_LED_BOARD_2)
        gpioChip1.init(i2cfd);
        openlcb::MultiConfiguredConsumer leds2(stack.node(),
                                               LED1_set,
                                               ARRAYSIZE(LED1_set),
                                               cfg.seg().mcp1().consumers());
        MultiConfiguredProducer buttons2(stack.node(),
                                         Button1_set,
                                         ARRAYSIZE(Button1_set),
                                         cfg.seg().mcp1().producers());
        openlcb::RefreshLoop loop0(stack.node(),{buttons2.polling()});
#endif
#endif
        esp32s3controlstand::ESP32ControlStand stand(stack.node(),
                                cfg.seg().controlstand());
#ifdef CONFIG_IO_KEYPAD
        Adafruit_TCA8418 Keypad;
        Keypad.begin("/dev/i2c/i2c0");
        Keypad.matrix(4,3);
        Keypad.enableDebounce();
        stand.hw_init(&Keypad);
#else
        stand.hw_init();
#endif
        // Create config file and initiate factory reset if it doesn't exist or is
        // otherwise corrupted.
        int config_fd =
              stack.create_config_file_if_needed(cfg.seg().internal_config(),
                                                  CDI_VERSION,
                                                  openlcb::CONFIG_FILE_SIZE);
        stack.check_version_and_factory_reset(cfg.seg().internal_config(),
                                              CDI_VERSION,
                                              cleanup_config_tree);

        esp32s3controlstand::NodeRebootHelper node_reboot_helper(&stack, config_fd);
        
        if (reset_events)
        {
            LOG(WARNING, "[CDI] Resetting event IDs");
            stack.factory_reset_all_events(
                    cfg.seg().internal_config(), nvs.node_id(), config_fd);
            fsync(config_fd);
        }
        
#ifdef CONFIG_OLCB_ENABLE_TWAI
        // Initialize the TWAI driver.
        twai.hw_init();
        
        // Add the TWAI port to the stack.
        stack.add_can_port_select("/dev/twai/twai0");
#endif
        // if a brownout was detected send an event as part of node startup.
        if (reset_reason == RTCWDT_BROWN_OUT_RESET)
        {
            //event_helper.send_event(openlcb::Defs::NODE_POWER_BROWNOUT_EVENT);
        }
        
        // Start the stack in the background using it's own task.
        stack.loop_executor();
        //stackrunning = true;
        
    }
}

}


