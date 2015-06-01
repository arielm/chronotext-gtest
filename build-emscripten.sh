#!/bin/sh

if [ ! -d dist ]; then
  echo "ERROR: dist DIRECTORY NOT FOUND!"
  echo "DID YOU EXECUTE setup.sh?"
  exit 1
fi

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')

# ---

cd dist

rm -rf build
mkdir build
cd build

emcmake cmake -DCMAKE_BUILD_TYPE=Release -Dgtest_disable_pthreads=ON -Dgtest_build_tests=OFF ..
emmake make -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "MAKE FAILED!"
  echo "IS /system/lib/libcxxabi/include/cxxabi.h PROPERLY INCLUDED?"
  exit -1
fi

# ---

LIB_DIR="../../lib/emscripten"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
