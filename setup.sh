#!/bin/sh

BUILD_DIR="build"

# ---

cmake -H. -B"$BUILD_DIR"

if (( $? )); then
  echo "CONFIGURATION FAILED!"
  exit -1
fi

# ---

cmake --build "$BUILD_DIR"

if (( $? )); then
  echo "BUILD FAILED!"
  exit -1
fi

# ---

export RUN_TEST="ctest -S $(pwd)/cmake/run.cmake -VV"
