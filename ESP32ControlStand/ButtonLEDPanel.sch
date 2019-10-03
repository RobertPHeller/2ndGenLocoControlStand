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
LIBS:special
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
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 5
Title ""
Date "3 oct 2019"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCP23017 U201
U 1 1 5D93EF0F
P 4100 2400
F 0 "U201" H 3950 2550 60  0000 C CNN
F 1 "MCP23017" H 4100 2400 60  0000 C CNN
F 2 "~" H 4100 2400 60  0000 C CNN
F 3 "~" H 4100 2400 60  0000 C CNN
	1    4100 2400
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 1 1 5D93EFDA
P 8000 1050
F 0 "U202" H 8100 900 60  0000 C CNN
F 1 "TBD62083A" H 8250 1150 60  0000 C CNN
F 2 "~" H 8000 1050 60  0000 C CNN
F 3 "~" H 8000 1050 60  0000 C CNN
	1    8000 1050
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 2 1 5D93EFE7
P 8000 1450
F 0 "U202" H 8100 1300 60  0000 C CNN
F 1 "TBD62083A" H 8250 1550 60  0000 C CNN
F 2 "~" H 8000 1450 60  0000 C CNN
F 3 "~" H 8000 1450 60  0000 C CNN
	2    8000 1450
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 3 1 5D93EFEE
P 8000 1850
F 0 "U202" H 8100 1700 60  0000 C CNN
F 1 "TBD62083A" H 8250 1950 60  0000 C CNN
F 2 "~" H 8000 1850 60  0000 C CNN
F 3 "~" H 8000 1850 60  0000 C CNN
	3    8000 1850
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 4 1 5D93EFF4
P 8000 2250
F 0 "U202" H 8100 2100 60  0000 C CNN
F 1 "TBD62083A" H 8250 2350 60  0000 C CNN
F 2 "~" H 8000 2250 60  0000 C CNN
F 3 "~" H 8000 2250 60  0000 C CNN
	4    8000 2250
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 5 1 5D93F004
P 8000 2600
F 0 "U202" H 8100 2450 60  0000 C CNN
F 1 "TBD62083A" H 8250 2700 60  0000 C CNN
F 2 "~" H 8000 2600 60  0000 C CNN
F 3 "~" H 8000 2600 60  0000 C CNN
	5    8000 2600
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 6 1 5D93F00A
P 8000 3000
F 0 "U202" H 8100 2850 60  0000 C CNN
F 1 "TBD62083A" H 8250 3100 60  0000 C CNN
F 2 "~" H 8000 3000 60  0000 C CNN
F 3 "~" H 8000 3000 60  0000 C CNN
	6    8000 3000
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 7 1 5D93F010
P 8000 3400
F 0 "U202" H 8100 3250 60  0000 C CNN
F 1 "TBD62083A" H 8250 3500 60  0000 C CNN
F 2 "~" H 8000 3400 60  0000 C CNN
F 3 "~" H 8000 3400 60  0000 C CNN
	7    8000 3400
	1    0    0    -1  
$EndComp
$Comp
L TBD62083A U202
U 8 1 5D93F016
P 8000 3800
F 0 "U202" H 8100 3650 60  0000 C CNN
F 1 "TBD62083A" H 8250 3900 60  0000 C CNN
F 2 "~" H 8000 3800 60  0000 C CNN
F 3 "~" H 8000 3800 60  0000 C CNN
	8    8000 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 1550 7400 1550
Wire Wire Line
	7400 1550 7400 1050
Wire Wire Line
	4750 1650 7500 1650
Wire Wire Line
	7500 1650 7500 1450
Wire Wire Line
	7750 1750 7750 1850
Wire Wire Line
	4750 1850 7650 1850
Wire Wire Line
	7650 1850 7650 2250
Wire Wire Line
	4750 1950 7600 1950
Wire Wire Line
	7600 1950 7600 2600
Wire Wire Line
	4750 2050 7550 2050
Wire Wire Line
	7550 2050 7550 3000
Wire Wire Line
	4750 2150 7500 2150
Wire Wire Line
	7500 2150 7500 3400
Wire Wire Line
	4750 2250 7450 2250
Wire Wire Line
	7450 2250 7450 3800
$Comp
L SW_PUSH_SMALL SW208
U 1 1 5D93F166
P 6450 2700
F 0 "SW208" H 6600 2810 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 6450 2621 30  0000 C CNN
F 2 "~" H 6450 2700 60  0000 C CNN
F 3 "~" H 6450 2700 60  0000 C CNN
	1    6450 2700
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW207
U 1 1 5D93F175
P 6350 2800
F 0 "SW207" H 6500 2910 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 6350 2721 30  0000 C CNN
F 2 "~" H 6350 2800 60  0000 C CNN
F 3 "~" H 6350 2800 60  0000 C CNN
	1    6350 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 2600 4750 2600
Wire Wire Line
	6250 2700 4750 2700
$Comp
L SW_PUSH_SMALL SW206
U 1 1 5D93F1B7
P 6250 2900
F 0 "SW206" H 6400 3010 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 6250 2821 30  0000 C CNN
F 2 "~" H 6250 2900 60  0000 C CNN
F 3 "~" H 6250 2900 60  0000 C CNN
	1    6250 2900
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW201
U 1 1 5D93F1C6
P 5750 3400
F 0 "SW201" H 5900 3510 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 5750 3321 30  0000 C CNN
F 2 "~" H 5750 3400 60  0000 C CNN
F 3 "~" H 5750 3400 60  0000 C CNN
	1    5750 3400
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW205
U 1 1 5D93F1D5
P 6150 3000
F 0 "SW205" H 6300 3110 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 6150 2921 30  0000 C CNN
F 2 "~" H 6150 3000 60  0000 C CNN
F 3 "~" H 6150 3000 60  0000 C CNN
	1    6150 3000
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW203
U 1 1 5D93F1E4
P 5950 3200
F 0 "SW203" H 6100 3310 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 5950 3121 30  0000 C CNN
F 2 "~" H 5950 3200 60  0000 C CNN
F 3 "~" H 5950 3200 60  0000 C CNN
	1    5950 3200
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW204
U 1 1 5D93F1F3
P 6050 3100
F 0 "SW204" H 6200 3210 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 6050 3021 30  0000 C CNN
F 2 "~" H 6050 3100 60  0000 C CNN
F 3 "~" H 6050 3100 60  0000 C CNN
	1    6050 3100
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW202
U 1 1 5D93F202
P 5850 3300
F 0 "SW202" H 6000 3410 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 5850 3221 30  0000 C CNN
F 2 "~" H 5850 3300 60  0000 C CNN
F 3 "~" H 5850 3300 60  0000 C CNN
	1    5850 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 2800 4750 2800
Wire Wire Line
	6050 2900 4750 2900
Wire Wire Line
	5950 3000 4750 3000
Wire Wire Line
	5850 3100 4750 3100
Wire Wire Line
	5750 3200 4750 3200
Wire Wire Line
	4750 3300 5650 3300
Wire Wire Line
	6550 2800 6550 2900
Wire Wire Line
	6550 2900 6450 2900
Wire Wire Line
	6450 2900 6450 3000
Wire Wire Line
	6450 3000 6350 3000
Wire Wire Line
	6350 3000 6350 3100
Wire Wire Line
	6350 3100 6250 3100
Wire Wire Line
	6250 3100 6250 3200
Wire Wire Line
	6250 3200 6150 3200
Wire Wire Line
	6150 3200 6150 3300
Wire Wire Line
	6150 3300 6050 3300
Wire Wire Line
	6050 3300 6050 3400
Wire Wire Line
	5950 3400 5950 3650
$Comp
L GND #PWR024
U 1 1 5D93F4A1
P 5950 3650
F 0 "#PWR024" H 5950 3650 30  0001 C CNN
F 1 "GND" H 5950 3580 30  0001 C CNN
F 2 "" H 5950 3650 60  0000 C CNN
F 3 "" H 5950 3650 60  0000 C CNN
	1    5950 3650
	1    0    0    -1  
$EndComp
Connection ~ 5950 3500
$Comp
L LED D201
U 1 1 5D93F5DD
P 10150 1050
F 0 "D201" H 10150 1150 50  0000 C CNN
F 1 "LED" H 10150 950 50  0000 C CNN
F 2 "~" H 10150 1050 60  0000 C CNN
F 3 "~" H 10150 1050 60  0000 C CNN
	1    10150 1050
	-1   0    0    1   
$EndComp
$Comp
L LED D202
U 1 1 5D93F5EC
P 10150 1450
F 0 "D202" H 10150 1550 50  0000 C CNN
F 1 "LED" H 10150 1350 50  0000 C CNN
F 2 "~" H 10150 1450 60  0000 C CNN
F 3 "~" H 10150 1450 60  0000 C CNN
	1    10150 1450
	-1   0    0    1   
$EndComp
$Comp
L LED D203
U 1 1 5D93F5FB
P 10150 1850
F 0 "D203" H 10150 1950 50  0000 C CNN
F 1 "LED" H 10150 1750 50  0000 C CNN
F 2 "~" H 10150 1850 60  0000 C CNN
F 3 "~" H 10150 1850 60  0000 C CNN
	1    10150 1850
	-1   0    0    1   
$EndComp
$Comp
L LED D204
U 1 1 5D93F60A
P 10150 2250
F 0 "D204" H 10150 2350 50  0000 C CNN
F 1 "LED" H 10150 2150 50  0000 C CNN
F 2 "~" H 10150 2250 60  0000 C CNN
F 3 "~" H 10150 2250 60  0000 C CNN
	1    10150 2250
	-1   0    0    1   
$EndComp
$Comp
L LED D205
U 1 1 5D93F619
P 10150 2600
F 0 "D205" H 10150 2700 50  0000 C CNN
F 1 "LED" H 10150 2500 50  0000 C CNN
F 2 "~" H 10150 2600 60  0000 C CNN
F 3 "~" H 10150 2600 60  0000 C CNN
	1    10150 2600
	-1   0    0    1   
$EndComp
$Comp
L LED D206
U 1 1 5D93F628
P 10150 3000
F 0 "D206" H 10150 3100 50  0000 C CNN
F 1 "LED" H 10150 2900 50  0000 C CNN
F 2 "~" H 10150 3000 60  0000 C CNN
F 3 "~" H 10150 3000 60  0000 C CNN
	1    10150 3000
	-1   0    0    1   
$EndComp
$Comp
L LED D207
U 1 1 5D93F637
P 10150 3400
F 0 "D207" H 10150 3500 50  0000 C CNN
F 1 "LED" H 10150 3300 50  0000 C CNN
F 2 "~" H 10150 3400 60  0000 C CNN
F 3 "~" H 10150 3400 60  0000 C CNN
	1    10150 3400
	-1   0    0    1   
$EndComp
$Comp
L LED D208
U 1 1 5D93F646
P 10150 3800
F 0 "D208" H 10150 3900 50  0000 C CNN
F 1 "LED" H 10150 3700 50  0000 C CNN
F 2 "~" H 10150 3800 60  0000 C CNN
F 3 "~" H 10150 3800 60  0000 C CNN
	1    10150 3800
	-1   0    0    1   
$EndComp
$Comp
L R_PACK8 RP201
U 1 1 5D93F655
P 8750 2650
F 0 "RP201" H 8750 3100 40  0000 C CNN
F 1 "R_PACK8" H 8750 2200 40  0000 C CNN
F 2 "~" H 8750 2650 60  0000 C CNN
F 3 "~" H 8750 2650 60  0000 C CNN
	1    8750 2650
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR025
U 1 1 5D93F66E
P 8000 750
F 0 "#PWR025" H 8000 700 20  0001 C CNN
F 1 "+BATT" H 8000 850 30  0000 C CNN
F 2 "" H 8000 750 60  0000 C CNN
F 3 "" H 8000 750 60  0000 C CNN
	1    8000 750 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR026
U 1 1 5D93F67D
P 8000 4200
F 0 "#PWR026" H 8000 4200 30  0001 C CNN
F 1 "GND" H 8000 4130 30  0001 C CNN
F 2 "" H 8000 4200 60  0000 C CNN
F 3 "" H 8000 4200 60  0000 C CNN
	1    8000 4200
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR027
U 1 1 5D93F68C
P 10500 650
F 0 "#PWR027" H 10500 600 20  0001 C CNN
F 1 "+BATT" H 10500 750 30  0000 C CNN
F 2 "" H 10500 650 60  0000 C CNN
F 3 "" H 10500 650 60  0000 C CNN
	1    10500 650 
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 750  8000 950 
Wire Wire Line
	8000 3900 8000 4200
Wire Wire Line
	8450 2500 8550 2500
Wire Wire Line
	8450 1850 8450 2500
Wire Wire Line
	8500 2400 8550 2400
Wire Wire Line
	8500 1450 8500 2400
Wire Wire Line
	8550 2300 8550 1050
Wire Wire Line
	8550 1050 8300 1050
Wire Wire Line
	8500 1450 8300 1450
Wire Wire Line
	8450 1850 8300 1850
Wire Wire Line
	8300 2250 8400 2250
Wire Wire Line
	8400 2250 8400 2600
Wire Wire Line
	8400 2600 8550 2600
Wire Wire Line
	8300 2600 8350 2600
Wire Wire Line
	8350 2600 8350 2700
Wire Wire Line
	8350 2700 8550 2700
Wire Wire Line
	8300 3000 8350 3000
Wire Wire Line
	8350 3000 8350 2800
Wire Wire Line
	8350 2800 8550 2800
Wire Wire Line
	8300 3400 8400 3400
Wire Wire Line
	8400 3400 8400 2900
Wire Wire Line
	8400 2900 8550 2900
Wire Wire Line
	8300 3800 8450 3800
Wire Wire Line
	8450 3800 8450 3000
Wire Wire Line
	8450 3000 8550 3000
Wire Wire Line
	8950 2300 8950 1050
Wire Wire Line
	8950 1050 9950 1050
Wire Wire Line
	9000 1450 9950 1450
Wire Wire Line
	9000 1450 9000 2400
Wire Wire Line
	9000 2400 8950 2400
Wire Wire Line
	9050 1850 9950 1850
Wire Wire Line
	9050 1850 9050 2500
Wire Wire Line
	9050 2500 8950 2500
Wire Wire Line
	9100 2550 9000 2550
Wire Wire Line
	9000 2550 9000 2600
Wire Wire Line
	9000 2600 8950 2600
Wire Wire Line
	9050 2600 9950 2600
Wire Wire Line
	9050 2600 9050 2700
Wire Wire Line
	9050 2700 8950 2700
Wire Wire Line
	8950 2900 9050 2900
Wire Wire Line
	9050 2900 9050 3400
Wire Wire Line
	9050 3400 9950 3400
Wire Wire Line
	8950 3000 9000 3000
Wire Wire Line
	9000 3000 9000 3800
Wire Wire Line
	9000 3800 9950 3800
Wire Wire Line
	10350 650  10350 4150
Connection ~ 10350 3400
Connection ~ 10350 3000
Connection ~ 10350 2600
Connection ~ 10350 2250
Connection ~ 10350 1850
Connection ~ 10350 1450
Wire Wire Line
	10350 650  10500 650 
Connection ~ 10350 1050
$Comp
L GND #PWR028
U 1 1 5D94002B
P 4000 3850
F 0 "#PWR028" H 4000 3850 30  0001 C CNN
F 1 "GND" H 4000 3780 30  0001 C CNN
F 2 "" H 4000 3850 60  0000 C CNN
F 3 "" H 4000 3850 60  0000 C CNN
	1    4000 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 3650 4000 3850
$Comp
L +3.3V #PWR029
U 1 1 5D94010D
P 4100 1000
F 0 "#PWR029" H 4100 960 30  0001 C CNN
F 1 "+3.3V" H 4100 1110 30  0000 C CNN
F 2 "" H 4100 1000 60  0000 C CNN
F 3 "" H 4100 1000 60  0000 C CNN
	1    4100 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 1000 4100 1200
Wire Wire Line
	3400 1850 3400 2200
Connection ~ 3400 1950
$Comp
L GND #PWR030
U 1 1 5D94025D
P 3400 2200
F 0 "#PWR030" H 3400 2200 30  0001 C CNN
F 1 "GND" H 3400 2130 30  0001 C CNN
F 2 "" H 3400 2200 60  0000 C CNN
F 3 "" H 3400 2200 60  0000 C CNN
	1    3400 2200
	1    0    0    -1  
$EndComp
Connection ~ 3400 2050
$Comp
L R R201
U 1 1 5D940347
P 3050 2850
F 0 "R201" V 3130 2850 40  0000 C CNN
F 1 "10K Ohms" V 3057 2851 40  0000 C CNN
F 2 "~" V 2980 2850 30  0000 C CNN
F 3 "~" H 3050 2850 30  0000 C CNN
	1    3050 2850
	0    -1   -1   0   
$EndComp
$Comp
L +3.3V #PWR031
U 1 1 5D94035B
P 2600 2850
F 0 "#PWR031" H 2600 2810 30  0001 C CNN
F 1 "+3.3V" H 2600 2960 30  0000 C CNN
F 2 "" H 2600 2850 60  0000 C CNN
F 3 "" H 2600 2850 60  0000 C CNN
	1    2600 2850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3400 2850 3300 2850
Wire Wire Line
	2800 2850 2600 2850
$Comp
L CONN_5 P201
U 1 1 5D94044C
P 2150 1700
F 0 "P201" V 2100 1700 50  0000 C CNN
F 1 "CONN_5" V 2200 1700 50  0000 C CNN
F 2 "~" H 2150 1700 60  0000 C CNN
F 3 "~" H 2150 1700 60  0000 C CNN
	1    2150 1700
	-1   0    0    -1  
$EndComp
$Comp
L +BATT #PWR032
U 1 1 5D94045B
P 2750 1400
F 0 "#PWR032" H 2750 1350 20  0001 C CNN
F 1 "+BATT" H 2750 1500 30  0000 C CNN
F 2 "" H 2750 1400 60  0000 C CNN
F 3 "" H 2750 1400 60  0000 C CNN
	1    2750 1400
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR033
U 1 1 5D94046A
P 2750 1550
F 0 "#PWR033" H 2750 1510 30  0001 C CNN
F 1 "+3.3V" H 2750 1660 30  0000 C CNN
F 2 "" H 2750 1550 60  0000 C CNN
F 3 "" H 2750 1550 60  0000 C CNN
	1    2750 1550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR034
U 1 1 5D94049C
P 2800 1700
F 0 "#PWR034" H 2800 1700 30  0001 C CNN
F 1 "GND" H 2800 1630 30  0001 C CNN
F 2 "" H 2800 1700 60  0000 C CNN
F 3 "" H 2800 1700 60  0000 C CNN
	1    2800 1700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2550 1500 2700 1500
Wire Wire Line
	2700 1500 2700 1400
Wire Wire Line
	2700 1400 2750 1400
Wire Wire Line
	2550 1600 2700 1600
Wire Wire Line
	2700 1600 2700 1550
Wire Wire Line
	2700 1550 2750 1550
Wire Wire Line
	2800 1700 2550 1700
Wire Wire Line
	2550 1800 3000 1800
Wire Wire Line
	3000 1800 3000 1600
Wire Wire Line
	3000 1600 3400 1600
Wire Wire Line
	2550 1900 3050 1900
Wire Wire Line
	3050 1900 3050 1700
Wire Wire Line
	3050 1700 3400 1700
$Comp
L CONN_9 T201
U 1 1 5D9496BD
P 5350 4600
F 0 "T201" V 5300 4600 60  0000 C CNN
F 1 "Buttons" V 5400 4600 60  0000 C CNN
F 2 "~" H 5350 4600 60  0000 C CNN
F 3 "~" H 5350 4600 60  0000 C CNN
	1    5350 4600
	0    1    1    0   
$EndComp
$Comp
L CONN_9 T202
U 1 1 5D9496CC
P 9600 4500
F 0 "T202" V 9550 4500 60  0000 C CNN
F 1 "LEDS" V 9650 4500 60  0000 C CNN
F 2 "~" H 9600 4500 60  0000 C CNN
F 3 "~" H 9600 4500 60  0000 C CNN
	1    9600 4500
	0    1    1    0   
$EndComp
Connection ~ 5850 3500
Wire Wire Line
	6050 3400 5950 3400
Wire Wire Line
	5750 4250 5750 3500
Wire Wire Line
	5750 3500 5950 3500
Wire Wire Line
	5650 3300 5650 4250
Wire Wire Line
	5550 4250 5550 3200
Connection ~ 5550 3200
Wire Wire Line
	5450 4250 5450 3100
Connection ~ 5450 3100
Wire Wire Line
	5350 4250 5350 3000
Connection ~ 5350 3000
Wire Wire Line
	5250 4250 5250 2900
Connection ~ 5250 2900
Wire Wire Line
	5150 4250 5150 2800
Connection ~ 5150 2800
Wire Wire Line
	5050 4250 5050 2700
Connection ~ 5050 2700
Wire Wire Line
	4950 4250 4950 2600
Connection ~ 4950 2600
Wire Wire Line
	4750 1750 7750 1750
Wire Wire Line
	7400 1050 7750 1050
Wire Wire Line
	7500 1450 7750 1450
Wire Wire Line
	7650 2250 7750 2250
Wire Wire Line
	7600 2600 7750 2600
Wire Wire Line
	7550 3000 7750 3000
Wire Wire Line
	7500 3400 7750 3400
Wire Wire Line
	7450 3800 7750 3800
Wire Wire Line
	9950 2250 9100 2250
Wire Wire Line
	9100 2250 9100 2550
Wire Wire Line
	9100 3000 9950 3000
Wire Wire Line
	9100 2800 9100 3000
Wire Wire Line
	9100 2800 8950 2800
Wire Wire Line
	9200 4150 9200 1050
Connection ~ 9200 1050
Wire Wire Line
	9300 4150 9300 1450
Connection ~ 9300 1450
Wire Wire Line
	9400 4150 9400 1850
Connection ~ 9400 1850
Wire Wire Line
	9500 4150 9500 2250
Connection ~ 9500 2250
Wire Wire Line
	9600 4150 9600 2600
Connection ~ 9600 2600
Wire Wire Line
	9700 4150 9700 3000
Connection ~ 9700 3000
Wire Wire Line
	9800 4150 9800 3400
Connection ~ 9800 3400
Wire Wire Line
	9900 4150 9900 3800
Connection ~ 9900 3800
Wire Wire Line
	10350 4150 10000 4150
Connection ~ 10350 3800
Connection ~ 6450 2900
Connection ~ 6350 3000
Connection ~ 6250 3100
Connection ~ 6150 3200
Connection ~ 6050 3300
Connection ~ 5950 3400
Connection ~ 5650 3300
NoConn ~ 3400 2500
NoConn ~ 3400 2650
$Comp
L C C201
U 1 1 5D95DF47
P 2750 2350
F 0 "C201" H 2750 2450 40  0000 L CNN
F 1 ".1 uf" H 2756 2265 40  0000 L CNN
F 2 "~" H 2788 2200 30  0000 C CNN
F 3 "~" H 2750 2350 60  0000 C CNN
	1    2750 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 2550 2750 2850
Connection ~ 2750 2850
Wire Wire Line
	2750 2150 3400 2150
Connection ~ 3400 2150
$EndSCHEMATC
