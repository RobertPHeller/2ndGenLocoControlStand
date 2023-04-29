set(DEPS
    OpenMRNIDF
   )
              

idf_component_register(SRCS Adafruit_TCA8418.cpp
                       INCLUDE_DIRS "include"
                       REQUIRES "${DEPS}"
                      )
