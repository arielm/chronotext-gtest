#!/bin/sh

SRC_DIR="build/gtest-prefix/src"

if [ ! -d $SRC_DIR ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

INSTALL_PREFIX="android"

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM=android-16

# ---

BUILD_DIR="$SRC_DIR/gtest-build/$INSTALL_PREFIX"
INSTALL_PATH="$(pwd)/lib/$INSTALL_PREFIX"
TOOLCHAIN_FILE="$(pwd)/cmake/android.toolchain.cmake"

cmake -H"$SRC_DIR/gtest" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_VERBOSE_MAKEFILE=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH" \
  -DANDROID_NDK="$NDK_ROOT" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_PLATFORM

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
