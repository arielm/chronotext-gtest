#!/bin/sh

SRC_DIR="build/gtest-prefix/src"

if [ ! -d $SRC_DIR ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

INSTALL_PREFIX="osx"

OSX_DEPLOYMENT_TARGET=10.7
OSX_ARCHS="x86_64"

# ---

BUILD_DIR="$SRC_DIR/gtest-build/$INSTALL_PREFIX"
INSTALL_PATH="$(pwd)/lib/$INSTALL_PREFIX"
TOOLCHAIN_FILE="$(pwd)/cmake/osx.cmake"

cmake -H"$SRC_DIR/gtest" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_VERBOSE_MAKEFILE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH" \
  -DOSX_DEPLOYMENT_TARGET=$OSX_DEPLOYMENT_TARGET \
  -DOSX_ARCHS="$OSX_ARCHS"

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
