#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"
CMAKE_TOOLCHAIN_FILE="../../cmake/ios.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
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
make VERBOSE="" -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

INSTALL_PREFIX="ios"
LIB_DIR="../../lib/$INSTALL_PREFIX"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
