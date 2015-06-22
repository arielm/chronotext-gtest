#!/bin/sh

SRC_DIR="build/gtest-prefix/src/gtest"

if [ ! -d "$SRC_DIR" ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

# ---

ANDROID_ABI="armeabi-v7a"
ANDROID_API=android-16

TOOLCHAIN_FILE="$(pwd)/cmake/android.toolchain.cmake"

# ---

PLATFORM="android"

BUILD_DIR="build/$PLATFORM"
INSTALL_DIR="dist/$PLATFORM"

cmake -H"$SRC_DIR" -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$(pwd)/$INSTALL_DIR/lib" \
  -DANDROID_NDK="$NDK_PATH" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_API

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
