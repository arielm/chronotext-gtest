#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

if [ -z "$NDK_ROOT" ]; then
  echo "NDK_ROOT MUST BE DEFINED!"
  exit -1
fi

rm -rf build
mkdir build && cd build

# ---

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM=android-16

INSTALL_PREFIX="android/armeabi-v7a"
CMAKE_TOOLCHAIN_FILE="$GTEST_ROOT/cmake/android.toolchain.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
  -DANDROID_NDK="$NDK_ROOT" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_PLATFORM \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DNO_CMAKE_FIND_ROOT_PATH=1 \
  -DCMAKE_BUILD_TYPE=Release \
  ..

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')
make VERBOSE="" -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

EXE="HelloGTest"

adb push $EXE /data/local/tmp/
adb shell /data/local/tmp/$EXE
