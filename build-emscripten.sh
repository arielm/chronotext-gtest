#!/bin/sh

SRC_DIR="build/gtest-prefix/src"

if [ ! -d $SRC_DIR ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

INSTALL_PREFIX="emscripten"

# ---

BUILD_DIR="$SRC_DIR/gtest-build/$INSTALL_PREFIX"
INSTALL_PATH="$(pwd)/lib/$INSTALL_PREFIX"

emcmake cmake -H"$SRC_DIR/gtest" -B"$BUILD_DIR" \
  -G Ninja \
  -DCMAKE_VERBOSE_MAKEFILE=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH" \
  -Dgtest_disable_pthreads=ON

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
