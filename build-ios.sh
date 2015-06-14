#!/bin/sh

SRC_DIR="build/gtest-prefix/src"

if [ ! -d $SRC_DIR ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

INSTALL_PREFIX="ios"

#IOS_DEPLOYMENT_TARGET=5.1.1
#IOS_ARCHS="armv7"

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"

# ---

BUILD_DIR="$SRC_DIR/gtest-build/$INSTALL_PREFIX"
INSTALL_PATH="$(pwd)/lib/$INSTALL_PREFIX"
TOOLCHAIN_FILE="$(pwd)/cmake/ios.cmake"

cmake -H"$SRC_DIR/gtest" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
  -DCMAKE_VERBOSE_MAKEFILE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH" \
  -DIOS_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
  -DIOS_ARCHS="$IOS_ARCHS"

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
