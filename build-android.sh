#!/bin/sh

if [ -z "$NDK_PATH" ]; then
  echo "NDK_PATH MUST BE DEFINED!"
  exit -1  
fi

SRC_DIR="build/gtest-prefix/src/gtest"
SRC_PATH="$(pwd)/$SRC_DIR"

if [ ! -d "$SRC_PATH" ]; then
  echo "SOURCE NOT FOUND!"
  exit 1
fi

# ---

ANDROID_ABI="armeabi-v7a"
ANDROID_API=android-16

TOOLCHAIN_FILE="$(pwd)/cmake/android.toolchain.cmake"

# ---

PLATFORM="android"

BUILD_DIR="build/gtest-prefix/src/gtest-build/$PLATFORM"
INSTALL_PATH="$(pwd)/dist/$PLATFORM"

cmake -H"$SRC_DIR" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH/lib" \
  -DANDROID_NDK="$NDK_PATH" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_API

if (( $? )); then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

rm -rf "$INSTALL_PATH"
cmake --build "$BUILD_DIR"

if (( $? )); then
  echo "BUILD FAILED!"
  exit -1
fi

cd "$INSTALL_PATH"
ln -s "$SRC_PATH/include"
