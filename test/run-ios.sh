#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

PROJECT_NAME="HelloGTest"
BUILD_TYPE=Release
INSTALL_PREFIX="ios"

#IOS_DEPLOYMENT_TARGET=5.1.1
#IOS_ARCHS="armv7"

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"

# ---

BUILD_DIR="build/$INSTALL_PREFIX"
INSTALL_PATH="$(pwd)/bin/$INSTALL_PREFIX"
TOOLCHAIN_FILE="$GTEST_ROOT/cmake/ios.xcode.cmake"

cmake -H. -B"$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Xcode \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DEXECUTABLE_OUTPUT_PATH="$INSTALL_PATH" \
  -DCMAKE_PREFIX_PATH="$GTEST_ROOT" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DIOS_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
  -DIOS_ARCHS="$IOS_ARCHS"

if (( $? )) ; then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

cmake --build "$BUILD_DIR" --target $PROJECT_NAME --config $BUILD_TYPE

if (( $? )) ; then
  echo "BUILD FAILED!"
  exit -1
fi

# ---

ios-deploy --noninteractive --debug --bundle "$INSTALL_PATH/$BUILD_TYPE/$PROJECT_NAME.app"
