set(DEPS
    I2CDriver
    OpenMRNIDF
   )
              

idf_component_register(SRCS Adafruit_TCA8418.cpp
                       INCLUDE_DIRS "include"
                       PRIV_INCLUDE_DIRS "private_include"
                       REQUIRES "${DEPS}"
                      )
