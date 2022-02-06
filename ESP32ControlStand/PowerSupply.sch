EESchema Schematic File Version 2
LIBS:power
LIBS:device
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
LIBS:encoder
LIBS:rotatry_switch
LIBS:i2c_display
LIBS:MCP23xxx
LIBS:tbd62x83a
LIBS:esp32_devboards
LIBS:lm2574n-5
LIBS:sn65hvd233-ht
LIBS:adafruit_powerboost_500
LIBS:ESP32ControlStand-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 5
Title ""
Date "12 oct 2019"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LM2574N-5.0 U501
U 1 1 5D94AA59
P 5200 2800
F 0 "U501" H 5200 2850 60  0000 C CNN
F 1 "LM2574N-5.0" H 5200 2950 21  0000 C CNN
F 2 "~" H 5200 2800 60  0000 C CNN
F 3 "~" H 5200 2800 60  0000 C CNN
F 4 "926-LM2574N-5.0/NOPB" H 5200 2800 60  0001 C CNN "Mouser Part Number"
	1    5200 2800
	1    0    0    -1  
$EndComp
$Comp
L CP1-RESCUE-ESP32ControlStand C502
U 1 1 5D94AA5A
P 5950 2900
F 0 "C502" H 6000 3000 50  0000 L CNN
F 1 "22 uf 100V" H 6000 2800 50  0000 L CNN
F 2 "~" H 5950 2900 60  0000 C CNN
F 3 "~" H 5950 2900 60  0000 C CNN
F 4 "140-REA220M2ABK0811P" H 5950 2900 60  0001 C CNN "Mouser Part Number"
	1    5950 2900
	1    0    0    -1  
$EndComp
$Comp
L CP1-RESCUE-ESP32ControlStand C501
U 1 1 5D94AA5B
P 3700 2800
F 0 "C501" H 3750 2900 50  0000 L CNN
F 1 "220 uf 25V" H 3750 2700 50  0000 L CNN
F 2 "~" H 3700 2800 60  0000 C CNN
F 3 "~" H 3700 2800 60  0000 C CNN
F 4 "140-REA221M1EBK0811P" H 3700 2800 60  0001 C CNN "Mouser Part Number"
	1    3700 2800
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR_SMALL L501
U 1 1 5D94AA5C
P 4550 2900
F 0 "L501" H 4550 3000 50  0000 C CNN
F 1 "330 uh" H 4550 2850 50  0000 C CNN
F 2 "~" H 4550 2900 60  0000 C CNN
F 3 "~" H 4550 2900 60  0000 C CNN
F 4 "PE-52627NL" H 4550 2900 60  0001 C CNN "Mouser Part Number"
	1    4550 2900
	1    0    0    -1  
$EndComp
$Comp
L DIODESCH D501
U 1 1 5D94AA5D
P 4850 3100
F 0 "D501" H 4850 3200 40  0000 C CNN
F 1 "SB160-E3/54" H 4850 3000 40  0000 C CNN
F 2 "~" H 4850 3100 60  0000 C CNN
F 3 "~" H 4850 3100 60  0000 C CNN
F 4 "625-SB160-E3" H 4850 3100 60  0001 C CNN "Mouser Part Number"
	1    4850 3100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5950 2700 5500 2700
Wire Wire Line
	4900 2600 3700 2600
Wire Wire Line
	4300 2900 4300 2600
Connection ~ 4300 2600
Wire Wire Line
	4800 2900 4900 2900
Connection ~ 4850 2900
Wire Wire Line
	5950 3150 5950 3100
Wire Wire Line
	5150 3150 5950 3150
Connection ~ 5350 3150
Connection ~ 5250 3150
Wire Wire Line
	5150 3300 5150 3150
Wire Wire Line
	3700 3300 5150 3300
Wire Wire Line
	3700 3300 3700 3000
Connection ~ 4850 3300
$Comp
L GND-RESCUE-ESP32ControlStand #PWR054
U 1 1 5D94AA5E
P 4850 3400
F 0 "#PWR054" H 4850 3400 30  0001 C CNN
F 1 "GND" H 4850 3330 30  0001 C CNN
F 2 "" H 4850 3400 60  0000 C CNN
F 3 "" H 4850 3400 60  0000 C CNN
	1    4850 3400
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR055
U 1 1 5D94AA5F
P 5950 2550
F 0 "#PWR055" H 5950 2500 20  0001 C CNN
F 1 "+12V" H 5950 2650 30  0000 C CNN
F 2 "" H 5950 2550 60  0000 C CNN
F 3 "" H 5950 2550 60  0000 C CNN
	1    5950 2550
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR056
U 1 1 5D94AA60
P 3700 2450
F 0 "#PWR056" H 3700 2540 20  0001 C CNN
F 1 "+5V" H 3700 2540 30  0000 C CNN
F 2 "" H 3700 2450 60  0000 C CNN
F 3 "" H 3700 2450 60  0000 C CNN
	1    3700 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 2550 5950 2700
Wire Wire Line
	3700 2600 3700 2450
Wire Wire Line
	4850 3300 4850 3400
$EndSCHEMATC
