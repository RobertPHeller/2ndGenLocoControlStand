set(DEPS
    OpenMRNIDF
    app_update
    nvs_flash
   )
   

idf_component_register(SRCS NvsManager.cpp
                       INCLUDE_DIRS "include"
                       PRIV_INCLUDE_DIRS "private_include"
                       REQUIRES "${DEPS}"
                      )
