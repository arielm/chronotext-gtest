
if (NOT DEFINED ENV{NDK_PATH})
  message(FATAL_ERROR "NDK_PATH MUST BE DEFINED!")
endif()

set(ANDROID_NDK "$ENV{NDK_PATH}"
  CACHE STRING "android_ndk"
)

set(ANDROID_ABI "armeabi-v7a"
  CACHE STRING "android_abi"
)

set(ANDROID_API android-16
  CACHE STRING "android_api"
)

# ---

set(ANDROID_NATIVE_API_LEVEL ${ANDROID_API})

#
# TODO: AVOID DOUBLE-INCLUSION OF FLAGS
#
set(CMAKE_CXX_FLAGS "-std=c++11"
  CACHE STRING "cmake_cxx_flags/android"
)

include("${CMAKE_CURRENT_LIST_DIR}/android.toolchain.cmake")

# ---

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL CMAKE_TRY_COMPILE)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/android/run.sh.in run.sh)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/android/install.sh.in install.sh)
    
    install(CODE "
      execute_process(COMMAND ./install.sh RESULT_VARIABLE result)
      if (result)
        message(FATAL_ERROR)
      endif()
    ")
  endif()
endif()
