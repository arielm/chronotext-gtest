# GoogleTest

Provides support for GoogleTest 1.7 (r711) and CMake (3.2.2) on:
- OSX (i386, x86_64)
- iOS (armv7, arm64)
- Android (armeabi-v7a)
- Emscripten

More info in the [Wiki](https://github.com/arielm/chronotext-gtest/wiki)...

## Setup...
```
cd chronotext-gtest
source setup.sh
```
This will download and unpack a version of GoogleTest adapted to the relevant platforms.

## Build...
```
./build-osx.sh
./build-ios.sh
./build-android.sh
./build-emscripten.sh
```
This will build and package static libs for the relevant platforms.

## Test...
```
cd test

$RUN_TEST -DPLATFORM=osx
$RUN_TEST -DPLATFORM=ios
$RUN_TEST -DPLATFORM=android
$RUN_TEST -DPLATFORM=emscripten
```
This will build and run a couple of C++ tests on the relevant platforms.
