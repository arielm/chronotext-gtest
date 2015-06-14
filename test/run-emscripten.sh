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
INSTALL_PATH="$(pwd)/bin/$INSTALL_PREFIX"

emcmake cmake -H. -B"$BUILD_DIR" \
  -G Ninja \
  -DCMAKE_VERBOSE_MAKEFILE=OFF \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DEXECUTABLE_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DNO_CMAKE_FIND_ROOT_PATH=1

if (( $? )) ; then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

cmake --build "$BUILD_DIR"

if (( $? )) ; then
  echo "BUILD FAILED!"
  exit -1
fi

# ---

cd "$INSTALL_PATH"
node $PROJECT_NAME.js
