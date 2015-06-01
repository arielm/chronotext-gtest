# BASED ON: https://llvm.org/svn/llvm-project/llvm/trunk/cmake/platforms/iOS.cmake

#
# USAGE:
#
# mkdir build && cd build
# cmake -DCMAKE_TOOLCHAIN_FILE=path/to/the/ios.toolchain.cmake -DIOS_PLATFORM=iphoneos -DCMAKE_OSX_ARCHITECTURES="armv7"
# make
#

SET(CMAKE_SYSTEM_NAME Darwin)
SET(CMAKE_SYSTEM_VERSION 13)
SET(CMAKE_CXX_COMPILER_WORKS True)
SET(CMAKE_C_COMPILER_WORKS True)
SET(DARWIN_TARGET_OS_NAME ios)

# ---

IF (NOT CMAKE_OSX_SYSROOT)
  IF (NOT DEFINED IOS_PLATFORM)
    message(FATAL_ERROR "IOS_PLATFORM is not defined!")
  ENDIF()

  IF (NOT "${IOS_PLATFORM}" STREQUAL "iphoneos" AND NOT "${IOS_PLATFORM}" STREQUAL "iphonesimulator")
    message(FATAL_ERROR "IOS_PLATFORM must be set to either iphoneos or iphonesimulator!")
  ENDIF ()

  execute_process(COMMAND xcodebuild -version -sdk ${IOS_PLATFORM} Path
    OUTPUT_VARIABLE SDKROOT
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)

  IF (NOT EXISTS ${SDKROOT})
    message(FATAL_ERROR "SDKROOT could not be detected!")
  ENDIF()

  SET(CMAKE_OSX_SYSROOT ${SDKROOT})
ENDIF()

# ---

IF (NOT CMAKE_C_COMPILER)
  execute_process(COMMAND xcrun -sdk ${SDKROOT} -find clang
    OUTPUT_VARIABLE CMAKE_C_COMPILER
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "Using c compiler ${CMAKE_C_COMPILER}")
ENDIF()

IF (NOT CMAKE_CXX_COMPILER)
  execute_process(COMMAND xcrun -sdk ${SDKROOT} -find clang++
    OUTPUT_VARIABLE CMAKE_CXX_COMPILER
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "Using c compiler ${CMAKE_CXX_COMPILER}")
ENDIF()

IF (NOT CMAKE_AR)
  execute_process(COMMAND xcrun -sdk ${SDKROOT} -find ar
    OUTPUT_VARIABLE CMAKE_AR_val
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  SET(CMAKE_AR ${CMAKE_AR_val} CACHE FILEPATH "Archiver")
  message(STATUS "Using ar ${CMAKE_AR}")
ENDIF()

IF (NOT CMAKE_RANLIB)
  execute_process(COMMAND xcrun -sdk ${SDKROOT} -find ranlib
    OUTPUT_VARIABLE CMAKE_RANLIB_val
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  SET(CMAKE_RANLIB ${CMAKE_RANLIB_val} CACHE FILEPATH "Ranlib")
  message(STATUS "Using ranlib ${CMAKE_RANLIB}")
ENDIF()

# ---

IF (NOT DEFINED IOS_MIN_VERSION)
  execute_process(COMMAND xcodebuild -sdk ${SDKROOT} -version SDKVersion
    OUTPUT_VARIABLE IOS_MIN_VERSION
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
ENDIF()

SET(IOS_COMMON_FLAGS "-mios-version-min=${IOS_MIN_VERSION}")
SET(CMAKE_C_FLAGS "${IOS_COMMON_FLAGS}" CACHE STRING "toolchain_cflags" FORCE)
SET(CMAKE_CXX_FLAGS "${IOS_COMMON_FLAGS}" CACHE STRING "toolchain_cxxflags" FORCE)
SET(CMAKE_LINK_FLAGS "${IOS_COMMON_FLAGS}" CACHE STRING "toolchain_linkflags" FORCE)
