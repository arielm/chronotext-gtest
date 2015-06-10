#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

rm -rf build
mkdir build && cd build

# ---

INSTALL_PREFIX="ios"
CMAKE_TOOLCHAIN_FILE="../cmake/ios-xcode.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" -G Xcode \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  ..

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

TARGET="HelloGTest"
xcodebuild -target $TARGET -configuration Release

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

ios-deploy --noninteractive --debug --bundle Release-iphoneos/HelloGTest.app
