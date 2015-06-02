#!/bin/sh

if [ ! -d dist ]; then
  echo "ERROR: dist DIRECTORY NOT FOUND!"
  echo "DID YOU EXECUTE setup.sh?"
  exit 1
fi

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')

# ---

CMAKE_TOOLCHAIN_FILE="../../cmake/platforms/ios.toolchain.cmake"

# ---

cd dist

rm -rf build
mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DIOS_PLATFORM=OS -DCMAKE_BUILD_TYPE=Release -Dgtest_build_tests=OFF ..
make -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "MAKE FAILED!"
  exit -1
fi

# ---

LIB_DIR="../../lib/ios"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR

mv libgtest.a $LIB_DIR
mv libgtest_main.a $LIB_DIR

echo "DONE!"
