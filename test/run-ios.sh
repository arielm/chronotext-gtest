#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

rm -rf build
mkdir build && cd build

# ---

TOOLCHAIN_FILE="$GTEST_ROOT/cmake/ios.xcode.cmake"
INSTALL_PREFIX="ios"
INSTALL_PATH="../bin/$INSTALL_PREFIX"

#IOS_DEPLOYMENT_TARGET=5.1.1
#IOS_ARCHS="armv7"

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"

cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Xcode \
  -DEXECUTABLE_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DIOS_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
  -DIOS_ARCHS="$IOS_ARCHS" \
  -DCMAKE_BUILD_TYPE=Release \
  ..

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

PROJECT_NAME="HelloGTest"
xcodebuild -target $PROJECT_NAME -configuration Release

if (( $? )) ; then
  echo "xcodebuild FAILED!"
  exit -1
fi

# ---

ios-deploy --noninteractive --debug --bundle "$INSTALL_PATH/Release/$PROJECT_NAME.app"
