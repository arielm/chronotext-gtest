#!/bin/sh

if [ -z "$GTEST_PATH" ]; then
  echo "GTEST_PATH MUST BE DEFINED!"
  exit -1  
fi

# ---

IOS_SDK="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
SRC="hello_gtest.cpp"

clang++ $SRC -arch armv7 -std=c++11 -stdlib=libc++ -miphoneos-version-min=5.0 -isysroot "$IOS_SDK" -I"$GTEST_PATH/include" -L"$GTEST_PATH/lib/ios" -lgtest -lgtest_main

if (( $? )) ; then
  echo "COMPILATION FAILED!"
  exit -1
fi

# ---

APP="HelloGTest.app"
CODE_SIGN_IDENTITY="iPhone Developer"

rm -rf $APP
mkdir -p $APP

mv a.out $APP/
cp ios/Info.plist ios/ResourceRules.plist $APP/
codesign -f -s "$CODE_SIGN_IDENTITY" --entitlements ios/Entitlements.plist $APP

ios-deploy --uninstall --noninteractive --debug --bundle $APP
