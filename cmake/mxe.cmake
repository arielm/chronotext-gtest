
if (NOT DEFINED ENV{MXE_PATH})
  message(FATAL_ERROR "MXE_PATH MUST BE DEFINED!")
endif()

# ---

set(MXE_TARGET i686-w64-mingw32.static
  CACHE STRING "mxe_target"
)

#
# TODO: AVOID DOUBLE-INCLUSION OF FLAGS
#
set(CMAKE_CXX_FLAGS "-std=c++11"
  CACHE STRING "cmake_cxx_flags/mxe"
)

include("$ENV{MXE_PATH}/usr/${MXE_TARGET}/share/cmake/mxe-conf.cmake")

# ---

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL CMAKE_TRY_COMPILE)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/run/mxe.sh.in run)
  endif()
endif()
