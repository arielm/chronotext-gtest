#!/bin/sh

if [ -z $NDK_PATH ]; then
  echo "NDK_PATH MUST BE DEFINED!"
  exit -1
fi

if [ ! -d dist ]; then
  echo "ERROR: dist DIRECTORY NOT FOUND!"
  echo "DID YOU EXECUTE setup.sh?"
  exit 1
fi

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')

# ---

CMAKE_TOOLCHAIN_FILE="../../cmake/platforms/android.toolchain.cmake"

ANDROID_ABI="armeabi-v7a"
ANDROID_PLATFORM="android-16"

# ---

cd dist

rm -rf build
mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DANDROID_NDK=${NDK_PATH} -DANDROID_ABI=${ANDROID_ABI} -DANDROID_NATIVE_API_LEVEL=${ANDROID_PLATFORM} -DCMAKE_BUILD_TYPE=Release ..
make -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "MAKE FAILED!"
  exit -1
fi

# ---

LIB_DIR="../../lib/android/${ANDROID_ABI}"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
ls -1 ${LIB_DIR}/*.a
