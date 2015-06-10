#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

TOOLCHAIN_FILE="../../cmake/ios.cmake"
INSTALL_PREFIX="ios"

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"

cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
  -DLIBRARY_OUTPUT_PATH="../../lib/$INSTALL_PREFIX" \
  -DIOS_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
  -DIOS_ARCHS="$IOS_ARCHS" \
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
