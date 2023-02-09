EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:mechanical
LIBS:graphic_symbols
LIBS:esp32_s3_wroom
LIBS:lm2574n-5
LIBS:mcp73871
LIBS:gct_usb4105
LIBS:USBLC6-2SC6
LIBS:tca8418
LIBS:sw_push_small_gnd
LIBS:ESP32_mini
LIBS:ESP32-T7S3-ControlStand-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 7
Title "ESP32-T7S3-ControlStand"
Date "2022-07-25"
Rev "1.0"
Comp "Deepwoods Software"
Comment1 "Main page"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_3 J8
U 1 1 62DF0418
P 8450 3950
F 0 "J8" V 8400 3950 50  0000 C CNN
F 1 "Throttle" V 8500 3950 40  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 8450 3950 60  0001 C CNN
F 3 "~" H 8450 3950 60  0000 C CNN
F 4 "649-1012937890301BLF" V 8450 3950 60  0001 C CNN "Mouser Part Number"
	1    8450 3950
	1    0    0    1   
$EndComp
$Comp
L ENCODER EN2
U 1 1 62DF0419
P 9900 4750
F 0 "EN2" H 9950 4950 60  0000 C CNN
F 1 "Reverser" H 9900 4650 60  0000 C CNN
F 2 "Encoders:ALPSEC12C" H 9900 4750 60  0001 C CNN
F 3 "~" H 9900 4750 60  0000 C CNN
F 4 "652-PEC11R4325FN0012" H 9900 4750 60  0001 C CNN "Mouser Part Number"
	1    9900 4750
	1    0    0    -1  
$EndComp
$Comp
L POT-RESCUE-ESP32ControlStand RV1
U 1 1 62DF041A
P 10000 3000
F 0 "RV1" H 10000 2900 50  0000 C CNN
F 1 "100K Ohms" H 10000 3000 50  0000 C CNN
F 2 "" H 10000 3000 60  0001 C CNN
F 3 "~" H 10000 3000 60  0000 C CNN
F 4 "774-450T328F104A1A1" H 10000 3000 60  0001 C CNN "Mouser Part Number"
	1    10000 3000
	0    -1   -1   0   
$EndComp
$Comp
L POT-RESCUE-ESP32ControlStand RV2
U 1 1 62DF041B
P 10050 2300
F 0 "RV2" H 10050 2200 50  0000 C CNN
F 1 "100K Ohms" H 10050 2300 50  0000 C CNN
F 2 "" H 10050 2300 60  0001 C CNN
F 3 "~" H 10050 2300 60  0000 C CNN
F 4 "774-450T328F104A1A1" H 10050 2300 60  0001 C CNN "Mouser Part Number"
	1    10050 2300
	0    -1   -1   0   
$EndComp
$Comp
L ENCODER EN1
U 1 1 62DF041C
P 9900 3900
F 0 "EN1" H 9950 4100 60  0000 C CNN
F 1 "Throttle" H 9900 3800 60  0000 C CNN
F 2 "Encoders:Series25L-Encoder" H 9900 3900 60  0001 C CNN
F 3 "~" H 9900 3900 60  0000 C CNN
F 4 "706-25LB10-Q" H 9900 3900 60  0001 C CNN "Mouser Part Number"
	1    9900 3900
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P6
U 1 1 62DF041D
P 8850 3950
F 0 "P6" V 8800 3950 50  0000 C CNN
F 1 "CONN_3" V 8900 3950 40  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x03_Pitch2.54mm" H 8850 3950 60  0001 C CNN
F 3 "~" H 8850 3950 60  0000 C CNN
F 4 "855-M20-9750346" V 8850 3950 60  0001 C CNN "Mouser Part Number"
	1    8850 3950
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 J4
U 1 1 62DF041E
P 8350 2250
F 0 "J4" V 8300 2250 50  0000 C CNN
F 1 "Horn" V 8400 2250 40  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 8350 2250 60  0001 C CNN
F 3 "~" H 8350 2250 60  0000 C CNN
F 4 "649-1012937890301BLF" V 8350 2250 60  0001 C CNN "Mouser Part Number"
	1    8350 2250
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P3
U 1 1 62DF041F
P 8750 2250
F 0 "P3" V 8700 2250 50  0000 C CNN
F 1 "CONN_3" V 8800 2250 40  0000 C CNN
F 2 "" H 8750 2250 60  0001 C CNN
F 3 "~" H 8750 2250 60  0000 C CNN
	1    8750 2250
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 P4
U 1 1 62DF0420
P 8800 3000
F 0 "P4" V 8750 3000 50  0000 C CNN
F 1 "CONN_3" V 8850 3000 40  0000 C CNN
F 2 "" H 8800 3000 60  0001 C CNN
F 3 "~" H 8800 3000 60  0000 C CNN
	1    8800 3000
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 J5
U 1 1 62DF0421
P 8350 3050
F 0 "J5" V 8300 3050 50  0000 C CNN
F 1 "Brake" V 8400 3050 40  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 8350 3050 60  0001 C CNN
F 3 "~" H 8350 3050 60  0000 C CNN
F 4 "649-1012937890301BLF" V 8350 3050 60  0001 C CNN "Mouser Part Number"
	1    8350 3050
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P7
U 1 1 62DF0422
P 8900 4700
F 0 "P7" V 8850 4700 50  0000 C CNN
F 1 "CONN_3" V 8950 4700 40  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x03_Pitch2.54mm" H 8900 4700 60  0001 C CNN
F 3 "~" H 8900 4700 60  0000 C CNN
F 4 "855-M20-9750346" V 8900 4700 60  0001 C CNN "Mouser Part Number"
	1    8900 4700
	-1   0    0    1   
$EndComp
$Comp
L CONN_3 J7
U 1 1 62DF0423
P 8400 4700
F 0 "J7" V 8350 4700 50  0000 C CNN
F 1 "Reverser" V 8450 4700 40  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 8400 4700 60  0001 C CNN
F 3 "~" H 8400 4700 60  0000 C CNN
F 4 "649-1012937890301BLF" V 8400 4700 60  0001 C CNN "Mouser Part Number"
	1    8400 4700
	1    0    0    1   
$EndComp
$Comp
L Light_Switch SW6
U 1 1 62DF0424
P 9900 1300
F 0 "SW6" H 10250 950 60  0000 C CNN
F 1 "LIGHT_SWITCH" H 10450 1800 60  0000 C CNN
F 2 "" H 9900 1300 60  0001 C CNN
F 3 "~" H 9900 1300 60  0000 C CNN
	1    9900 1300
	-1   0    0    -1  
$EndComp
$Comp
L CONN_5 J2
U 1 1 62DF0426
P 3950 5800
F 0 "J2" V 3900 5800 50  0000 C CNN
F 1 "Button & LED Panel" V 4000 5800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 3950 5800 60  0001 C CNN
F 3 "~" H 3950 5800 60  0000 C CNN
F 4 "523-G800W303018EU" V 3950 5800 60  0001 C CNN "Mouser Part Number"
	1    3950 5800
	1    0    0    -1  
$EndComp
$Comp
L CONN_5 J6
U 1 1 62DF0427
P 8400 1300
F 0 "J6" V 8350 1300 50  0000 C CNN
F 1 "Light Switch" V 8450 1300 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 8400 1300 60  0001 C CNN
F 3 "~" H 8400 1300 60  0000 C CNN
F 4 "523-G800W303018EU" V 8400 1300 60  0001 C CNN "Mouser Part Number"
	1    8400 1300
	1    0    0    -1  
$EndComp
$Comp
L CONN_5 P5
U 1 1 62DF0428
P 8850 1300
F 0 "P5" V 8800 1300 50  0000 C CNN
F 1 "CONN_5" V 8900 1300 50  0000 C CNN
F 2 "" H 8850 1300 60  0001 C CNN
F 3 "~" H 8850 1300 60  0000 C CNN
	1    8850 1300
	-1   0    0    -1  
$EndComp
$Sheet
S 4750 5500 1250 650 
U 62DF0429
F0 " Button and LED Panel" 50
F1 "ButtonLedPanel1.sch" 50
$EndSheet
Text Label 3550 5900 2    60   ~ 0
SCL
Text Label 3550 6000 2    60   ~ 0
SDA
Text Label 8050 6100 2    60   ~ 0
GND
Text Label 8050 6400 2    60   ~ 0
SCL
Text Label 8050 6300 2    60   ~ 0
SDA
$Comp
L GND #PWR01
U 1 1 62DF042C
P 7850 1300
F 0 "#PWR01" H 7850 1300 30  0001 C CNN
F 1 "GND" H 7850 1230 30  0001 C CNN
F 2 "" H 7850 1300 60  0000 C CNN
F 3 "" H 7850 1300 60  0000 C CNN
	1    7850 1300
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR02
U 1 1 62DF042D
P 8000 2000
F 0 "#PWR02" H 8000 1960 30  0001 C CNN
F 1 "+3.3V" H 8000 2110 30  0000 C CNN
F 2 "" H 8000 2000 60  0000 C CNN
F 3 "" H 8000 2000 60  0000 C CNN
	1    8000 2000
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR03
U 1 1 62DF042E
P 8000 2850
F 0 "#PWR03" H 8000 2810 30  0001 C CNN
F 1 "+3.3V" H 8000 2960 30  0000 C CNN
F 2 "" H 8000 2850 60  0000 C CNN
F 3 "" H 8000 2850 60  0000 C CNN
	1    8000 2850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 62DF042F
P 8000 2450
F 0 "#PWR04" H 8000 2450 30  0001 C CNN
F 1 "GND" H 8000 2380 30  0001 C CNN
F 2 "" H 8000 2450 60  0000 C CNN
F 3 "" H 8000 2450 60  0000 C CNN
	1    8000 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 62DF0430
P 8000 3250
F 0 "#PWR05" H 8000 3250 30  0001 C CNN
F 1 "GND" H 8000 3180 30  0001 C CNN
F 2 "" H 8000 3250 60  0000 C CNN
F 3 "" H 8000 3250 60  0000 C CNN
	1    8000 3250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 62DF0431
P 7950 3950
F 0 "#PWR06" H 7950 3950 30  0001 C CNN
F 1 "GND" H 7950 3880 30  0001 C CNN
F 2 "" H 7950 3950 60  0000 C CNN
F 3 "" H 7950 3950 60  0000 C CNN
	1    7950 3950
	0    1    1    0   
$EndComp
$Comp
L SW_PUSH_SMALL SW1
U 1 1 62DF0432
P 1150 1300
F 0 "SW1" H 1300 1410 30  0000 C CNN
F 1 "A" H 1150 1221 30  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_EVQQ2" H 1150 1300 60  0001 C CNN
F 3 "~" H 1150 1300 60  0000 C CNN
F 4 "667-EVQ-Q2U02W" H 1150 1300 60  0001 C CNN "Mouser Part Number"
	1    1150 1300
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW2
U 1 1 62DF0433
P 1150 1600
F 0 "SW2" H 1300 1710 30  0000 C CNN
F 1 "B" H 1150 1521 30  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_EVQQ2" H 1150 1600 60  0001 C CNN
F 3 "~" H 1150 1600 60  0000 C CNN
F 4 "667-EVQ-Q2U02W" H 1150 1600 60  0001 C CNN "Mouser part Number"
	1    1150 1600
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW3
U 1 1 62DF0434
P 1150 1850
F 0 "SW3" H 1300 1960 30  0000 C CNN
F 1 "C" H 1150 1771 30  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_EVQQ2" H 1150 1850 60  0001 C CNN
F 3 "~" H 1150 1850 60  0000 C CNN
F 4 "667-EVQ-Q2U02W" H 1150 1850 60  0001 C CNN "Mouser Part Number"
	1    1150 1850
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW4
U 1 1 62DF0435
P 1150 2100
F 0 "SW4" H 1300 2210 30  0000 C CNN
F 1 "D" H 1150 2021 30  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_EVQQ2" H 1150 2100 60  0001 C CNN
F 3 "~" H 1150 2100 60  0000 C CNN
F 4 "667-EVQ-Q2U02W" H 1150 2100 60  0001 C CNN "Mouser Part Number"
	1    1150 2100
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW5
U 1 1 62DF0436
P 1150 2400
F 0 "SW5" H 1300 2510 30  0000 C CNN
F 1 "Bell" H 1150 2321 30  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_EVQQ2" H 1150 2400 60  0001 C CNN
F 3 "~" H 1150 2400 60  0000 C CNN
F 4 "667-EVQ-Q2U02W" H 1150 2400 60  0001 C CNN "Mouser Part Number"
	1    1150 2400
	1    0    0    -1  
$EndComp
$Comp
L LED_Dual_ACAC D1
U 1 1 62DF0437
P 1200 2900
F 0 "D1" H 1500 3000 50  0000 C CNN
F 1 "Status" H 1550 2800 50  0000 C CNN
F 2 "APHB1608CGKSURKC:APHB1608CGKSURKC" H 1200 2900 60  0001 C CNN
F 3 "~" H 1200 2900 60  0000 C CNN
F 4 "604-APHB1608CGKSURKC " H 1200 2900 60  0001 C CNN "Mouser Part Number"
	1    1200 2900
	-1   0    0    -1  
$EndComp
$Comp
L CONN_8 P1
U 1 1 62DF0438
P 2050 1600
F 0 "P1" V 2000 1600 60  0000 C CNN
F 1 "CONN_8" V 2100 1600 60  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x08_Pitch2.54mm" H 2050 1600 60  0001 C CNN
F 3 "~" H 2050 1600 60  0000 C CNN
F 4 "649-1012937990801BLF" V 2050 1600 60  0001 C CNN "Mouser Part Number"
	1    2050 1600
	1    0    0    -1  
$EndComp
$Comp
L CONN_8 P2
U 1 1 62DF0439
P 2450 1600
F 0 "P2" V 2400 1600 60  0000 C CNN
F 1 "Misc buttons, bell, status LED" V 2500 1600 60  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 2450 1600 60  0001 C CNN
F 3 "~" H 2450 1600 60  0000 C CNN
F 4 "649-1012937890801BLF" V 2450 1600 60  0001 C CNN "Mouser Part Number"
	1    2450 1600
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 62DF043A
P 3000 1250
F 0 "#PWR07" H 3000 1250 30  0001 C CNN
F 1 "GND" H 3000 1180 30  0001 C CNN
F 2 "" H 3000 1250 60  0000 C CNN
F 3 "" H 3000 1250 60  0000 C CNN
	1    3000 1250
	0    -1   -1   0   
$EndComp
$Comp
L R-RESCUE-ESP32ControlStand R1
U 1 1 62DF043B
P 3200 1850
F 0 "R1" V 3280 1850 40  0000 C CNN
F 1 "220 Ohms" V 3207 1851 40  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3130 1850 30  0001 C CNN
F 3 "~" H 3200 1850 30  0000 C CNN
F 4 "603-AC0603FR-07220RL" V 3200 1850 60  0001 C CNN "Mouser Part Number"
	1    3200 1850
	0    -1   -1   0   
$EndComp
$Comp
L R-RESCUE-ESP32ControlStand R2
U 1 1 62DF043C
P 3200 1950
F 0 "R2" V 3280 1950 40  0000 C CNN
F 1 "220 Ohms" V 3207 1951 40  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3130 1950 30  0001 C CNN
F 3 "~" H 3200 1950 30  0000 C CNN
F 4 "603-AC0603FR-07220RL" V 3200 1950 60  0001 C CNN "Mouser Part Number"
	1    3200 1950
	0    -1   -1   0   
$EndComp
$Sheet
S 900  5925 1800 900 
U 62DF043D
F0 "Button Led Panel (2)" 50
F1 "ButtonLedPanel2.sch" 50
$EndSheet
$Sheet
S 700  3600 1900 800 
U 62DF043E
F0 "CAN Transceiver" 50
F1 "CANTransceiver.sch" 50
F2 "CAN_TX" I R 2600 3700 60 
F3 "CAN_RX" I R 2600 4000 60 
$EndSheet
$Sheet
S 900  4800 1950 950 
U 62DF043F
F0 "Power Supply" 50
F1 "PowerSupply.sch" 50
$EndSheet
$Comp
L +5V #PWR08
U 1 1 62DF0440
P 7750 6050
F 0 "#PWR08" H 7750 6140 20  0001 C CNN
F 1 "+5V" H 7750 6140 30  0000 C CNN
F 2 "" H 7750 6050 60  0000 C CNN
F 3 "" H 7750 6050 60  0000 C CNN
	1    7750 6050
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR09
U 1 1 62DF0441
P 3550 5500
F 0 "#PWR09" H 3550 5590 20  0001 C CNN
F 1 "+5V" H 3550 5590 30  0000 C CNN
F 2 "" H 3550 5500 60  0000 C CNN
F 3 "" H 3550 5500 60  0000 C CNN
	1    3550 5500
	1    0    0    -1  
$EndComp
$Comp
L CONN_5 J1
U 1 1 62DF0442
P 3300 6750
F 0 "J1" V 3250 6750 50  0000 C CNN
F 1 "Button & LED Panel" V 3350 6750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 3300 6750 60  0001 C CNN
F 3 "~" H 3300 6750 60  0000 C CNN
F 4 "523-G800W303018EU" V 3300 6750 60  0001 C CNN "Mouser Part Number"
	1    3300 6750
	-1   0    0    -1  
$EndComp
Text Label 3700 6850 0    60   ~ 0
SCL
Text Label 3700 6950 0    60   ~ 0
SDA
$Comp
L +5V #PWR010
U 1 1 62DF0443
P 3700 6450
F 0 "#PWR010" H 3700 6540 20  0001 C CNN
F 1 "+5V" H 3700 6540 30  0000 C CNN
F 2 "" H 3700 6450 60  0000 C CNN
F 3 "" H 3700 6450 60  0000 C CNN
	1    3700 6450
	-1   0    0    -1  
$EndComp
$Comp
L +3.3V #PWR011
U 1 1 62DF0444
P 3900 6650
F 0 "#PWR011" H 3900 6610 30  0001 C CNN
F 1 "+3.3V" H 3900 6760 30  0000 C CNN
F 2 "" H 3900 6650 60  0000 C CNN
F 3 "" H 3900 6650 60  0000 C CNN
	1    3900 6650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 62DF0445
P 3950 6750
F 0 "#PWR012" H 3950 6750 30  0001 C CNN
F 1 "GND" H 3950 6680 30  0001 C CNN
F 2 "" H 3950 6750 60  0000 C CNN
F 3 "" H 3950 6750 60  0000 C CNN
	1    3950 6750
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR013
U 1 1 62DF0446
P 3350 5800
F 0 "#PWR013" H 3350 5800 30  0001 C CNN
F 1 "GND" H 3350 5730 30  0001 C CNN
F 2 "" H 3350 5800 60  0000 C CNN
F 3 "" H 3350 5800 60  0000 C CNN
	1    3350 5800
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR014
U 1 1 62DF0447
P 3400 5650
F 0 "#PWR014" H 3400 5610 30  0001 C CNN
F 1 "+3.3V" H 3400 5760 30  0000 C CNN
F 2 "" H 3400 5650 60  0000 C CNN
F 3 "" H 3400 5650 60  0000 C CNN
	1    3400 5650
	1    0    0    -1  
$EndComp
Text Label 4100 3400 2    61   ~ 0
CAN_TX
Text Label 4100 3250 2    61   ~ 0
CAN_RX
Text Label 4100 3650 2    61   ~ 0
SDA
Text Label 4100 3550 2    61   ~ 0
SCL
Text Label 2600 3700 0    60   ~ 0
CAN_TX
Text Label 2600 4000 0    60   ~ 0
CAN_RX
Text Label 4100 4050 2    61   ~ 0
RST
Text Label 8000 2250 2    60   ~ 0
Horn
Text Label 8000 3050 2    60   ~ 0
Brake
Text Label 4100 3800 2    61   ~ 0
Horn
Text Label 4100 3900 2    61   ~ 0
Brake
Text Label 8100 3850 2    60   ~ 0
ThrottleA
Text Label 8100 4050 2    60   ~ 0
ThrottleB
Text Label 5950 3400 0    61   ~ 0
ThrottleA
Text Label 5950 3500 0    61   ~ 0
ThrottleB
$Comp
L R-RESCUE-ESP32ControlStand R5
U 1 1 62DF0450
P 7800 4500
F 0 "R5" V 7880 4500 40  0000 C CNN
F 1 "100K Ohms" V 7807 4501 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7730 4500 30  0001 C CNN
F 3 "~" H 7800 4500 30  0000 C CNN
F 4 "279-CRGCQ0402J100K" V 7800 4500 60  0001 C CNN "Mouser Part Number"
	1    7800 4500
	0    -1   -1   0   
$EndComp
$Comp
L R-RESCUE-ESP32ControlStand R6
U 1 1 62DF0451
P 7800 4900
F 0 "R6" V 7880 4900 40  0000 C CNN
F 1 "100K Ohms" V 7807 4901 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7730 4900 30  0001 C CNN
F 3 "~" H 7800 4900 30  0000 C CNN
F 4 "279-CRGCQ0402J100K" V 7800 4900 60  0001 C CNN "Mouser Part Number"
	1    7800 4900
	0    -1   -1   0   
$EndComp
$Comp
L R-RESCUE-ESP32ControlStand R4
U 1 1 62DF0452
P 7150 4900
F 0 "R4" V 7230 4900 40  0000 C CNN
F 1 "100K Ohms" V 7157 4901 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7080 4900 30  0001 C CNN
F 3 "~" H 7150 4900 30  0000 C CNN
F 4 "279-CRGCQ0402J100K" V 7150 4900 60  0001 C CNN "Mouser Part Number"
	1    7150 4900
	0    -1   -1   0   
$EndComp
$Comp
L R-RESCUE-ESP32ControlStand R3
U 1 1 62DF0453
P 6750 4950
F 0 "R3" V 6830 4950 40  0000 C CNN
F 1 "100K Ohms" V 6757 4951 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6680 4950 30  0001 C CNN
F 3 "~" H 6750 4950 30  0000 C CNN
F 4 "279-CRGCQ0402J100K" V 6750 4950 60  0001 C CNN "Mouser Part Number"
	1    6750 4950
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR015
U 1 1 62DF0454
P 7550 4350
F 0 "#PWR015" H 7550 4310 30  0001 C CNN
F 1 "+3.3V" H 7550 4460 30  0000 C CNN
F 2 "" H 7550 4350 60  0000 C CNN
F 3 "" H 7550 4350 60  0000 C CNN
	1    7550 4350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 62DF0455
P 6750 5300
F 0 "#PWR016" H 6750 5300 30  0001 C CNN
F 1 "GND" H 6750 5230 30  0001 C CNN
F 2 "" H 6750 5300 60  0000 C CNN
F 3 "" H 6750 5300 60  0000 C CNN
	1    6750 5300
	1    0    0    -1  
$EndComp
Text Label 6750 4700 2    60   ~ 0
Reverser
Text Label 5950 3300 0    61   ~ 0
Reverser
Text Label 8000 1100 2    60   ~ 0
L_Off
Text Label 8000 1200 2    60   ~ 0
L_Dim
Text Label 8000 1400 2    60   ~ 0
L_Bright
Text Label 8000 1500 2    60   ~ 0
L_Ditch
Text Label 2800 1350 0    60   ~ 0
Button_A
Text Label 2800 1450 0    60   ~ 0
Button_B
Text Label 2800 1550 0    60   ~ 0
Button_C
Text Label 2800 1650 0    60   ~ 0
Button_D
Text Label 2800 1750 0    60   ~ 0
Bell
Text Label 3450 1850 0    60   ~ 0
Status_G
Text Label 3450 1950 0    60   ~ 0
Status_R
Text Label 4100 4400 2    61   ~ 0
Button_A
Text Label 4100 4500 2    61   ~ 0
Button_B
Text Label 4100 4600 2    61   ~ 0
Button_C
Text Label 4100 4700 2    61   ~ 0
Button_D
Text Label 5950 3200 0    61   ~ 0
Bell
Text Label 5950 3650 0    61   ~ 0
L_Off
Text Label 5950 3750 0    61   ~ 0
L_Dim
Text Label 5950 3850 0    61   ~ 0
L_Bright
Text Label 5950 3950 0    61   ~ 0
L_Ditch
Text Label 4100 4300 2    61   ~ 0
Status_R
Text Label 4100 4200 2    61   ~ 0
Status_G
$Comp
L GND #PWR017
U 1 1 62DF0457
P 1550 1100
F 0 "#PWR017" H 1550 1100 30  0001 C CNN
F 1 "GND" H 1550 1030 30  0001 C CNN
F 2 "" H 1550 1100 60  0000 C CNN
F 3 "" H 1550 1100 60  0000 C CNN
	1    1550 1100
	1    0    0    -1  
$EndComp
$Sheet
S 4100 3100 1850 1800
U 62DF1EBA
F0 "Processor Section" 60
F1 "ProcessorSection.sch" 60
F2 "CAN_RX" I L 4100 3250 60 
F3 "SCL" I L 4100 3550 60 
F4 "SDA" B L 4100 3650 60 
F5 "CAN_TX" O L 4100 3400 60 
F6 "IO18/ADC2_7" I L 4100 3800 60 
F7 "IO17/ADC2_6" I L 4100 3900 60 
F8 "Reset" B L 4100 4050 60 
F9 "IO11/STATUS_G" O L 4100 4200 60 
F10 "IO10/STATUS_R" O L 4100 4300 60 
F11 "IO8/BUTTON_C" I L 4100 4600 60 
F12 "IO46/BUTTON_A" I L 4100 4400 60 
F13 "IO7/BUTTON_B" I L 4100 4500 60 
F14 "IO9/BUTTON_D" I L 4100 4700 60 
F15 "IO47/BELL" I R 5950 3200 60 
F16 "IO16/ADC2_5" I R 5950 3300 60 
F17 "IO12/THROTTLEA" I R 5950 3400 60 
F18 "IO13/THROTTLEB" I R 5950 3500 60 
F19 "IO14/L_OFF" I R 5950 3650 60 
F20 "IO15/L_DIM" I R 5950 3750 60 
F21 "IO21/L_BRIGHT" I R 5950 3850 60 
F22 "IO45/L_DITCH" I R 5950 3950 60 
$EndSheet
$Comp
L Conn_01x04 J3
U 1 1 62E14860
P 8250 6200
F 0 "J3" H 8250 6400 50  0000 C CNN
F 1 "STEMMA (Display)" H 8250 5900 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_B4B-PH-SM4-TB_04x2.00mm_Straight" H 8250 6200 50  0001 C CNN
F 3 "" H 8250 6200 50  0001 C CNN
F 4 "JST" H 8250 6200 60  0001 C CNN "Manufacturer_Name"
F 5 "B4B-PH-SM4-TB" H 8250 6200 60  0001 C CNN "Manufacturer_Part_Number"
	1    8250 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 3850 9300 3850
Wire Wire Line
	9300 3850 9300 3700
Wire Wire Line
	9300 3700 9550 3700
Wire Wire Line
	9200 3950 9400 3950
Wire Wire Line
	9400 3950 9400 3900
Wire Wire Line
	9400 3900 9550 3900
Wire Wire Line
	9200 4050 9400 4050
Wire Wire Line
	9400 4050 9400 4100
Wire Wire Line
	9400 4100 9550 4100
Wire Wire Line
	9150 3100 9600 3100
Wire Wire Line
	9600 3100 9600 3250
Wire Wire Line
	9600 3250 10000 3250
Wire Wire Line
	9150 3000 9850 3000
Wire Wire Line
	9150 2900 9450 2900
Wire Wire Line
	9450 2900 9450 2750
Wire Wire Line
	9450 2750 10000 2750
Wire Wire Line
	10050 2550 9600 2550
Wire Wire Line
	9600 2550 9600 2350
Wire Wire Line
	9600 2350 9100 2350
Wire Wire Line
	9100 2250 9900 2250
Wire Wire Line
	9900 2250 9900 2300
Wire Wire Line
	10050 2050 9300 2050
Wire Wire Line
	9300 2050 9300 2150
Wire Wire Line
	9300 2150 9100 2150
Wire Wire Line
	9250 1100 9350 1100
Wire Wire Line
	9350 1100 9350 1000
Wire Wire Line
	9350 1000 9600 1000
Wire Wire Line
	9250 1200 9400 1200
Wire Wire Line
	9400 1200 9400 1150
Wire Wire Line
	9400 1150 9600 1150
Wire Wire Line
	9250 1500 9450 1500
Wire Wire Line
	9450 1500 9450 1550
Wire Wire Line
	9450 1550 9600 1550
Wire Wire Line
	9250 1400 9600 1400
Wire Wire Line
	10350 1300 9250 1300
Wire Wire Line
	8000 1300 7850 1300
Wire Wire Line
	8000 2000 8000 2150
Wire Wire Line
	8000 2350 8000 2450
Wire Wire Line
	8000 2850 8000 2950
Wire Wire Line
	8000 3150 8000 3250
Wire Wire Line
	8100 3950 7950 3950
Wire Wire Line
	1050 900  1050 2450
Connection ~ 1050 1500
Connection ~ 1050 1750
Connection ~ 1050 2000
Connection ~ 1050 2300
Wire Wire Line
	1700 900  1700 1250
Wire Wire Line
	1050 900  1700 900 
Connection ~ 1050 1200
Wire Wire Line
	1700 1350 1350 1350
Wire Wire Line
	1350 1350 1350 1400
Wire Wire Line
	1350 1400 1250 1400
Wire Wire Line
	1700 1450 1400 1450
Wire Wire Line
	1400 1450 1400 1700
Wire Wire Line
	1400 1700 1250 1700
Wire Wire Line
	1700 1550 1450 1550
Wire Wire Line
	1450 1550 1450 1950
Wire Wire Line
	1450 1950 1250 1950
Wire Wire Line
	1700 1650 1500 1650
Wire Wire Line
	1500 1650 1500 2200
Wire Wire Line
	1500 2200 1250 2200
Wire Wire Line
	1700 1750 1550 1750
Wire Wire Line
	1550 1750 1550 2500
Wire Wire Line
	1550 2500 1250 2500
Wire Wire Line
	1700 1850 1600 1850
Wire Wire Line
	1600 1850 1600 2800
Wire Wire Line
	1600 2800 1500 2800
Wire Wire Line
	1700 1950 1650 1950
Wire Wire Line
	1650 1950 1650 3000
Wire Wire Line
	1650 3000 1500 3000
Wire Wire Line
	3000 1250 2800 1250
Wire Wire Line
	2950 1850 2800 1850
Wire Wire Line
	2950 1950 2800 1950
Wire Wire Line
	3550 5500 3550 5600
Wire Wire Line
	3700 6450 3700 6550
Wire Wire Line
	3700 6650 3900 6650
Wire Wire Line
	3700 6750 3950 6750
Wire Wire Line
	3550 5700 3400 5700
Wire Wire Line
	3400 5700 3400 5650
Wire Wire Line
	3550 5800 3350 5800
Wire Wire Line
	8050 4800 8050 4900
Wire Wire Line
	7550 4900 7400 4900
Wire Wire Line
	6900 4900 6900 4500
Wire Wire Line
	6900 4500 7550 4500
Wire Wire Line
	7550 4500 7550 4350
Wire Wire Line
	8050 4700 6750 4700
Wire Wire Line
	6750 5200 6750 5300
Wire Wire Line
	1550 1100 1550 900 
Connection ~ 1550 900 
Wire Wire Line
	7750 6050 7750 6200
Wire Wire Line
	7750 6200 8050 6200
Wire Wire Line
	900  2450 900  3000
Connection ~ 900  2800
Wire Wire Line
	1050 2450 900  2450
Wire Wire Line
	8050 4500 8050 4600
Wire Wire Line
	9250 4550 9250 4600
Wire Wire Line
	9250 4750 9250 4700
Wire Wire Line
	9250 4950 9250 4800
$Comp
L Mounting_Hole MK5
U 1 1 62E6EC8A
P 10350 3650
F 0 "MK5" H 10350 3850 50  0000 C CNN
F 1 "Mounting_Hole" H 10350 3775 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 10350 3650 50  0001 C CNN
F 3 "" H 10350 3650 50  0001 C CNN
	1    10350 3650
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK6
U 1 1 62E6ED6B
P 10350 3950
F 0 "MK6" H 10350 4150 50  0000 C CNN
F 1 "Mounting_Hole" H 10350 4075 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 10350 3950 50  0001 C CNN
F 3 "" H 10350 3950 50  0001 C CNN
	1    10350 3950
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK7
U 1 1 62E6EE4E
P 10350 4600
F 0 "MK7" H 10350 4800 50  0000 C CNN
F 1 "Mounting_Hole" H 10350 4725 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 10350 4600 50  0001 C CNN
F 3 "" H 10350 4600 50  0001 C CNN
	1    10350 4600
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK8
U 1 1 62E6EF33
P 10350 4950
F 0 "MK8" H 10350 5150 50  0000 C CNN
F 1 "Mounting_Hole" H 10350 5075 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 10350 4950 50  0001 C CNN
F 3 "" H 10350 4950 50  0001 C CNN
	1    10350 4950
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK4
U 1 1 62E6F01A
P 700 850
F 0 "MK4" H 700 1050 50  0000 C CNN
F 1 "Mounting_Hole" H 700 975 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 700 850 50  0001 C CNN
F 3 "" H 700 850 50  0001 C CNN
	1    700  850 
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK1
U 1 1 62E6F103
P 650 1250
F 0 "MK1" H 650 1450 50  0000 C CNN
F 1 "Mounting_Hole" H 650 1375 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 650 1250 50  0001 C CNN
F 3 "" H 650 1250 50  0001 C CNN
	1    650  1250
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK2
U 1 1 62E6F1EE
P 650 1550
F 0 "MK2" H 650 1750 50  0000 C CNN
F 1 "Mounting_Hole" H 650 1675 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 650 1550 50  0001 C CNN
F 3 "" H 650 1550 50  0001 C CNN
	1    650  1550
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK3
U 1 1 62E6F2DB
P 650 1950
F 0 "MK3" H 650 2150 50  0000 C CNN
F 1 "Mounting_Hole" H 650 2075 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_2.5mm" H 650 1950 50  0001 C CNN
F 3 "" H 650 1950 50  0001 C CNN
	1    650  1950
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole FD1
U 1 1 62E6F3CA
P 4650 1150
F 0 "FD1" H 4650 1350 50  0000 C CNN
F 1 "FidMark" H 4650 1275 50  0000 C CNN
F 2 "Fiducials:Fiducial_1mm_Dia_2.54mm_Outer_CopperTop" H 4650 1150 50  0001 C CNN
F 3 "" H 4650 1150 50  0001 C CNN
	1    4650 1150
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole FD2
U 1 1 62E6F73D
P 5150 1100
F 0 "FD2" H 5150 1300 50  0000 C CNN
F 1 "FidMark" H 5150 1225 50  0000 C CNN
F 2 "Fiducials:Fiducial_1mm_Dia_2.54mm_Outer_CopperTop" H 5150 1100 50  0001 C CNN
F 3 "" H 5150 1100 50  0001 C CNN
	1    5150 1100
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole FD3
U 1 1 62E6F8C4
P 5800 1150
F 0 "FD3" H 5800 1350 50  0000 C CNN
F 1 "FidMark" H 5800 1275 50  0000 C CNN
F 2 "Fiducials:Fiducial_1mm_Dia_2.54mm_Outer_CopperTop" H 5800 1150 50  0001 C CNN
F 3 "" H 5800 1150 50  0001 C CNN
	1    5800 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 4950 9250 4950
Wire Wire Line
	9550 4750 9250 4750
Wire Wire Line
	9550 4550 9250 4550
$Comp
L CONN_5 J101
U 1 1 6394B610
P 4225 7575
F 0 "J101" V 4175 7575 50  0000 C CNN
F 1 "Keypad Panel" V 4275 7575 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 4225 7575 60  0001 C CNN
F 3 "~" H 4225 7575 60  0000 C CNN
F 4 "523-G800W303018EU" V 4225 7575 60  0001 C CNN "Mouser Part Number"
	1    4225 7575
	-1   0    0    -1  
$EndComp
Text Label 4625 7675 0    60   ~ 0
SCL
Text Label 4625 7775 0    60   ~ 0
SDA
$Comp
L +5V #PWR018
U 1 1 6394B618
P 4625 7275
F 0 "#PWR018" H 4625 7365 20  0001 C CNN
F 1 "+5V" H 4625 7365 30  0000 C CNN
F 2 "" H 4625 7275 60  0000 C CNN
F 3 "" H 4625 7275 60  0000 C CNN
	1    4625 7275
	-1   0    0    -1  
$EndComp
$Comp
L +3.3V #PWR019
U 1 1 6394B61E
P 4825 7475
F 0 "#PWR019" H 4825 7435 30  0001 C CNN
F 1 "+3.3V" H 4825 7585 30  0000 C CNN
F 2 "" H 4825 7475 60  0000 C CNN
F 3 "" H 4825 7475 60  0000 C CNN
	1    4825 7475
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR020
U 1 1 6394B624
P 4875 7575
F 0 "#PWR020" H 4875 7575 30  0001 C CNN
F 1 "GND" H 4875 7505 30  0001 C CNN
F 2 "" H 4875 7575 60  0000 C CNN
F 3 "" H 4875 7575 60  0000 C CNN
	1    4875 7575
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4625 7275 4625 7375
Wire Wire Line
	4625 7475 4825 7475
Wire Wire Line
	4625 7575 4875 7575
$Sheet
S 900  7050 1775 825 
U 6394C805
F0 "Keypad Panel" 60
F1 "KeypadPanel.sch" 60
$EndSheet
$EndSCHEMATC
