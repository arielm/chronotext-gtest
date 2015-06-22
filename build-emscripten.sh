#!/bin/sh

SRC_DIR="build/gtest-prefix/src/gtest"
SRC_PATH="$(pwd)/$SRC_DIR"

if [ ! -d "$SRC_PATH" ]; then
  echo "SOURCE NOT FOUND!"
  exit 1
fi

# ---

PLATFORM="emscripten"

BUILD_DIR="build/gtest-prefix/src/gtest-build/$PLATFORM"
INSTALL_PATH="$(pwd)/dist/$PLATFORM"

emcmake cmake -H"$SRC_DIR" -B"$BUILD_DIR" \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$INSTALL_PATH/lib" \
  -Dgtest_disable_pthreads=ON

if (( $? )); then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

rm -rf "$INSTALL_PATH"
cmake --build "$BUILD_DIR"

if (( $? )); then
  echo "BUILD FAILED!"
  exit -1
fi

cd "$INSTALL_PATH"
ln -s "$SRC_PATH/include"
