#!/bin/sh

if [ ! -d dist ]; then
  echo "ERROR: dist DIRECTORY NOT FOUND!"
  echo "DID YOU EXECUTE setup.sh?"
  exit 1
fi

# ---

cd dist

rm -rf build
mkdir build
cd build

emcmake cmake -Dgtest_disable_pthreads=ON -DCMAKE_BUILD_TYPE=Release ..
emmake make

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
ls -1 ${LIB_DIR}/*.a
