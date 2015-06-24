#
# USAGE EXAMPLES:
#
# 1) ctest -S run.cmake -VV -DPLATFORM=osx
# 2) ctest -S run.cmake -VV -DPLATFORM=android -DCLEAN=ON
#

if (NOT DEFINED PLATFORM)
  message(FATAL_ERROR "'PLATFORM' ARGUMENT MUST BE DEFINED!")
endif()

set(CTEST_SOURCE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
set(CTEST_BINARY_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build/${PLATFORM}")

if (DEFINED CLEAN)
  ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})
endif()

# --- START ---

#
# NECESSARY: FOR "PACKAGES" TO BE FOUND WHEN CROSS-COMPILING (ANDROID, EMSCRIPTEN, MXE)
#
# REQUIRED: ALL THE "PACKAGES" MUST BE LOCATED UNDER THE "HOME" PATH
# 
# WHEN RUNNING VIA boot2docker:
# - THE "HOME" PATH CORRESPONDS TO /root
# - I.E. A MXE docker COULD BE LAUNCHED VIA: docker run --rm -it -v ~/DEV:/root/DEV:rw thewtex/cross-compiler-windows-x86
#
set(STAGING_PREFIX "$ENV{HOME}")

ctest_start(Experimental) # WILL PROCESS CTestConfig.cmake (WHICH MUST EXIST ALONGSIDE CMakeLists.txt)

# --- CONFIGURE ---

set(CTEST_CONFIGURE_COMMAND "${CMAKE_COMMAND} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/${TOOLCHAIN_FILE}")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND} -G \"${CTEST_CMAKE_GENERATOR}\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND} -DCMAKE_BUILD_TYPE=${CTEST_CONFIGURATION_TYPE}")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND} -DRUN=ON ${CONFIGURE_ARGS}")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND} -DCMAKE_STAGING_PREFIX=${STAGING_PREFIX}")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND} \"${CTEST_SOURCE_DIRECTORY}\"")

ctest_configure(RETURN_VALUE res)

if (res)
  message(FATAL_ERROR "CONFIGURE FAILED!")
endif()

# --- BUILD ---

ctest_build(RETURN_VALUE res)

if (res)
  message(FATAL_ERROR "BUILD FAILED!")
endif()

# --- TEST ---

ctest_test(RETURN_VALUE res)

if (res)
  message(FATAL_ERROR "TEST FAILED!")
endif()
