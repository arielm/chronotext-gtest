#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

OSX_DEPLOYMENT_TARGET=10.7
OSX_ARCHS="x86_64"
CMAKE_TOOLCHAIN_FILE="../../cmake/osx.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
  -DOSX_DEPLOYMENT_TARGET=$OSX_DEPLOYMENT_TARGET \
  -DOSX_ARCHS="$OSX_ARCHS" \
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

INSTALL_PREFIX="osx"
LIB_DIR="../../lib/$INSTALL_PREFIX"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
