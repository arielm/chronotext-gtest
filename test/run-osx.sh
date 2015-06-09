#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

rm -rf build
mkdir build && cd build

# ---

OSX_DEPLOYMENT_TARGET=10.7
OSX_ARCHS="x86_64"

INSTALL_PREFIX="osx"
CMAKE_TOOLCHAIN_FILE="$GTEST_ROOT/cmake/osx.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
  -DOSX_DEPLOYMENT_TARGET=$OSX_DEPLOYMENT_TARGET \
  -DOSX_ARCHS="$OSX_ARCHS" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  ..

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')
make VERBOSE="" -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

EXE="HelloGTest"
./$EXE
