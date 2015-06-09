#!/bin/sh

if [ -z "$GTEST_ROOT" ]; then
  echo "GTEST_ROOT MUST BE DEFINED!"
  exit -1  
fi

rm -rf build
mkdir build && cd build

# ---

IOS_DEPLOYMENT_TARGET=6.0
IOS_ARCHS="armv7;arm64"

INSTALL_PREFIX="ios"
CMAKE_TOOLCHAIN_FILE="$GTEST_ROOT/cmake/ios.cmake"

cmake -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
  -DIOS_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
  -DIOS_ARCHS="$IOS_ARCHS" \
  -DCMAKE_LIBRARY_ARCHITECTURE="$INSTALL_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  ..

if (( $? )) ; then
  echo "cmake FAILED!"
  exit -1
fi

# ---

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')
make VERBOSE="" -j$HOST_NUM_CPUS

if (( $? )) ; then
  echo "make FAILED!"
  exit -1
fi

# ---

CODE_SIGN_IDENTITY="iPhone Developer"
EXE="HelloGTest"
APP="$EXE.app"

rm -rf $APP
mkdir -p $APP

mv $EXE $APP/
cp ../ios/Info.plist ../ios/ResourceRules.plist $APP/
codesign -f -s "$CODE_SIGN_IDENTITY" --entitlements ../ios/Entitlements.plist $APP

ios-deploy --noninteractive --debug --bundle $APP
