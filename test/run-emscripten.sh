#!/bin/sh

if [ -z "$GTEST_PATH" ]; then
  echo "GTEST_PATH MUST BE DEFINED!"
  exit -1  
fi

# ---

SRC="hello_gtest.cpp"

emcc $SRC -Wno-warn-absolute-paths -std=c++11 -I"$GTEST_PATH/include" -L"$GTEST_PATH/lib/emscripten" -lgtest -lgtest_main

if (( $? )) ; then
  echo "COMPILATION FAILED!"
  exit -1
fi

# ---

node a.out.js
