
if (NOT DEFINED ENV{CMAKE_TOOLCHAIN_FILE})
  message(FATAL_ERROR "CMAKE_TOOLCHAIN_FILE MUST BE DEFINED!")
endif()

# ---

#
# TODO: AVOID DOUBLE-INCLUSION OF FLAGS
#
set(CMAKE_CXX_FLAGS "-std=c++11"
  CACHE STRING "cmake_cxx_flags/wine"
)

include("$ENV{CMAKE_TOOLCHAIN_FILE}")

# ---

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL CMAKE_TRY_COMPILE)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/run/wine.sh.in run)
  endif()
endif()
