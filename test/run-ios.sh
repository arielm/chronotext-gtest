#!/bin/sh

if [ -z $GTEST_PATH ]; then
  echo "GTEST_PATH MUST BE DEFINED!"
  exit -1  
fi

# ---

IOS_SDK="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
SRC="hello_gtest.cpp"

clang++ ${SRC} -arch armv7 -arch arm64 -std=c++11 -stdlib=libc++ -miphoneos-version-min=5.0 -isysroot ${IOS_SDK} -I${GTEST_PATH}/include -L${GTEST_PATH}/lib/ios -lgtest -lgtest_main
