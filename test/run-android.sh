#!/bin/sh

if [ -z $GTEST_PATH ]; then
  echo "GTEST_PATH MUST BE DEFINED!"
  exit -1  
fi

HOST_NUM_CPUS=$(sysctl hw.ncpu | awk '{print $2}')

# ---

ANDROID_ABI="armeabi-v7a"
EXE="hello_gtest"

ndk-build -j$HOST_NUM_CPUS

adb push obj/local/${ANDROID_ABI}/${EXE} /data/local/tmp/
adb shell /data/local/tmp/${EXE}
