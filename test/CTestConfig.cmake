
if (NOT DEFINED ENV{GTEST_PATH})
  message(FATAL_ERROR "GTEST_PATH MUST BE DEFINED!")
endif()

set(CTEST_PROJECT_NAME "TestGTest")

# ---

set(CTEST_CONFIGURATION_TYPE Release)

if (PLATFORM STREQUAL osx)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE osx.cmake)

elseif (PLATFORM STREQUAL ios)
  set(CTEST_CMAKE_GENERATOR "Xcode")
  set(TOOLCHAIN_FILE ios.xcode.cmake)

elseif (PLATFORM STREQUAL android)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE android.cmake)

elseif (PLATFORM STREQUAL emscripten)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE emscripten.cmake)

elseif (PLATFORM STREQUAL wine)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE wine.cmake)
  set(STAGING_PREFIX "/usr/src")

else()
  message(FATAL_ERROR "UNSUPPORTED PLATFORM!")
endif()

set(CONFIGURE_ARGS "${CONFIGURE_ARGS} -DGTEST_ROOT=$ENV{GTEST_PATH}/dist/${PLATFORM}")
