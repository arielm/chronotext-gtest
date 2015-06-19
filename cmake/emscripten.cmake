
if (NOT DEFINED ENV{EMSCRIPTEN_ROOT})
  message(FATAL_ERROR "'EMSCRIPTEN_ROOT' ENVIRONMENT-VARIABLE MUST BE DEFINED!")
endif()

# ---

#
# TODO: AVOID DOUBLE-INCLUSION OF FLAGS
#
set(CMAKE_CXX_FLAGS "-Wno-warn-absolute-paths -std=c++11"
  CACHE STRING "cmake_cxx_flags/emscripten"
)

include("$ENV{EMSCRIPTEN_ROOT}/cmake/Modules/Platform/Emscripten.cmake")

# ---

set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)

set(CMAKE_LIBRARY_ARCHITECTURE emscripten)

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL CMAKE_TRY_COMPILE)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/run/emscripten.sh.in run)
  endif()
endif()
