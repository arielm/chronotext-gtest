#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

if [ -z "$NDK_ROOT" ]; then
  echo "NDK_ROOT MUST BE DEFINED!"
  exit -1
fi

INSTALL_PREFIX="android"

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM=android-16

# ---

BUILD_DIR="build/$INSTALL_PREFIX"
INSTALL_PATH="../../bin/$INSTALL_PREFIX"
TOOLCHAIN_FILE="$GTEST_ROOT/cmake/android.toolchain.cmake"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
  -DEXECUTABLE_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DNO_CMAKE_FIND_ROOT_PATH=1 \
  -DANDROID_NDK="$NDK_ROOT" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_PLATFORM \
  -DCMAKE_BUILD_TYPE=Release \
  ../..

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

# ---

PROJECT_NAME="HelloGTest"

adb push "$INSTALL_PATH/$PROJECT_NAME" /data/local/tmp/
adb shell /data/local/tmp/$PROJECT_NAME
