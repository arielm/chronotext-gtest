#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM=android-16
CMAKE_TOOLCHAIN_FILE="../../cmake/android.toolchain.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
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
make VERBOSE="" -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

INSTALL_PREFIX="android/armeabi-v7a"
LIB_DIR="../../lib/$INSTALL_PREFIX"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
