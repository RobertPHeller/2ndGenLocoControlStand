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
LIBS:ESP32-D0WD-V3
LIBS:W25Q32JVSSIQ
LIBS:mcp73871
LIBS:lm2574n-5
LIBS:ESP32-D0WD-V3-ControlStand-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 6 6
Title "ESP32-D0WD-V3-ControlStand"
Date "2022-07-25"
Rev "1.0"
Comp "Deepwoods Software"
Comment1 "Processor Section"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L W25Q32JVSSIQ U?
U 1 1 62DF2386
P 7100 3800
F 0 "U?" H 7900 3700 50  0000 L CNN
F 1 "W25Q32JVSSIQ" H 7500 3500 50  0000 L CNN
F 2 "Housings_SOIC:SOIC-8_3.9x4.9mm_Pitch1.27mm" H 8450 3900 50  0001 L CNN
F 3 "https://componentsearchengine.com//W25Q32JVSSIQ.pdf" H 8450 3800 50  0001 L CNN
F 4 "NOR Flash spiFlash, 32M-bit, DTR, 4Kb Uniform Sector" H 8450 3700 50  0001 L CNN "Description"
F 5 "2.16" H 8450 3600 50  0001 L CNN "Height"
F 6 "454-W25Q32JVSSIQ" H 8450 3500 50  0001 L CNN "Mouser Part Number"
F 7 "https://www.mouser.com/Search/Refine.aspx?Keyword=454-W25Q32JVSSIQ" H 8450 3400 50  0001 L CNN "Mouser2 Price/Stock"
F 8 "Winbond" H 8450 3300 50  0001 L CNN "Manufacturer_Name"
F 9 "W25Q32JVSSIQ" H 8450 3200 50  0001 L CNN "Manufacturer_Part_Number"
	1    7100 3800
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF2387
P 8850 3450
F 0 "#PWR?" H 8850 3300 50  0001 C CNN
F 1 "+3.3V" H 8850 3590 50  0000 C CNN
F 2 "" H 8850 3450 50  0001 C CNN
F 3 "" H 8850 3450 50  0001 C CNN
	1    8850 3450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 62DF2388
P 7000 4400
F 0 "#PWR?" H 7000 4150 50  0001 C CNN
F 1 "GND" H 7000 4250 50  0000 C CNN
F 2 "" H 7000 4400 50  0001 C CNN
F 3 "" H 7000 4400 50  0001 C CNN
	1    7000 4400
	1    0    0    -1  
$EndComp
Text Label 7950 2350 2    60   ~ 0
BOOTMODE
Text Label 6050 5500 3    60   ~ 0
BOOTMODE
Text Label 4700 4000 2    60   ~ 0
RESET
$Comp
L R R?
U 1 1 62DF238C
P 6150 2250
F 0 "R?" V 6230 2250 50  0000 C CNN
F 1 "49.9" V 6150 2250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6080 2250 50  0001 C CNN
F 3 "" H 6150 2250 50  0001 C CNN
F 4 "791-RMC1/16SK49R9FTH" V 6150 2250 60  0001 C CNN "Mouser Part Number"
	1    6150 2250
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 62DF238D
P 6050 2250
F 0 "R?" V 6130 2250 50  0000 C CNN
F 1 "49.9" V 6050 2250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5980 2250 50  0001 C CNN
F 3 "" H 6050 2250 50  0001 C CNN
F 4 "791-RMC1/16SK49R9FTH" V 6050 2250 60  0001 C CNN "Mouser Part Number"
	1    6050 2250
	1    0    0    -1  
$EndComp
Text Label 6150 2100 0    60   ~ 0
RX
Text Label 6050 2100 0    60   ~ 0
TX
$Comp
L C_Small C?
U 1 1 62DF238E
P 3650 4150
F 0 "C?" H 3660 4220 50  0000 L CNN
F 1 "1uf" H 3660 4070 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3650 4150 50  0001 C CNN
F 3 "" H 3650 4150 50  0001 C CNN
F 4 "80-C0402C101K8RAUTO" H 3650 4150 60  0001 C CNN "Mouser Part Number"
	1    3650 4150
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 62DF238F
P 3650 3750
F 0 "R?" V 3730 3750 50  0000 C CNN
F 1 "10K" V 3650 3750 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3580 3750 50  0001 C CNN
F 3 "" H 3650 3750 50  0001 C CNN
F 4 "603-RC0402JR-1310KL" V 3650 3750 60  0001 C CNN "Mouser Part Number"
	1    3650 3750
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW?
U 1 1 62DF2390
P 3350 4000
F 0 "SW?" H 3400 4100 50  0000 L CNN
F 1 "RESET" H 3350 3940 50  0000 C CNN
F 2 "PTS647SN70SMTR2LFS:PTS647SM38SMTR2LFS" H 3350 4200 50  0001 C CNN
F 3 "" H 3350 4200 50  0001 C CNN
F 4 "611-PTS647SN70SMTR2L" H 3350 4000 60  0001 C CNN "Mouser Part Number"
	1    3350 4000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 62DF2391
P 3650 4350
F 0 "#PWR?" H 3650 4100 50  0001 C CNN
F 1 "GND" H 3650 4200 50  0000 C CNN
F 2 "" H 3650 4350 50  0001 C CNN
F 3 "" H 3650 4350 50  0001 C CNN
	1    3650 4350
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF2392
P 3650 3550
F 0 "#PWR?" H 3650 3400 50  0001 C CNN
F 1 "+3.3V" H 3650 3690 50  0000 C CNN
F 2 "" H 3650 3550 50  0001 C CNN
F 3 "" H 3650 3550 50  0001 C CNN
	1    3650 3550
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF2393
P 7200 4600
F 0 "C?" H 7210 4670 50  0000 L CNN
F 1 "1uf" H 7210 4520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7200 4600 50  0001 C CNN
F 3 "" H 7200 4600 50  0001 C CNN
F 4 "80-C0402C101K8RAUTO" H 7200 4600 60  0001 C CNN "Mouser Part Number"
	1    7200 4600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 62DF2394
P 7200 4800
F 0 "#PWR?" H 7200 4550 50  0001 C CNN
F 1 "GND" H 7200 4650 50  0000 C CNN
F 2 "" H 7200 4800 50  0001 C CNN
F 3 "" H 7200 4800 50  0001 C CNN
	1    7200 4800
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF2395
P 7400 4500
F 0 "#PWR?" H 7400 4350 50  0001 C CNN
F 1 "+3.3V" H 7400 4640 50  0000 C CNN
F 2 "" H 7400 4500 50  0001 C CNN
F 3 "" H 7400 4500 50  0001 C CNN
	1    7400 4500
	0    1    1    0   
$EndComp
$Comp
L L_Small L?
U 1 1 62DF2396
P 4500 3000
F 0 "L?" H 4530 3040 50  0000 L CNN
F 1 "2.0nH" H 4530 2960 50  0000 L CNN
F 2 "Inductors_SMD:L_0402" H 4500 3000 50  0001 C CNN
F 3 "" H 4500 3000 50  0001 C CNN
F 4 "810-MLG1005S2N0ST000 " H 4500 3000 60  0001 C CNN "Mouser Part Number"
	1    4500 3000
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF2397
P 4500 2800
F 0 "#PWR?" H 4500 2650 50  0001 C CNN
F 1 "+3.3V" H 4500 2940 50  0000 C CNN
F 2 "" H 4500 2800 50  0001 C CNN
F 3 "" H 4500 2800 50  0001 C CNN
	1    4500 2800
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF2398
P 6950 3300
F 0 "#PWR?" H 6950 3150 50  0001 C CNN
F 1 "+3.3V" H 6950 3440 50  0000 C CNN
F 2 "" H 6950 3300 50  0001 C CNN
F 3 "" H 6950 3300 50  0001 C CNN
	1    6950 3300
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF2399
P 5850 2150
F 0 "#PWR?" H 5850 2000 50  0001 C CNN
F 1 "+3.3V" H 5850 2290 50  0000 C CNN
F 2 "" H 5850 2150 50  0001 C CNN
F 3 "" H 5850 2150 50  0001 C CNN
	1    5850 2150
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF239A
P 5650 5650
F 0 "#PWR?" H 5650 5500 50  0001 C CNN
F 1 "+3.3V" H 5650 5790 50  0000 C CNN
F 2 "" H 5650 5650 50  0001 C CNN
F 3 "" H 5650 5650 50  0001 C CNN
	1    5650 5650
	-1   0    0    1   
$EndComp
Text Label 4500 3400 0    60   ~ 0
VDD3P3
$Comp
L GND #PWR?
U 1 1 62DF239B
P 5250 2400
F 0 "#PWR?" H 5250 2150 50  0001 C CNN
F 1 "GND" H 5250 2250 50  0000 C CNN
F 2 "" H 5250 2400 50  0001 C CNN
F 3 "" H 5250 2400 50  0001 C CNN
	1    5250 2400
	-1   0    0    1   
$EndComp
$Comp
L Crystal_GND24 Y?
U 1 1 62DF239C
P 5650 1550
F 0 "Y?" H 5450 1450 50  0000 L CNN
F 1 "40 Mhz +/- 10 ppm" H 5100 1400 50  0000 L CNN
F 2 "FA_20H:FA20_H" H 5650 1550 50  0001 C CNN
F 3 "https://www.mouser.com/datasheet/2/137/FA_20H_en-1062154.pdf" H 5650 1550 50  0001 C CNN
F 4 "732-FA-20H40MF10Z-W3 " H 5650 1550 60  0001 C CNN "Mouser Part Number"
	1    5650 1550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8850 3450 8850 3800
Wire Wire Line
	8850 3800 8600 3800
Wire Wire Line
	7000 4400 7000 4100
Wire Wire Line
	7000 4100 7100 4100
Wire Wire Line
	7100 3800 6900 3800
Wire Wire Line
	6900 3800 6900 4000
Wire Wire Line
	6900 4000 6650 4000
Wire Wire Line
	6650 3800 6800 3800
Wire Wire Line
	6800 3800 6800 3900
Wire Wire Line
	6800 3900 7100 3900
Wire Wire Line
	7100 4000 6950 4000
Wire Wire Line
	6950 4000 6950 4100
Wire Wire Line
	6950 4100 6650 4100
Wire Wire Line
	8600 4100 9000 4100
Wire Wire Line
	9000 4100 9000 3500
Wire Wire Line
	9000 3500 6900 3500
Wire Wire Line
	6900 3500 6900 3700
Wire Wire Line
	6900 3700 6650 3700
Wire Wire Line
	8600 4000 8850 4000
Wire Wire Line
	8850 4000 8850 4300
Wire Wire Line
	8850 4300 6750 4300
Wire Wire Line
	6750 4300 6750 3900
Wire Wire Line
	6750 3900 6650 3900
Wire Wire Line
	6650 4200 7150 4200
Wire Wire Line
	7150 4200 7150 4400
Wire Wire Line
	7150 4400 8900 4400
Wire Wire Line
	8900 4400 8900 3900
Wire Wire Line
	8900 3900 8600 3900
Wire Wire Line
	6050 5500 6050 5400
Wire Wire Line
	3550 4000 4850 4000
Wire Wire Line
	6150 2400 6150 2500
Wire Wire Line
	6050 2400 6050 2500
Wire Wire Line
	3650 3900 3650 4050
Connection ~ 3650 4000
Wire Wire Line
	3650 3550 3650 3600
Wire Wire Line
	3650 4250 3650 4350
Wire Wire Line
	3150 4350 3150 4000
Wire Wire Line
	6650 4400 6750 4400
Wire Wire Line
	6750 4400 6750 4500
Wire Wire Line
	6750 4500 7400 4500
Wire Wire Line
	7200 4700 7200 4800
Connection ~ 7200 4500
Wire Wire Line
	4850 3400 4850 3500
Wire Wire Line
	4850 3400 4500 3400
Wire Wire Line
	4500 3400 4500 3100
Wire Wire Line
	4500 2800 4500 2900
Wire Wire Line
	4850 3200 4850 2800
Wire Wire Line
	4850 2800 4500 2800
Wire Wire Line
	5850 2150 5850 2500
Wire Wire Line
	5850 2250 5550 2250
Wire Wire Line
	5550 2250 5550 2500
Wire Wire Line
	6650 3300 6950 3300
Connection ~ 5850 2250
Wire Wire Line
	5650 5400 5650 5650
Wire Wire Line
	5250 2500 5250 2400
Wire Wire Line
	5750 2500 5750 1800
Wire Wire Line
	5750 1800 5900 1800
Wire Wire Line
	5900 1800 5900 1450
Wire Wire Line
	5900 1550 5800 1550
Wire Wire Line
	5650 2500 5650 1950
Wire Wire Line
	5650 1950 5400 1950
Wire Wire Line
	5400 1950 5400 1450
Wire Wire Line
	5400 1550 5500 1550
$Comp
L GND #PWR?
U 1 1 62DF239D
P 5650 1800
F 0 "#PWR?" H 5650 1550 50  0001 C CNN
F 1 "GND" H 5650 1650 50  0000 C CNN
F 2 "" H 5650 1800 50  0001 C CNN
F 3 "" H 5650 1800 50  0001 C CNN
	1    5650 1800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 62DF239E
P 5650 1250
F 0 "#PWR?" H 5650 1000 50  0001 C CNN
F 1 "GND" H 5650 1100 50  0000 C CNN
F 2 "" H 5650 1250 50  0001 C CNN
F 3 "" H 5650 1250 50  0001 C CNN
	1    5650 1250
	-1   0    0    1   
$EndComp
Wire Wire Line
	5650 1250 5650 1350
Wire Wire Line
	5650 1800 5650 1750
$Comp
L C_Small C?
U 1 1 62DF239F
P 5900 1350
F 0 "C?" H 5910 1420 50  0000 L CNN
F 1 "22pf" H 5910 1270 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5900 1350 50  0001 C CNN
F 3 "" H 5900 1350 50  0001 C CNN
F 4 "187-CL05C220JB5NNND" H 5900 1350 60  0001 C CNN "Mouser Part Number"
	1    5900 1350
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23A0
P 5400 1350
F 0 "C?" H 5410 1420 50  0000 L CNN
F 1 "22pf" H 5410 1270 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5400 1350 50  0001 C CNN
F 3 "" H 5400 1350 50  0001 C CNN
F 4 "187-CL05C220JB5NNND" H 5400 1350 60  0001 C CNN "Mouser Part Number"
	1    5400 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 1250 5900 1250
Connection ~ 5650 1250
Connection ~ 5900 1550
Connection ~ 5400 1550
$Comp
L R R?
U 1 1 62DF23A1
P 4950 2000
F 0 "R?" V 5030 2000 50  0000 C CNN
F 1 "20K" V 4950 2000 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 4880 2000 50  0001 C CNN
F 3 "" H 4950 2000 50  0001 C CNN
F 4 "791-RMC10K203FTH " V 4950 2000 60  0001 C CNN "Mouser Part Number"
	1    4950 2000
	0    1    1    0   
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23A2
P 4950 2150
F 0 "C?" H 4960 2220 50  0000 L CNN
F 1 "3nf" H 4960 2070 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4950 2150 50  0001 C CNN
F 3 "" H 4950 2150 50  0001 C CNN
F 4 "81-GRM1557U1A302JA1D" H 4950 2150 60  0001 C CNN "Mouser Part Number"
	1    4950 2150
	0    1    1    0   
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23A3
P 4550 2100
F 0 "C?" H 4560 2170 50  0000 L CNN
F 1 "10nf" H 4560 2020 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4550 2100 50  0001 C CNN
F 3 "" H 4550 2100 50  0001 C CNN
F 4 "81-GRM155R61E103KA1D" H 4550 2100 60  0001 C CNN "Mouser Part Number"
	1    4550 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 2000 5450 2500
Wire Wire Line
	5100 2000 5450 2000
Wire Wire Line
	5050 2150 5150 2150
Wire Wire Line
	5150 2150 5150 2000
Connection ~ 5150 2000
Wire Wire Line
	4550 2000 4800 2000
Wire Wire Line
	4850 2150 4750 2150
Wire Wire Line
	4750 2000 4750 2200
Connection ~ 4750 2000
Wire Wire Line
	5350 2200 5350 2500
Wire Wire Line
	4750 2200 5350 2200
Connection ~ 4750 2150
$Comp
L GND #PWR?
U 1 1 62DF23A4
P 4550 2300
F 0 "#PWR?" H 4550 2050 50  0001 C CNN
F 1 "GND" H 4550 2150 50  0000 C CNN
F 2 "" H 4550 2300 50  0001 C CNN
F 3 "" H 4550 2300 50  0001 C CNN
	1    4550 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 2200 4550 2300
$Comp
L C_Small C?
U 1 1 62DF23A5
P 1800 2750
F 0 "C?" H 1810 2820 50  0000 L CNN
F 1 "10uf" H 1810 2670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 1800 2750 50  0001 C CNN
F 3 "" H 1800 2750 50  0001 C CNN
F 4 "187-CL21A106MQFNNNE" H 1800 2750 60  0001 C CNN "Mouser Part Number"
	1    1800 2750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23A6
P 2050 2750
F 0 "C?" H 2060 2820 50  0000 L CNN
F 1 "10uf" H 2060 2670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 2050 2750 50  0001 C CNN
F 3 "" H 2050 2750 50  0001 C CNN
F 4 "187-CL21A106MQFNNNE" H 2050 2750 60  0001 C CNN "Mouser Part Number"
	1    2050 2750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23A7
P 2300 2750
F 0 "C?" H 2310 2820 50  0000 L CNN
F 1 "1uf" H 2310 2670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2300 2750 50  0001 C CNN
F 3 "" H 2300 2750 50  0001 C CNN
F 4 "80-C0402C101K8RAUTO" H 2300 2750 60  0001 C CNN "Mouser Part Number"
	1    2300 2750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23A8
P 2550 2750
F 0 "C?" H 2560 2820 50  0000 L CNN
F 1 "100nf" H 2560 2670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2550 2750 50  0001 C CNN
F 3 "" H 2550 2750 50  0001 C CNN
F 4 "710-885012105001" H 2550 2750 60  0001 C CNN "Mouser Part Number"
	1    2550 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 2650 2550 2650
Connection ~ 2300 2650
Connection ~ 2050 2650
Wire Wire Line
	1800 2850 2550 2850
Connection ~ 2300 2850
Connection ~ 2050 2850
$Comp
L GND #PWR?
U 1 1 62DF23A9
P 2550 3000
F 0 "#PWR?" H 2550 2750 50  0001 C CNN
F 1 "GND" H 2550 2850 50  0000 C CNN
F 2 "" H 2550 3000 50  0001 C CNN
F 3 "" H 2550 3000 50  0001 C CNN
	1    2550 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 2850 2550 3000
Text Label 1800 2650 0    60   ~ 0
VDD3P3
$Comp
L C_Small C?
U 1 1 62DF23AA
P 2350 2050
F 0 "C?" H 2360 2120 50  0000 L CNN
F 1 "100nf" H 2360 1970 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2350 2050 50  0001 C CNN
F 3 "" H 2350 2050 50  0001 C CNN
F 4 "710-885012105001" H 2350 2050 60  0001 C CNN "Mouser Part Number"
	1    2350 2050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23AB
P 2950 2050
F 0 "C?" H 2960 2120 50  0000 L CNN
F 1 "1uf" H 2960 1970 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2950 2050 50  0001 C CNN
F 3 "" H 2950 2050 50  0001 C CNN
F 4 "80-C0402C101K8RAUTO" H 2950 2050 60  0001 C CNN "Mouser Part Number"
	1    2950 2050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23AC
P 3150 2050
F 0 "C?" H 3160 2120 50  0000 L CNN
F 1 "100pf" H 3160 1970 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3150 2050 50  0001 C CNN
F 3 "" H 3150 2050 50  0001 C CNN
F 4 "80-C0402C101K3RAUTO" H 3150 2050 60  0001 C CNN "Mouser Part Number"
	1    3150 2050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23AD
P 3600 2050
F 0 "C?" H 3610 2120 50  0000 L CNN
F 1 "100nf" H 3610 1970 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3600 2050 50  0001 C CNN
F 3 "" H 3600 2050 50  0001 C CNN
F 4 "710-885012105001" H 3600 2050 60  0001 C CNN "Mouser Part Number"
	1    3600 2050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62DF23AE
P 3950 2050
F 0 "C?" H 3960 2120 50  0000 L CNN
F 1 "100nf" H 3960 1970 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3950 2050 50  0001 C CNN
F 3 "" H 3950 2050 50  0001 C CNN
F 4 "710-885012105001" H 3950 2050 60  0001 C CNN "Mouser Part Number"
	1    3950 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 1950 3950 1950
Connection ~ 3600 1950
Connection ~ 3150 1950
Connection ~ 2950 1950
Wire Wire Line
	2350 2150 3950 2150
Connection ~ 3600 2150
Connection ~ 3150 2150
Connection ~ 2950 2150
$Comp
L +3.3V #PWR?
U 1 1 62DF23AF
P 2350 1850
F 0 "#PWR?" H 2350 1700 50  0001 C CNN
F 1 "+3.3V" H 2350 1990 50  0000 C CNN
F 2 "" H 2350 1850 50  0001 C CNN
F 3 "" H 2350 1850 50  0001 C CNN
	1    2350 1850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 62DF23B0
P 2350 2250
F 0 "#PWR?" H 2350 2000 50  0001 C CNN
F 1 "GND" H 2350 2100 50  0000 C CNN
F 2 "" H 2350 2250 50  0001 C CNN
F 3 "" H 2350 2250 50  0001 C CNN
	1    2350 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 1850 2350 1950
Wire Wire Line
	2350 2250 2350 2150
Text Notes 1800 3000 0    60   ~ 0
Pins 3,4
Text Notes 2350 2250 0    60   ~ 0
Pin 1
Text Notes 2950 2250 0    60   ~ 0
Pins 43, 46
Text Notes 3600 2250 0    60   ~ 0
Pin 19
Text Notes 4000 2250 0    60   ~ 0
Pin 37
Text HLabel 6150 5400 3    60   Input ~ 0
CAN_RX
Text HLabel 6250 2500 1    60   Input ~ 0
SCL
Text HLabel 5950 2500 1    60   BiDi ~ 0
SDA
Wire Wire Line
	3650 4350 3150 4350
$Comp
L R R?
U 1 1 62DF23B1
P 5950 1900
F 0 "R?" V 6030 1900 50  0000 C CNN
F 1 "2.4K" V 5950 1900 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5880 1900 50  0001 C CNN
F 3 "" H 5950 1900 50  0001 C CNN
F 4 "71-CRCW06032K40JNEAC" V 5950 1900 60  0001 C CNN "Mouser Part Number"
	1    5950 1900
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 62DF23B2
P 6250 1900
F 0 "R?" V 6330 1900 50  0000 C CNN
F 1 "2.4K" V 6250 1900 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6180 1900 50  0001 C CNN
F 3 "" H 6250 1900 50  0001 C CNN
F 4 "71-CRCW06032K40JNEAC" V 6250 1900 60  0001 C CNN "Mouser Part Number"
	1    6250 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 2050 6250 2500
Wire Wire Line
	5950 2050 5950 2500
Wire Wire Line
	5950 1750 6250 1750
$Comp
L +3.3V #PWR?
U 1 1 62DF23B3
P 6250 1600
F 0 "#PWR?" H 6250 1450 50  0001 C CNN
F 1 "+3.3V" H 6250 1740 50  0000 C CNN
F 2 "" H 6250 1600 50  0001 C CNN
F 3 "" H 6250 1600 50  0001 C CNN
	1    6250 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 1750 6250 1600
Text Label 3850 3150 0    60   ~ 0
GPIO15(Act1)
Text Label 3450 3150 2    60   ~ 0
GPIO2(Act2)
$Comp
L LED D?
U 1 1 62DF23B4
P 3850 3000
F 0 "D?" H 3850 3100 50  0000 C CNN
F 1 "ACT1" H 3850 2900 50  0000 C CNN
F 2 "LEDs:LED_0402" H 3850 3000 50  0001 C CNN
F 3 "" H 3850 3000 50  0001 C CNN
F 4 "710-150040GS73220" H 3850 3000 60  0001 C CNN "Mouser Part Number"
	1    3850 3000
	0    -1   -1   0   
$EndComp
$Comp
L LED D?
U 1 1 62DF23B5
P 3450 3000
F 0 "D?" H 3450 3100 50  0000 C CNN
F 1 "ACT2" H 3450 2900 50  0000 C CNN
F 2 "LEDs:LED_0402" H 3450 3000 50  0001 C CNN
F 3 "" H 3450 3000 50  0001 C CNN
F 4 "710-150040SS73220" H 3450 3000 60  0001 C CNN "Mouser Part Number"
	1    3450 3000
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 62DF23B6
P 3850 2650
F 0 "R?" V 3930 2650 50  0000 C CNN
F 1 "270" V 3850 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3780 2650 50  0001 C CNN
F 3 "" H 3850 2650 50  0001 C CNN
F 4 "754-RR0510P-271D" V 3850 2650 60  0001 C CNN "Mouser Part Number"
	1    3850 2650
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 62DF23B7
P 3450 2650
F 0 "R?" V 3530 2650 50  0000 C CNN
F 1 "270" V 3450 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3380 2650 50  0001 C CNN
F 3 "" H 3450 2650 50  0001 C CNN
F 4 "754-RR0510P-271D" V 3450 2650 60  0001 C CNN "Mouser Part Number"
	1    3450 2650
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 62DF23B8
P 3650 2400
F 0 "#PWR?" H 3650 2250 50  0001 C CNN
F 1 "+3.3V" H 3650 2540 50  0000 C CNN
F 2 "" H 3650 2400 50  0001 C CNN
F 3 "" H 3650 2400 50  0001 C CNN
	1    3650 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 2500 3450 2500
Wire Wire Line
	3650 2400 3650 2500
Connection ~ 3650 2500
Wire Wire Line
	3850 2800 3850 2850
Wire Wire Line
	3450 2800 3450 2850
Text Label 5950 5400 3    60   ~ 0
GPIO2(Act2)
Text Label 5850 5400 3    60   ~ 0
GPIO15(Act1)
$Comp
L ESP32-D0WD-V3 U?
U 1 1 62DF2385
P 4850 3200
F 0 "U?" H 5600 2950 50  0000 L CNN
F 1 "ESP32-D0WD-V3" H 5400 3300 50  0000 L CNN
F 2 "ESP32-D0WD-V3:QFN35P500X500X90-49N-D" H 6500 3700 50  0001 L CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf" H 6500 3600 50  0001 L CNN
F 4 "WiFi Development Tools (802.11) SMD IC WiFi Dual Core BT Combo" H 6500 3500 50  0001 L CNN "Description"
F 5 "0.9" H 6500 3400 50  0001 L CNN "Height"
F 6 "Espressif Systems" H 6500 3100 50  0001 L CNN "Manufacturer_Name"
F 7 "ESP32-D0WD-V3" H 6500 3000 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "356-ESP32-D0WD-V3 " H 4850 3200 60  0001 C CNN "Mouser Part Number"
	1    4850 3200
	1    0    0    -1  
$EndComp
Text HLabel 6650 3600 2    60   Output ~ 0
CAN_TX
$Comp
L C_Small C?
U 1 1 62E012C8
P 4550 3700
F 0 "C?" H 4560 3770 50  0000 L CNN
F 1 "270pf" H 4560 3620 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4550 3700 50  0001 C CNN
F 3 "" H 4550 3700 50  0001 C CNN
	1    4550 3700
	0    1    1    0   
$EndComp
$Comp
L C_Small C?
U 1 1 62E0144E
P 4250 3800
F 0 "C?" H 4260 3870 50  0000 L CNN
F 1 "270pf" H 4260 3720 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4250 3800 50  0001 C CNN
F 3 "" H 4250 3800 50  0001 C CNN
	1    4250 3800
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 3700 4650 3700
Wire Wire Line
	4450 3700 4450 3600
Wire Wire Line
	4450 3600 4850 3600
Wire Wire Line
	4850 3800 4350 3800
Wire Wire Line
	4150 3800 4150 3900
Wire Wire Line
	4150 3900 4850 3900
Text HLabel 4450 3600 0    60   Input ~ 0
VP
Text HLabel 4150 3900 0    60   Input ~ 0
VN
Text HLabel 4850 4000 0    60   BiDi ~ 0
Reset
Text HLabel 4850 4300 0    60   Output ~ 0
32
Text HLabel 5550 5400 3    60   Output ~ 0
12
Text HLabel 4850 4400 0    60   Input ~ 0
33
Text HLabel 4850 4100 0    60   Input ~ 0
34
Text HLabel 4850 4200 0    60   Input ~ 0
35
Text HLabel 4850 4500 0    60   Input ~ 0
25
Text HLabel 5250 5400 3    60   Input ~ 0
26
Text HLabel 5350 5400 3    60   Input ~ 0
27
Text HLabel 6650 3400 2    60   Input ~ 0
23
Text HLabel 6650 3200 2    60   Input ~ 0
19
Text HLabel 6650 3500 2    60   Input ~ 0
18
Text HLabel 6650 4300 2    60   Input ~ 0
17
Text HLabel 6650 4500 2    60   Input ~ 0
16
Text HLabel 6050 5400 3    60   Input ~ 0
0
$Comp
L USB_OTG J?
U 1 1 62E118F7
P 1050 6000
F 0 "J?" H 850 6450 50  0000 L CNN
F 1 "USB_OTG" H 850 6350 50  0000 L CNN
F 2 "Connectors_USB:USB_Micro-B_Molex_47346-0001" H 1200 5950 50  0001 C CNN
F 3 "" H 1200 5950 50  0001 C CNN
F 4 "538-47346-0001" H 1050 6000 60  0001 C CNN "Mouser Part Number"
	1    1050 6000
	1    0    0    -1  
$EndComp
$Comp
L FT231XS-R U?
U 1 1 62E118F8
P 3850 5200
F 0 "U?" H 5000 5500 50  0000 L CNN
F 1 "FT231XS-R" H 5000 5400 50  0000 L CNN
F 2 "Housings_SSOP:SSOP-20_5.3x7.2mm_Pitch0.65mm" H 5000 5300 50  0001 L CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Future-Designs-FT231XS-R_C132160.pdf" H 5000 5200 50  0001 L CNN
F 4 "USB SSOP-20 RoHS" H 5000 5100 50  0001 L CNN "Description"
F 5 "1.753" H 5000 5000 50  0001 L CNN "Height"
F 6 "Future Designs" H 5000 4700 50  0001 L CNN "Manufacturer_Name"
F 7 "FT231XS-R" H 5000 4600 50  0001 L CNN "Manufacturer_Part_Number"
	1    3850 5200
	-1   0    0    -1  
$EndComp
$Comp
L Ferrite_Bead_Small L?
U 1 1 62E118FA
P 2450 1850
F 0 "L?" H 2525 1900 50  0000 L CNN
F 1 "Ferrite Bead" H 2525 1800 50  0000 L CNN
F 2 "Inductors_SMD:L_0402" V 2380 1850 50  0001 C CNN
F 3 "" H 2450 1850 50  0001 C CNN
F 4 "810-MMZ1005S800CTD25" H 2450 1850 60  0001 C CNN "Mouser Part Number"
	1    2450 1850
	0    1    1    0   
$EndComp
$Comp
L UMH3N Q?
U 1 1 62E11915
P 8250 1750
F 0 "Q?" H 8450 1800 50  0000 L CNN
F 1 "UMH3N" H 8450 1700 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6" H 8450 1850 50  0001 C CNN
F 3 "" H 8250 1750 50  0001 C CNN
F 4 "755-UMH3NFHATN " H 8250 1750 60  0001 C CNN "Mouser Part Number"
	1    8250 1750
	1    0    0    -1  
$EndComp
$Comp
L UMH3N Q?
U 2 1 62E14AAD
P 8050 2150
F 0 "Q?" H 8250 2200 50  0000 L CNN
F 1 "UMH3N" H 8250 2100 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6" H 8250 2250 50  0001 C CNN
F 3 "" H 8050 2150 50  0001 C CNN
F 4 "755-UMH3NFHATN " H 8050 2150 60  0001 C CNN "Mouser Part Number"
	2    8050 2150
	-1   0    0    1   
$EndComp
Wire Wire Line
	8350 1950 8350 2150
Wire Wire Line
	8350 2150 8250 2150
Wire Wire Line
	8050 1750 7950 1750
Wire Wire Line
	7950 1750 7950 1950
Text Label 8350 1550 0    60   ~ 0
RESET
Text Label 7950 1750 2    60   ~ 0
DTR
Text Label 8350 2150 0    60   ~ 0
RTS
Text Label 3850 5200 0    60   ~ 0
DTR
Text Label 3850 5300 0    60   ~ 0
RTS
Text Label 3850 5500 0    60   ~ 0
RX
NoConn ~ 3850 5600
NoConn ~ 3850 5800
NoConn ~ 3850 5900
NoConn ~ 3850 6000
$Comp
L GND #PWR?
U 1 1 62E17368
P 3950 5700
F 0 "#PWR?" H 3950 5450 50  0001 C CNN
F 1 "GND" H 3950 5550 50  0000 C CNN
F 2 "" H 3950 5700 50  0001 C CNN
F 3 "" H 3950 5700 50  0001 C CNN
	1    3950 5700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3950 5700 3850 5700
Text Label 2550 5200 2    60   ~ 0
TX
NoConn ~ 2550 5400
NoConn ~ 2550 5300
$Comp
L GND #PWR?
U 1 1 62E179B5
P 2450 5600
F 0 "#PWR?" H 2450 5350 50  0001 C CNN
F 1 "GND" H 2450 5450 50  0000 C CNN
F 2 "" H 2450 5600 50  0001 C CNN
F 3 "" H 2450 5600 50  0001 C CNN
	1    2450 5600
	0    1    1    0   
$EndComp
Wire Wire Line
	2550 5600 2450 5600
$Comp
L R R?
U 1 1 62E181DA
P 2150 6000
F 0 "R?" V 2230 6000 50  0000 C CNN
F 1 "27" V 2150 6000 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 2080 6000 50  0001 C CNN
F 3 "" H 2150 6000 50  0001 C CNN
F 4 "603-RT0402FRE0727RL" V 2150 6000 60  0001 C CNN "Mouser Part Number"
	1    2150 6000
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 62E18314
P 2150 6100
F 0 "R?" V 2230 6100 50  0000 C CNN
F 1 "27" V 2150 6100 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 2080 6100 50  0001 C CNN
F 3 "" H 2150 6100 50  0001 C CNN
F 4 "603-RT0402FRE0727RL" V 2150 6100 60  0001 C CNN "Mouser Part Number"
	1    2150 6100
	0    1    1    0   
$EndComp
Wire Wire Line
	1350 6000 1750 6000
Wire Wire Line
	1750 6000 1750 6100
Wire Wire Line
	1750 6100 2000 6100
Wire Wire Line
	2300 6100 2550 6100
Wire Wire Line
	2300 6000 2550 6000
Wire Wire Line
	1350 6100 1600 6100
Wire Wire Line
	1600 6100 1600 6050
Wire Wire Line
	1600 6050 1850 6050
Wire Wire Line
	1850 6050 1850 6000
Wire Wire Line
	1850 6000 2000 6000
Wire Wire Line
	950  6400 1050 6400
$Comp
L GND #PWR?
U 1 1 62E187A2
P 1050 6550
F 0 "#PWR?" H 1050 6300 50  0001 C CNN
F 1 "GND" H 1050 6400 50  0000 C CNN
F 2 "" H 1050 6550 50  0001 C CNN
F 3 "" H 1050 6550 50  0001 C CNN
	1    1050 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1050 6400 1050 6550
$Comp
L C_Small C?
U 1 1 62E188D8
P 1900 6300
F 0 "C?" H 1910 6370 50  0000 L CNN
F 1 "47pf" H 1910 6220 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1900 6300 50  0001 C CNN
F 3 "" H 1900 6300 50  0001 C CNN
F 4 "80-C0402C470K5RAUTO" H 1900 6300 60  0001 C CNN "Mouser Part Number"
	1    1900 6300
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62E18B78
P 1500 6300
F 0 "C?" H 1510 6370 50  0000 L CNN
F 1 "47pf" H 1510 6220 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1500 6300 50  0001 C CNN
F 3 "" H 1500 6300 50  0001 C CNN
F 4 "80-C0402C470K5RAUTO" H 1500 6300 60  0001 C CNN "Mouser Part Number"
	1    1500 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 6200 1900 6100
Connection ~ 1900 6100
Wire Wire Line
	1500 6200 1500 6100
Connection ~ 1500 6100
Wire Wire Line
	1900 6400 1500 6400
Wire Wire Line
	1050 6550 1500 6550
Wire Wire Line
	1500 6550 1500 6400
$Comp
L Ferrite_Bead_Small L?
U 1 1 62E18F10
P 1600 5800
F 0 "L?" V 1675 5850 50  0000 L CNN
F 1 "Ferrite Bead" V 1750 5700 50  0000 L CNN
F 2 "Inductors_SMD:L_0402" V 1530 5800 50  0001 C CNN
F 3 "" H 1600 5800 50  0001 C CNN
F 4 "810-MMZ1005S800CTD25" H 1600 5800 60  0001 C CNN "Mouser Part Number"
	1    1600 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	1350 5800 1500 5800
Wire Wire Line
	2550 5700 1950 5700
Wire Wire Line
	1950 5700 1950 5800
Wire Wire Line
	1950 5800 1700 5800
Wire Wire Line
	2550 5800 2550 5900
Wire Wire Line
	2550 5900 2400 5900
Wire Wire Line
	2400 5900 2400 6500
Wire Wire Line
	2400 6500 4100 6500
Wire Wire Line
	4100 6500 4100 5400
Wire Wire Line
	4100 5400 3850 5400
$Comp
L C_Small C?
U 1 1 62E19681
P 1400 5600
F 0 "C?" H 1410 5670 50  0000 L CNN
F 1 "10pf" H 1410 5520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1400 5600 50  0001 C CNN
F 3 "" H 1400 5600 50  0001 C CNN
F 4 "80-C0402C100K5RAUTO" H 1400 5600 60  0001 C CNN "Mouser Part Number"
	1    1400 5600
	1    0    0    -1  
$EndComp
$Comp
L C_Small C?
U 1 1 62E196EC
P 1750 5600
F 0 "C?" H 1760 5670 50  0000 L CNN
F 1 "100nf" H 1760 5520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1750 5600 50  0001 C CNN
F 3 "" H 1750 5600 50  0001 C CNN
F 4 "80-C0402C104K8R" H 1750 5600 60  0001 C CNN "Mouser Part Number"
	1    1750 5600
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small C?
U 1 1 62E1975B
P 2000 5500
F 0 "C?" H 2010 5570 50  0000 L CNN
F 1 "4.7uf" H 2010 5420 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_4x5.7" H 2000 5500 50  0001 C CNN
F 3 "" H 2000 5500 50  0001 C CNN
F 4 "710-865080540002" H 2000 5500 60  0001 C CNN "Mouser Part Number"
	1    2000 5500
	-1   0    0    1   
$EndComp
$Comp
L C_Small C?
U 1 1 62E19965
P 3100 6750
F 0 "C?" H 3110 6820 50  0000 L CNN
F 1 "100nf" H 3110 6670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3100 6750 50  0001 C CNN
F 3 "" H 3100 6750 50  0001 C CNN
F 4 "80-C0402C104K8R" H 3100 6750 60  0001 C CNN "Mouser Part Number"
	1    3100 6750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 5700 1400 5800
Connection ~ 1400 5800
Wire Wire Line
	1750 5700 1750 5800
Connection ~ 1750 5800
Wire Wire Line
	2000 5600 2000 5700
Connection ~ 2000 5700
Wire Wire Line
	1400 5500 1750 5500
Wire Wire Line
	1750 5500 1750 5400
Wire Wire Line
	1750 5400 2000 5400
$Comp
L GND #PWR?
U 1 1 62E1A0F6
P 2000 5300
F 0 "#PWR?" H 2000 5050 50  0001 C CNN
F 1 "GND" H 2000 5150 50  0000 C CNN
F 2 "" H 2000 5300 50  0001 C CNN
F 3 "" H 2000 5300 50  0001 C CNN
	1    2000 5300
	-1   0    0    1   
$EndComp
Wire Wire Line
	2000 5400 2000 5300
Wire Wire Line
	3100 6500 3100 6650
Connection ~ 3100 6500
$Comp
L GND #PWR?
U 1 1 62E1A448
P 3100 7000
F 0 "#PWR?" H 3100 6750 50  0001 C CNN
F 1 "GND" H 3100 6850 50  0000 C CNN
F 2 "" H 3100 7000 50  0001 C CNN
F 3 "" H 3100 7000 50  0001 C CNN
	1    3100 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 6850 3100 7000
Wire Wire Line
	2250 5300 2250 5700
Connection ~ 2250 5700
NoConn ~ 3850 6100
NoConn ~ 2550 5500
Text Label 4850 3300 2    60   ~ 0
Antenna
$Comp
L C_Small C?
U 1 1 62E1E615
P 2800 3450
F 0 "C?" H 2810 3520 50  0000 L CNN
F 1 "5.8pf" H 2810 3370 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2800 3450 50  0001 C CNN
F 3 "" H 2800 3450 50  0001 C CNN
	1    2800 3450
	0    1    1    0   
$EndComp
Text Label 2900 3450 0    60   ~ 0
Antenna
$Comp
L Antenna_Shield AE?
U 1 1 62E1E999
P 2450 3450
F 0 "AE?" H 2375 3625 50  0000 R CNN
F 1 "Antenna_Shield" H 2375 3550 50  0000 R CNN
F 2 "Antenna:Antenna" H 2450 3550 50  0001 C CNN
F 3 "" H 2450 3550 50  0001 C CNN
	1    2450 3450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2700 3450 2650 3450
$Comp
L GND #PWR?
U 1 1 62E1EC1A
P 2650 3300
F 0 "#PWR?" H 2650 3050 50  0001 C CNN
F 1 "GND" H 2650 3150 50  0000 C CNN
F 2 "" H 2650 3300 50  0001 C CNN
F 3 "" H 2650 3300 50  0001 C CNN
	1    2650 3300
	-1   0    0    1   
$EndComp
Wire Wire Line
	2650 3300 2650 3350
$Comp
L VBUS #PWR?
U 1 1 62E2A6A1
P 2250 5300
F 0 "#PWR?" H 2250 5150 50  0001 C CNN
F 1 "VBUS" H 2250 5450 50  0000 C CNN
F 2 "" H 2250 5300 50  0001 C CNN
F 3 "" H 2250 5300 50  0001 C CNN
	1    2250 5300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
