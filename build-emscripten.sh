#!/bin/sh

SRC_DIR="build/gtest-prefix/src/gtest"

if [ ! -d "$SRC_DIR" ]; then
  echo "src DIRECTORY NOT FOUND!"
  exit 1
fi

# ---

PLATFORM="emscripten"

BUILD_DIR="build/$PLATFORM"
INSTALL_DIR="dist/$PLATFORM"

emcmake cmake -H"$SRC_DIR" -B"$BUILD_DIR" \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBRARY_OUTPUT_PATH="$(pwd)/$INSTALL_DIR/lib" \
  -Dgtest_disable_pthreads=ON

if (( $? )); then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

rm -rf "$INSTALL_DIR"

cmake --build "$BUILD_DIR"

if (( $? )); then
  echo "BUILD FAILED!"
  exit -1
fi

ln -s "$(pwd)/$SRC_DIR/include" "$INSTALL_DIR/"
