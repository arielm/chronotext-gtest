
if (NOT DEFINED ENV{GTEST_ROOT})
  message(FATAL_ERROR "'GTEST_ROOT' ENVIRONMENT-VARIABLE MUST BE DEFINED!")
endif()

set(CTEST_PROJECT_NAME "TestGTest")

# ---

set(CTEST_CONFIGURATION_TYPE Release)

set(PREFIX_PATH
  $ENV{GTEST_ROOT}
)

if (PLATFORM STREQUAL osx)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE osx.cmake)
  set(CONFIGURE_ARGS "")

elseif (PLATFORM STREQUAL ios)
  set(CTEST_CMAKE_GENERATOR "Xcode")
  set(TOOLCHAIN_FILE ios.xcode.cmake)
  set(CONFIGURE_ARGS "")

elseif (PLATFORM STREQUAL android)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE android.cmake)
  set(CONFIGURE_ARGS "")

elseif (PLATFORM STREQUAL emscripten)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE emscripten.cmake)
  set(CONFIGURE_ARGS "")

else()
  message(FATAL_ERROR "UNSUPPORTED PLATFORM!")
endif()
