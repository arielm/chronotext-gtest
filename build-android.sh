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
INSTALL_PATH="../../../../../lib/$INSTALL_PREFIX"
TOOLCHAIN_FILE="../../../../../cmake/android.toolchain.cmake"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_BUILD_TYPE=Release \
  -DANDROID_NDK="$NDK_ROOT" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_PLATFORM \
  ../../gtest

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')
make VERBOSE=1 -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi
