#!/bin/sh

BUILD_DIR="build"

cmake -H. -B"$BUILD_DIR"
cmake --build "$BUILD_DIR"
