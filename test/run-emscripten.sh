#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

PROJECT_NAME="HelloGTest"
BUILD_TYPE=Release
INSTALL_PREFIX="emscripten"

# ---

BUILD_DIR="build/$INSTALL_PREFIX"
INSTALL_PATH="../../bin/$INSTALL_PREFIX"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

emcmake cmake \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DEXECUTABLE_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DNO_CMAKE_FIND_ROOT_PATH=1 \
  ../..

if (( $? )) ; then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')
emmake make VERBOSE=1 -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "BUILD FAILED!"
  exit -1
fi

# ---

cd "$INSTALL_PATH"
node $PROJECT_NAME.js
