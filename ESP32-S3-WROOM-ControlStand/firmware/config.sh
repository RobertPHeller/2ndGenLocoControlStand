#!/bin/bash
. ~/esp-idf-v5.0.1/export.sh
idf.py set-target esp32s3
idf.py menuconfig
