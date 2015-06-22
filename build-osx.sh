#!/bin/sh

SRC_DIR="build/gtest-prefix/src/gtest"

if [ ! -d "$SRC_DIR" ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

# ---

OSX_DEPLOYMENT_TARGET=10.7
OSX_ARCHS="i386;x86_64"

TOOLCHAIN_FILE="$(pwd)/cmake/osx.cmake"

# ---

PLATFORM="osx"

BUILD_DIR="build/$PLATFORM"
INSTALL_DIR="dist/$PLATFORM"

cmake -H"$SRC_DIR" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$(pwd)/$INSTALL_DIR/lib" \
  -DOSX_DEPLOYMENT_TARGET=$OSX_DEPLOYMENT_TARGET \
  -DOSX_ARCHS="$OSX_ARCHS"

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
