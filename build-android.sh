#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

TOOLCHAIN_FILE="../../cmake/android.toolchain.cmake"
INSTALL_PREFIX="android/armeabi-v7a"

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM=android-16

cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
  -DLIBRARY_OUTPUT_PATH="../../lib/$INSTALL_PREFIX" \
  -DANDROID_NDK="$NDK_ROOT" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_NATIVE_API_LEVEL=$ANDROID_PLATFORM \
  -DCMAKE_BUILD_TYPE=Release \
  -Dgtest_build_tests=OFF \
  ..

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
