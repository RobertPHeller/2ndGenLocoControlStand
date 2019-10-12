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
Sheet 1 5
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
L CONN_3 J108
U 1 1 5D93DFEE
P 8450 3950
F 0 "J108" V 8400 3950 50  0000 C CNN
F 1 "Throttle" V 8500 3950 40  0000 C CNN
F 2 "~" H 8450 3950 60  0000 C CNN
F 3 "~" H 8450 3950 60  0000 C CNN
	1    8450 3950
	1    0    0    -1  
$EndComp
$Comp
L ENCODER EN102
U 1 1 5D93BEC4
P 9900 4750
F 0 "EN102" H 9950 4950 60  0000 C CNN
F 1 "Reverser" H 9900 4650 60  0000 C CNN
F 2 "~" H 9900 4750 60  0000 C CNN
F 3 "~" H 9900 4750 60  0000 C CNN
F 4 "652-PEC11R4325FN0012" H 9900 4750 60  0001 C CNN "Mouser Part Number"
	1    9900 4750
	1    0    0    -1  
$EndComp
$Comp
L POT RV101
U 1 1 5D93DC64
P 10000 3000
F 0 "RV101" H 10000 2900 50  0000 C CNN
F 1 "100K Ohms" H 10000 3000 50  0000 C CNN
F 2 "~" H 10000 3000 60  0000 C CNN
F 3 "~" H 10000 3000 60  0000 C CNN
F 4 "774-450T328F104A1A1" H 10000 3000 60  0001 C CNN "Mouser Part Number"
	1    10000 3000
	0    -1   -1   0   
$EndComp
$Comp
L POT RV102
U 1 1 5D93DC73
P 10050 2300
F 0 "RV102" H 10050 2200 50  0000 C CNN
F 1 "100K Ohms" H 10050 2300 50  0000 C CNN
F 2 "~" H 10050 2300 60  0000 C CNN
F 3 "~" H 10050 2300 60  0000 C CNN
F 4 "774-450T328F104A1A1" H 10050 2300 60  0001 C CNN "Mouser Part Number"
	1    10050 2300
	0    -1   -1   0   
$EndComp
$Comp
L ENCODER EN101
U 1 1 5D93BC04
P 9900 3900
F 0 "EN101" H 9950 4100 60  0000 C CNN
F 1 "Throttle" H 9900 3800 60  0000 C CNN
F 2 "~" H 9900 3900 60  0000 C CNN
F 3 "~" H 9900 3900 60  0000 C CNN
F 4 "706-25LB10-Q" H 9900 3900 60  0001 C CNN "Mouser Part Number"
	1    9900 3900
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P106
U 1 1 5D93BC13
P 8850 3950
F 0 "P106" V 8800 3950 50  0000 C CNN
F 1 "CONN_3" V 8900 3950 40  0000 C CNN
F 2 "~" H 8850 3950 60  0000 C CNN
F 3 "~" H 8850 3950 60  0000 C CNN
	1    8850 3950
	-1   0    0    -1  
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
$Comp
L CONN_3 J102
U 1 1 5D93E112
P 8350 2250
F 0 "J102" V 8300 2250 50  0000 C CNN
F 1 "Horn" V 8400 2250 40  0000 C CNN
F 2 "~" H 8350 2250 60  0000 C CNN
F 3 "~" H 8350 2250 60  0000 C CNN
	1    8350 2250
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P103
U 1 1 5D93E12B
P 8750 2250
F 0 "P103" V 8700 2250 50  0000 C CNN
F 1 "CONN_3" V 8800 2250 40  0000 C CNN
F 2 "~" H 8750 2250 60  0000 C CNN
F 3 "~" H 8750 2250 60  0000 C CNN
	1    8750 2250
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 P104
U 1 1 5D93E13A
P 8800 3000
F 0 "P104" V 8750 3000 50  0000 C CNN
F 1 "CONN_3" V 8850 3000 40  0000 C CNN
F 2 "~" H 8800 3000 60  0000 C CNN
F 3 "~" H 8800 3000 60  0000 C CNN
	1    8800 3000
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 J103
U 1 1 5D93E149
P 8350 3050
F 0 "J103" V 8300 3050 50  0000 C CNN
F 1 "Brake" V 8400 3050 40  0000 C CNN
F 2 "~" H 8350 3050 60  0000 C CNN
F 3 "~" H 8350 3050 60  0000 C CNN
	1    8350 3050
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P107
U 1 1 5D93E158
P 8900 4700
F 0 "P107" V 8850 4700 50  0000 C CNN
F 1 "CONN_3" V 8950 4700 40  0000 C CNN
F 2 "~" H 8900 4700 60  0000 C CNN
F 3 "~" H 8900 4700 60  0000 C CNN
	1    8900 4700
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 J107
U 1 1 5D93E167
P 8400 4700
F 0 "J107" V 8350 4700 50  0000 C CNN
F 1 "Reverser" V 8450 4700 40  0000 C CNN
F 2 "~" H 8400 4700 60  0000 C CNN
F 3 "~" H 8400 4700 60  0000 C CNN
	1    8400 4700
	1    0    0    -1  
$EndComp
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
	9250 4700 9450 4700
Wire Wire Line
	9450 4700 9450 4750
Wire Wire Line
	9450 4750 9550 4750
Wire Wire Line
	9250 4550 9550 4550
Wire Wire Line
	9250 4550 9250 4600
Wire Wire Line
	9550 4950 9350 4950
Wire Wire Line
	9350 4950 9350 4800
Wire Wire Line
	9350 4800 9250 4800
$Comp
L LIGHT_SWITCH SW106
U 1 1 5D93E92F
P 9900 1300
F 0 "SW106" H 10250 950 60  0000 C CNN
F 1 "LIGHT_SWITCH" H 10450 1800 60  0000 C CNN
F 2 "~" H 9900 1300 60  0000 C CNN
F 3 "~" H 9900 1300 60  0000 C CNN
	1    9900 1300
	-1   0    0    -1  
$EndComp
$Comp
L CONN_6 J104
U 1 1 5D93E969
P 8350 5450
F 0 "J104" V 8300 5450 50  0000 C CNN
F 1 "I2C Display" V 8400 5450 50  0000 C CNN
F 2 "~" H 8350 5450 60  0000 C CNN
F 3 "~" H 8350 5450 60  0000 C CNN
	1    8350 5450
	1    0    0    -1  
$EndComp
$Comp
L CONN_5 J105
U 1 1 5D93E993
P 8350 6450
F 0 "J105" V 8300 6450 50  0000 C CNN
F 1 "Button & LED Panel" V 8400 6450 50  0000 C CNN
F 2 "~" H 8350 6450 60  0000 C CNN
F 3 "~" H 8350 6450 60  0000 C CNN
	1    8350 6450
	1    0    0    -1  
$EndComp
$Comp
L CONN_5 J106
U 1 1 5D93E9D1
P 8400 1300
F 0 "J106" V 8350 1300 50  0000 C CNN
F 1 "Light Switch" V 8450 1300 50  0000 C CNN
F 2 "~" H 8400 1300 60  0000 C CNN
F 3 "~" H 8400 1300 60  0000 C CNN
	1    8400 1300
	1    0    0    -1  
$EndComp
$Comp
L CONN_5 P105
U 1 1 5D93E9E0
P 8850 1300
F 0 "P105" V 8800 1300 50  0000 C CNN
F 1 "CONN_5" V 8900 1300 50  0000 C CNN
F 2 "~" H 8850 1300 60  0000 C CNN
F 3 "~" H 8850 1300 60  0000 C CNN
	1    8850 1300
	-1   0    0    -1  
$EndComp
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
$Sheet
S 9150 6150 1250 650 
U 5D93EAD3
F0 " Button and LED Panel" 50
F1 "ButtonLEDPanel.sch" 50
$EndSheet
$Comp
L CONN_6 P108
U 1 1 5D93EADD
P 8950 5450
F 0 "P108" V 8900 5450 50  0000 C CNN
F 1 "CONN_6" V 9000 5450 50  0000 C CNN
F 2 "~" H 8950 5450 60  0000 C CNN
F 3 "~" H 8950 5450 60  0000 C CNN
	1    8950 5450
	-1   0    0    -1  
$EndComp
$Comp
L I2C_DISPLAY MOD101
U 1 1 5D93ED79
P 9900 5450
F 0 "MOD101" H 10050 5650 60  0000 C CNN
F 1 "I2C_DISPLAY" H 10000 5350 60  0000 C CNN
F 2 "~" H 9900 5450 60  0000 C CNN
F 3 "~" H 9900 5450 60  0000 C CNN
	1    9900 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 5200 9300 5200
Wire Wire Line
	9550 5300 9300 5300
Wire Wire Line
	9550 5400 9300 5400
Wire Wire Line
	9550 5500 9300 5500
Wire Wire Line
	9550 5600 9300 5600
Wire Wire Line
	9550 5700 9300 5700
Text Label 7950 6550 2    60   ~ 0
SCL
Text Label 7950 6650 2    60   ~ 0
SDA
Text Label 8000 5400 2    60   ~ 0
GND
Text Label 8000 5500 2    60   ~ 0
RST
Text Label 8000 5600 2    60   ~ 0
SCL
Text Label 8000 5700 2    60   ~ 0
SDA
NoConn ~ 8000 5300
$Comp
L GND #PWR01
U 1 1 5D94082C
P 7850 1300
F 0 "#PWR01" H 7850 1300 30  0001 C CNN
F 1 "GND" H 7850 1230 30  0001 C CNN
F 2 "" H 7850 1300 60  0000 C CNN
F 3 "" H 7850 1300 60  0000 C CNN
	1    7850 1300
	0    1    1    0   
$EndComp
Wire Wire Line
	8000 1300 7850 1300
$Comp
L +3.3V #PWR02
U 1 1 5D9408A0
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
U 1 1 5D9408AF
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
U 1 1 5D9408BE
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
U 1 1 5D9408CD
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
U 1 1 5D9408DC
P 7950 3950
F 0 "#PWR06" H 7950 3950 30  0001 C CNN
F 1 "GND" H 7950 3880 30  0001 C CNN
F 2 "" H 7950 3950 60  0000 C CNN
F 3 "" H 7950 3950 60  0000 C CNN
	1    7950 3950
	0    1    1    0   
$EndComp
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
$Comp
L SW_PUSH_SMALL SW101
U 1 1 5D94AF8E
P 1150 1300
F 0 "SW101" H 1300 1410 30  0000 C CNN
F 1 "A" H 1150 1221 30  0000 C CNN
F 2 "~" H 1150 1300 60  0000 C CNN
F 3 "~" H 1150 1300 60  0000 C CNN
	1    1150 1300
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW102
U 1 1 5D94AF9D
P 1150 1600
F 0 "SW102" H 1300 1710 30  0000 C CNN
F 1 "B" H 1150 1521 30  0000 C CNN
F 2 "~" H 1150 1600 60  0000 C CNN
F 3 "~" H 1150 1600 60  0000 C CNN
	1    1150 1600
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW103
U 1 1 5D94AFAC
P 1150 1850
F 0 "SW103" H 1300 1960 30  0000 C CNN
F 1 "C" H 1150 1771 30  0000 C CNN
F 2 "~" H 1150 1850 60  0000 C CNN
F 3 "~" H 1150 1850 60  0000 C CNN
	1    1150 1850
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW104
U 1 1 5D94AFBB
P 1150 2100
F 0 "SW104" H 1300 2210 30  0000 C CNN
F 1 "D" H 1150 2021 30  0000 C CNN
F 2 "~" H 1150 2100 60  0000 C CNN
F 3 "~" H 1150 2100 60  0000 C CNN
	1    1150 2100
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW105
U 1 1 5D94AFCA
P 1150 2400
F 0 "SW105" H 1300 2510 30  0000 C CNN
F 1 "Bell" H 1150 2321 30  0000 C CNN
F 2 "~" H 1150 2400 60  0000 C CNN
F 3 "~" H 1150 2400 60  0000 C CNN
	1    1150 2400
	1    0    0    -1  
$EndComp
$Comp
L BI_LED D101
U 1 1 5D94AFD9
P 1200 2900
F 0 "D101" H 1500 3000 50  0000 C CNN
F 1 "Status" H 1550 2800 50  0000 C CNN
F 2 "~" H 1200 2900 60  0000 C CNN
F 3 "~" H 1200 2900 60  0000 C CNN
	1    1200 2900
	-1   0    0    1   
$EndComp
Wire Wire Line
	1050 900  1050 2450
Connection ~ 1050 1500
Connection ~ 1050 1750
Connection ~ 1050 2000
Wire Wire Line
	1050 2450 850  2450
Wire Wire Line
	850  2450 850  2900
Connection ~ 1050 2300
$Comp
L CONN_8 P101
U 1 1 5D94B10B
P 2050 1600
F 0 "P101" V 2000 1600 60  0000 C CNN
F 1 "CONN_8" V 2100 1600 60  0000 C CNN
F 2 "~" H 2050 1600 60  0000 C CNN
F 3 "~" H 2050 1600 60  0000 C CNN
	1    2050 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 1250 1700 900 
Wire Wire Line
	1700 900  1050 900 
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
$Comp
L CONN_8 P102
U 1 1 5D94B3BB
P 2450 1600
F 0 "P102" V 2400 1600 60  0000 C CNN
F 1 "Misc buttons, bell, status LED" V 2500 1600 60  0000 C CNN
F 2 "~" H 2450 1600 60  0000 C CNN
F 3 "~" H 2450 1600 60  0000 C CNN
	1    2450 1600
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5D94B400
P 3000 1250
F 0 "#PWR07" H 3000 1250 30  0001 C CNN
F 1 "GND" H 3000 1180 30  0001 C CNN
F 2 "" H 3000 1250 60  0000 C CNN
F 3 "" H 3000 1250 60  0000 C CNN
	1    3000 1250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3000 1250 2800 1250
$Comp
L R R101
U 1 1 5D94B46B
P 3200 1850
F 0 "R101" V 3280 1850 40  0000 C CNN
F 1 "220 Ohms" V 3207 1851 40  0000 C CNN
F 2 "~" V 3130 1850 30  0000 C CNN
F 3 "~" H 3200 1850 30  0000 C CNN
	1    3200 1850
	0    -1   -1   0   
$EndComp
$Comp
L R R102
U 1 1 5D94B47A
P 3200 1950
F 0 "R102" V 3280 1950 40  0000 C CNN
F 1 "220 Ohms" V 3207 1951 40  0000 C CNN
F 2 "~" V 3130 1950 30  0000 C CNN
F 3 "~" H 3200 1950 30  0000 C CNN
	1    3200 1950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2950 1850 2800 1850
Wire Wire Line
	2950 1950 2800 1950
$Sheet
S 900  6450 1800 900 
U 5D949DC7
F0 "Button Led Panel (2)" 50
F1 "ButtonLedPanel2.sch" 50
$EndSheet
$Sheet
S 700  3600 1900 800 
U 5D94A1D7
F0 "CAN Transceiver" 50
F1 "CAN_Transceiver.sch" 50
F2 "CAN_TX" I R 2600 3700 60 
F3 "CAN_RX" I R 2600 4000 60 
$EndSheet
$Sheet
S 900  4800 1950 950 
U 5D94A1D9
F0 "Power Supply" 50
F1 "PowerSupply.sch" 50
$EndSheet
$Comp
L +5V #PWR08
U 1 1 5D94B059
P 8000 5100
F 0 "#PWR08" H 8000 5190 20  0001 C CNN
F 1 "+5V" H 8000 5190 30  0000 C CNN
F 2 "" H 8000 5100 60  0000 C CNN
F 3 "" H 8000 5100 60  0000 C CNN
	1    8000 5100
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR09
U 1 1 5D94B06E
P 7950 6150
F 0 "#PWR09" H 7950 6240 20  0001 C CNN
F 1 "+5V" H 7950 6240 30  0000 C CNN
F 2 "" H 7950 6150 60  0000 C CNN
F 3 "" H 7950 6150 60  0000 C CNN
	1    7950 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 5100 8000 5200
Wire Wire Line
	7950 6150 7950 6250
$Comp
L CONN_5 J101
U 1 1 5D94B270
P 3300 6750
F 0 "J101" V 3250 6750 50  0000 C CNN
F 1 "Button & LED Panel" V 3350 6750 50  0000 C CNN
F 2 "~" H 3300 6750 60  0000 C CNN
F 3 "~" H 3300 6750 60  0000 C CNN
	1    3300 6750
	-1   0    0    -1  
$EndComp
Text Label 3700 6850 0    60   ~ 0
SCL
Text Label 3700 6950 0    60   ~ 0
SDA
$Comp
L +5V #PWR010
U 1 1 5D94B27A
P 3700 6450
F 0 "#PWR010" H 3700 6540 20  0001 C CNN
F 1 "+5V" H 3700 6540 30  0000 C CNN
F 2 "" H 3700 6450 60  0000 C CNN
F 3 "" H 3700 6450 60  0000 C CNN
	1    3700 6450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3700 6450 3700 6550
$Comp
L +3.3V #PWR011
U 1 1 5D94B319
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
U 1 1 5D94B32E
P 3950 6750
F 0 "#PWR012" H 3950 6750 30  0001 C CNN
F 1 "GND" H 3950 6680 30  0001 C CNN
F 2 "" H 3950 6750 60  0000 C CNN
F 3 "" H 3950 6750 60  0000 C CNN
	1    3950 6750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3700 6650 3900 6650
Wire Wire Line
	3700 6750 3950 6750
$Comp
L GND #PWR013
U 1 1 5D94B6E3
P 7750 6450
F 0 "#PWR013" H 7750 6450 30  0001 C CNN
F 1 "GND" H 7750 6380 30  0001 C CNN
F 2 "" H 7750 6450 60  0000 C CNN
F 3 "" H 7750 6450 60  0000 C CNN
	1    7750 6450
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR014
U 1 1 5D94B6F8
P 7800 6300
F 0 "#PWR014" H 7800 6260 30  0001 C CNN
F 1 "+3.3V" H 7800 6410 30  0000 C CNN
F 2 "" H 7800 6300 60  0000 C CNN
F 3 "" H 7800 6300 60  0000 C CNN
	1    7800 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7950 6350 7800 6350
Wire Wire Line
	7800 6350 7800 6300
Wire Wire Line
	7950 6450 7750 6450
$Comp
L ADAFRUIT_POWERBOOST_500 U101
U 1 1 5D94CAB9
P 4950 1000
F 0 "U101" H 4950 850 60  0000 C CNN
F 1 "ADAFRUIT_POWERBOOST_500" H 5000 1150 60  0000 C CNN
F 2 "~" H 4950 1000 60  0000 C CNN
F 3 "~" H 4950 1000 60  0000 C CNN
	1    4950 1000
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR015
U 1 1 5D94CAEC
P 4700 1750
F 0 "#PWR015" H 4700 1840 20  0001 C CNN
F 1 "+5V" H 4700 1840 30  0000 C CNN
F 2 "" H 4700 1750 60  0000 C CNN
F 3 "" H 4700 1750 60  0000 C CNN
	1    4700 1750
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR016
U 1 1 5D94CB12
P 5050 1850
F 0 "#PWR016" H 5050 1850 30  0001 C CNN
F 1 "GND" H 5050 1780 30  0001 C CNN
F 2 "" H 5050 1850 60  0000 C CNN
F 3 "" H 5050 1850 60  0000 C CNN
	1    5050 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 1750 4950 1750
Wire Wire Line
	5050 1750 5050 1850
Wire Wire Line
	5250 1750 5250 1800
Wire Wire Line
	5050 1800 5550 1800
Connection ~ 5050 1800
Wire Wire Line
	5550 1800 5550 1750
Connection ~ 5250 1800
$Comp
L TTGO-T1 U102
U 1 1 5D94CF36
P 5350 3950
F 0 "U102" H 5350 3950 60  0000 C CNN
F 1 "TTGO-T1" H 5350 4500 60  0000 C CNN
F 2 "~" H 5350 3950 60  0000 C CNN
F 3 "~" H 5350 3950 60  0000 C CNN
	1    5350 3950
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR017
U 1 1 5D94E361
P 4900 3400
F 0 "#PWR017" H 4900 3360 30  0001 C CNN
F 1 "+3.3V" H 4900 3510 30  0000 C CNN
F 2 "" H 4900 3400 60  0000 C CNN
F 3 "" H 4900 3400 60  0000 C CNN
	1    4900 3400
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR018
U 1 1 5D94E376
P 5900 3800
F 0 "#PWR018" H 5900 3890 20  0001 C CNN
F 1 "+5V" H 5900 3890 30  0000 C CNN
F 2 "" H 5900 3800 60  0000 C CNN
F 3 "" H 5900 3800 60  0000 C CNN
	1    5900 3800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR019
U 1 1 5D94E3AC
P 5900 3500
F 0 "#PWR019" H 5900 3500 30  0001 C CNN
F 1 "GND" H 5900 3430 30  0001 C CNN
F 2 "" H 5900 3500 60  0000 C CNN
F 3 "" H 5900 3500 60  0000 C CNN
	1    5900 3500
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR020
U 1 1 5D94E3CC
P 4750 4150
F 0 "#PWR020" H 4750 4150 30  0001 C CNN
F 1 "GND" H 4750 4080 30  0001 C CNN
F 2 "" H 4750 4150 60  0000 C CNN
F 3 "" H 4750 4150 60  0000 C CNN
	1    4750 4150
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 3500 4900 3400
Wire Wire Line
	5900 3500 5800 3500
Wire Wire Line
	5900 3800 5800 3800
Wire Wire Line
	4750 4150 4900 4150
Text Label 5800 3950 0    25   ~ 0
CAN_TX
Text Label 5800 4100 0    25   ~ 0
CAN_RX
Text Label 5800 3750 0    25   ~ 0
SDA
Text Label 5800 3600 0    25   ~ 0
SCL
Text Label 5800 4200 0    25   ~ 0
MISO
Text Label 5800 4250 0    25   ~ 0
MOSI
Text Label 4900 4050 2    25   ~ 0
SCLK
Text Label 2600 3700 0    60   ~ 0
CAN_TX
Text Label 2600 4000 0    60   ~ 0
CAN_RX
Text Label 4900 3550 2    25   ~ 0
RST
Text Label 8000 2250 2    60   ~ 0
Horn
Text Label 8000 3050 2    60   ~ 0
Brake
Text Label 4900 3600 2    25   ~ 0
Horn
Text Label 4900 3650 2    25   ~ 0
Brake
Text Label 8100 3850 2    60   ~ 0
ThrottleA
Text Label 8100 4050 2    60   ~ 0
ThrottleB
Text Label 5800 3550 0    25   ~ 0
ThrottleA
Text Label 5800 3850 0    25   ~ 0
ThrottleB
$Comp
L R R105
U 1 1 5D951E1C
P 7800 4500
F 0 "R105" V 7880 4500 40  0000 C CNN
F 1 "100K Ohms" V 7807 4501 40  0000 C CNN
F 2 "~" V 7730 4500 30  0000 C CNN
F 3 "~" H 7800 4500 30  0000 C CNN
	1    7800 4500
	0    -1   -1   0   
$EndComp
$Comp
L R R106
U 1 1 5D951ED9
P 7800 4900
F 0 "R106" V 7880 4900 40  0000 C CNN
F 1 "100K Ohms" V 7807 4901 40  0000 C CNN
F 2 "~" V 7730 4900 30  0000 C CNN
F 3 "~" H 7800 4900 30  0000 C CNN
	1    7800 4900
	0    -1   -1   0   
$EndComp
$Comp
L R R104
U 1 1 5D951EF4
P 7150 4900
F 0 "R104" V 7230 4900 40  0000 C CNN
F 1 "100K Ohms" V 7157 4901 40  0000 C CNN
F 2 "~" V 7080 4900 30  0000 C CNN
F 3 "~" H 7150 4900 30  0000 C CNN
	1    7150 4900
	0    -1   -1   0   
$EndComp
$Comp
L R R103
U 1 1 5D951F09
P 6750 4950
F 0 "R103" V 6830 4950 40  0000 C CNN
F 1 "100K Ohms" V 6757 4951 40  0000 C CNN
F 2 "~" V 6680 4950 30  0000 C CNN
F 3 "~" H 6750 4950 30  0000 C CNN
	1    6750 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4600 8050 4500
Wire Wire Line
	8050 4800 8050 4900
Wire Wire Line
	7550 4900 7400 4900
Wire Wire Line
	6900 4900 6900 4500
Wire Wire Line
	6900 4500 7550 4500
$Comp
L +3.3V #PWR021
U 1 1 5D9520F0
P 7550 4350
F 0 "#PWR021" H 7550 4310 30  0001 C CNN
F 1 "+3.3V" H 7550 4460 30  0000 C CNN
F 2 "" H 7550 4350 60  0000 C CNN
F 3 "" H 7550 4350 60  0000 C CNN
	1    7550 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 4500 7550 4350
Wire Wire Line
	8050 4700 6750 4700
$Comp
L GND #PWR022
U 1 1 5D9521F6
P 6750 5300
F 0 "#PWR022" H 6750 5300 30  0001 C CNN
F 1 "GND" H 6750 5230 30  0001 C CNN
F 2 "" H 6750 5300 60  0000 C CNN
F 3 "" H 6750 5300 60  0000 C CNN
	1    6750 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 5200 6750 5300
Text Label 6750 4700 2    60   ~ 0
Reverser
Text Label 4900 4000 2    25   ~ 0
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
Text Label 4900 3700 2    25   ~ 0
Button_A
Text Label 4900 3750 2    25   ~ 0
Button_B
Text Label 4900 3850 2    25   ~ 0
Button_C
Text Label 4900 3900 2    25   ~ 0
Button_D
Text Label 4900 3950 2    25   ~ 0
Bell
Text Label 5800 3900 0    25   ~ 0
L_Off
Text Label 5800 4000 0    25   ~ 0
L_Dim
Text Label 5800 4050 0    25   ~ 0
L_Bright
Text Label 5800 4150 0    25   ~ 0
L_Ditch
Text Label 4900 4100 2    25   ~ 0
Status_R
Text Label 4900 3800 2    25   ~ 0
Status_G
NoConn ~ 5650 1750
NoConn ~ 5450 1750
NoConn ~ 5150 1750
NoConn ~ 4900 4250
NoConn ~ 4900 4300
NoConn ~ 4900 4350
NoConn ~ 5800 4350
NoConn ~ 5800 4300
NoConn ~ 5800 3650
NoConn ~ 4900 4050
NoConn ~ 5800 4200
NoConn ~ 5800 4250
NoConn ~ 5800 3700
$Comp
L BARREL_JACK CON101
U 1 1 5D95D639
P 4100 2400
F 0 "CON101" H 4100 2650 60  0000 C CNN
F 1 "BARREL_JACK" H 4100 2200 60  0000 C CNN
F 2 "~" H 4100 2400 60  0000 C CNN
F 3 "~" H 4100 2400 60  0000 C CNN
	1    4100 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 2300 4700 2300
Wire Wire Line
	4700 2300 4700 1750
Wire Wire Line
	4400 2500 5150 2500
Wire Wire Line
	5150 2500 5150 1800
Connection ~ 5150 1800
$Comp
L GND #PWR023
U 1 1 5D9602D3
P 1550 1100
F 0 "#PWR023" H 1550 1100 30  0001 C CNN
F 1 "GND" H 1550 1030 30  0001 C CNN
F 2 "" H 1550 1100 60  0000 C CNN
F 3 "" H 1550 1100 60  0000 C CNN
	1    1550 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1100 1550 900 
Connection ~ 1550 900 
$Comp
L CONN_2 J109
U 1 1 5D9627A7
P 5750 2200
F 0 "J109" V 5700 2200 40  0000 C CNN
F 1 "On-Off Switch" V 5800 2200 40  0000 C CNN
F 2 "~" H 5750 2200 60  0000 C CNN
F 3 "~" H 5750 2200 60  0000 C CNN
	1    5750 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 1750 5350 2300
Wire Wire Line
	5350 2300 5400 2300
Wire Wire Line
	5400 2100 5400 1800
Connection ~ 5400 1800
NoConn ~ 4900 4200
$EndSCHEMATC
