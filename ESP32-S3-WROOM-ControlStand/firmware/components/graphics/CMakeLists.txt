set(DEPS
    I2CDriver
    OpenMRNIDF
   )
   

idf_component_register(SRCS Adafruit_GFX.cpp Adafruit_SSD1306.cpp Print.cpp 
                      INCLUDE_DIRS "include" 
                      PRIV_INCLUDE_DIRS "private_include"
                      REQUIRES "${DEPS}"
                      )
