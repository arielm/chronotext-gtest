#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

emcmake cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -Dgtest_disable_pthreads=ON \
  -Dgtest_build_tests=OFF \
  ..

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')
emmake make VERBOSE="" -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

INSTALL_PREFIX="emscripten"
LIB_DIR="../../lib/$INSTALL_PREFIX"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
