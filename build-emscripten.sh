#!/bin/sh

if [ ! -d dist ]; then
  echo "dist DIRECTORY NOT FOUND!"
  exit 1
fi

cd dist

rm -rf build
mkdir build && cd build

# ---

INSTALL_PREFIX="emscripten"

emcmake cmake \
  -DLIBRARY_OUTPUT_PATH="../../lib/$INSTALL_PREFIX" \
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
emmake make VERBOSE=1 -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi
