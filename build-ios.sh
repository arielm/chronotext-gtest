#!/bin/sh

SRC_DIR="build/gtest-prefix/src/gtest"

if [ ! -d "$SRC_DIR" ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

# ---

#IOS_DEPLOYMENT_TARGET=5.1.1
#IOS_ARCHS="armv7"

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"

TOOLCHAIN_FILE="$(pwd)/cmake/ios.cmake"

# ---

PLATFORM="ios"

BUILD_DIR="build/$PLATFORM"
INSTALL_DIR="dist/$PLATFORM"

cmake -H"$SRC_DIR" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$(pwd)/$INSTALL_DIR/lib" \
  -DIOS_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
  -DIOS_ARCHS="$IOS_ARCHS"

if (( $? )); then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

rm -rf "$INSTALL_DIR"

cmake --build "$BUILD_DIR"

if (( $? )); then
  echo "BUILD FAILED!"
  exit -1
fi

ln -s "$(pwd)/$SRC_DIR/include" "$INSTALL_DIR/"
