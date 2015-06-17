
if (NOT DEFINED ENV{NDK_ROOT})
  message(FATAL_ERROR "'NDK_ROOT' ENVIRONMENT-VARIABLE MUST BE DEFINED!")
endif()

set(ANDROID_ABI "armeabi-v7a"
  CACHE STRING "android_abi"
)

set(ANDROID_PLATFORM android-16
  CACHE STRING "android_platform"
)

# ---

set(ANDROID_NDK "$ENV{NDK_ROOT}")
set(ANDROID_ABI "${ANDROID_ABI}")
set(ANDROID_NATIVE_API_LEVEL ${ANDROID_PLATFORM})

set(CMAKE_CXX_FLAGS "-std=c++11"
  CACHE STRING "cmake_cxx_flags/android"
)

include("${CMAKE_CURRENT_LIST_DIR}/android.toolchain.cmake")

# ---

set(CMAKE_LIBRARY_ARCHITECTURE android)

set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL "CMAKE_TRY_COMPILE")
    configure_file(cmake/run.android.sh.in run)
  endif()
endif()
