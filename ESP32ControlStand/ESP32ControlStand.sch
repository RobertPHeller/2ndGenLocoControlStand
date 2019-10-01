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
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "1 oct 2019"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_3 J?
U 1 1 5D93DFEE
P 8450 3950
F 0 "J?" V 8400 3950 50  0000 C CNN
F 1 "Throttle" V 8500 3950 40  0000 C CNN
F 2 "~" H 8450 3950 60  0000 C CNN
F 3 "~" H 8450 3950 60  0000 C CNN
	1    8450 3950
	1    0    0    -1  
$EndComp
$Comp
L ENCODER EN?
U 1 1 5D93BEC4
P 9900 4750
F 0 "EN?" H 9950 4950 60  0000 C CNN
F 1 "Reverser" H 9900 4650 60  0000 C CNN
F 2 "~" H 9900 4750 60  0000 C CNN
F 3 "~" H 9900 4750 60  0000 C CNN
F 4 "PEC12R-4117F-N0012" H 9900 4750 60  0001 C CNN "Mouser Part Number"
	1    9900 4750
	1    0    0    -1  
$EndComp
$Comp
L POT RV?
U 1 1 5D93DC64
P 10000 3000
F 0 "RV?" H 10000 2900 50  0000 C CNN
F 1 "100K Ohms" H 10000 3000 50  0000 C CNN
F 2 "~" H 10000 3000 60  0000 C CNN
F 3 "~" H 10000 3000 60  0000 C CNN
	1    10000 3000
	0    -1   -1   0   
$EndComp
$Comp
L POT RV?
U 1 1 5D93DC73
P 10050 2300
F 0 "RV?" H 10050 2200 50  0000 C CNN
F 1 "100K Ohms" H 10050 2300 50  0000 C CNN
F 2 "~" H 10050 2300 60  0000 C CNN
F 3 "~" H 10050 2300 60  0000 C CNN
	1    10050 2300
	0    -1   -1   0   
$EndComp
$Comp
L ENCODER EN?
U 1 1 5D93BC04
P 9900 3900
F 0 "EN?" H 9950 4100 60  0000 C CNN
F 1 "Throttle" H 9900 3800 60  0000 C CNN
F 2 "~" H 9900 3900 60  0000 C CNN
F 3 "~" H 9900 3900 60  0000 C CNN
F 4 "688-EC11E1820402" H 9900 3900 60  0001 C CNN "Mouser Part Number"
	1    9900 3900
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P?
U 1 1 5D93BC13
P 8850 3950
F 0 "P?" V 8800 3950 50  0000 C CNN
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
L CONN_3 J?
U 1 1 5D93E112
P 8350 2250
F 0 "J?" V 8300 2250 50  0000 C CNN
F 1 "Horn" V 8400 2250 40  0000 C CNN
F 2 "~" H 8350 2250 60  0000 C CNN
F 3 "~" H 8350 2250 60  0000 C CNN
	1    8350 2250
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P?
U 1 1 5D93E12B
P 8750 2250
F 0 "P?" V 8700 2250 50  0000 C CNN
F 1 "CONN_3" V 8800 2250 40  0000 C CNN
F 2 "~" H 8750 2250 60  0000 C CNN
F 3 "~" H 8750 2250 60  0000 C CNN
	1    8750 2250
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 P?
U 1 1 5D93E13A
P 8800 3000
F 0 "P?" V 8750 3000 50  0000 C CNN
F 1 "CONN_3" V 8850 3000 40  0000 C CNN
F 2 "~" H 8800 3000 60  0000 C CNN
F 3 "~" H 8800 3000 60  0000 C CNN
	1    8800 3000
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 J?
U 1 1 5D93E149
P 8350 3050
F 0 "J?" V 8300 3050 50  0000 C CNN
F 1 "Brake" V 8400 3050 40  0000 C CNN
F 2 "~" H 8350 3050 60  0000 C CNN
F 3 "~" H 8350 3050 60  0000 C CNN
	1    8350 3050
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 P?
U 1 1 5D93E158
P 8900 4700
F 0 "P?" V 8850 4700 50  0000 C CNN
F 1 "CONN_3" V 8950 4700 40  0000 C CNN
F 2 "~" H 8900 4700 60  0000 C CNN
F 3 "~" H 8900 4700 60  0000 C CNN
	1    8900 4700
	-1   0    0    -1  
$EndComp
$Comp
L CONN_3 J?
U 1 1 5D93E167
P 8400 4700
F 0 "J?" V 8350 4700 50  0000 C CNN
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
$EndSCHEMATC
