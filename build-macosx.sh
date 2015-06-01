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

cmake -DCMAKE_BUILD_TYPE=Release -Dgtest_build_tests=OFF ..
make -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "MAKE FAILED!"
  exit -1
fi

# ---

LIB_DIR="../../lib/macosx"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR
mv *.a $LIB_DIR

echo "DONE!"
