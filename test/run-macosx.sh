#!/bin/sh

if [ -z "$GTEST_PATH" ]; then
  echo "GTEST_PATH MUST BE DEFINED!"
  exit -1  
fi

# ---

SRC="hello_gtest.cpp"

clang++ $SRC -std=c++11 -stdlib=libc++ -I"$GTEST_PATH/include" -L"$GTEST_PATH/lib/macosx" -lgtest -lgtest_main

if (( $? )) ; then
  echo "COMPILATION FAILED!"
  exit -1
fi

# ---

./a.out
