#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

if [ -z "$NDK_ROOT" ]; then
  echo "NDK_ROOT MUST BE DEFINED!"
  exit -1
fi

PROJECT_NAME="HelloGTest"
BUILD_TYPE=Release
INSTALL_PREFIX="android"

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM=android-16

# ---

BUILD_DIR="build/$INSTALL_PREFIX"
INSTALL_PATH="$(pwd)/bin/$INSTALL_PREFIX"
TOOLCHAIN_FILE="$GTEST_ROOT/cmake/android.toolchain.cmake"

cmake -H. -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja \
  -DCMAKE_VERBOSE_MAKEFILE=OFF \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DEXECUTABLE_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DNO_CMAKE_FIND_ROOT_PATH=1 \
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

# ---

adb push "$INSTALL_PATH/$PROJECT_NAME" /data/local/tmp/
adb shell /data/local/tmp/$PROJECT_NAME
