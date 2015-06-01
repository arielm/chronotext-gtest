#!/bin/sh

if [ ! -d dist ]; then
  echo "ERROR: dist DIRECTORY NOT FOUND!"
  echo "DID YOU EXECUTE setup.sh?"
  exit 1
fi

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')

# ---

CMAKE_TOOLCHAIN_FILE="../../cmake/platforms/ios.toolchain.cmake"

IOS_PLATFORM="iphoneos"
IOS_MIN_VERSION="5.0"

ARCH1="armv7"
ARCH2="arm64"

# ---

cd dist

rm -rf build
mkdir build
cd build

### ARCH 1 ###

cmake -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DIOS_PLATFORM=${IOS_PLATFORM} -DIOS_MIN_VERSION=${IOS_MIN_VERSION} -DCMAKE_OSX_ARCHITECTURES=${ARCH1} -DCMAKE_BUILD_TYPE=Release -Dgtest_build_tests=OFF ..
make -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "MAKE FAILED!"
  exit -1
fi

mv libgtest.a libgtest.${ARCH1}.a
mv libgtest_main.a libgtest_main.${ARCH1}.a

### ARCH 2 ###

ls | grep -v libgtest.${ARCH1}.a | grep -v libgtest_main.${ARCH1}.a | xargs rm -rf

cmake -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DIOS_PLATFORM=${IOS_PLATFORM} -DIOS_MIN_VERSION=${IOS_MIN_VERSION} -DCMAKE_OSX_ARCHITECTURES=${ARCH2} -DCMAKE_BUILD_TYPE=Release -Dgtest_build_tests=OFF ..
make -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "MAKE FAILED!"
  exit -1
fi

mv libgtest.a libgtest.${ARCH2}.a
mv libgtest_main.a libgtest_main.${ARCH2}.a

### LIPO ###

lipo -create -output libgtest.a libgtest.${ARCH1}.a libgtest.${ARCH2}.a
lipo -create -output libgtest_main.a libgtest_main.${ARCH1}.a libgtest_main.${ARCH2}.a

# ---

LIB_DIR="../../lib/ios"

rm -rf $LIB_DIR
mkdir -p $LIB_DIR

mv libgtest.a $LIB_DIR
mv libgtest_main.a $LIB_DIR

echo "DONE!"
