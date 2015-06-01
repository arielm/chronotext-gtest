#!/bin/sh

GTEST_DIR="googletest-emscripten"
GTEST_ZIP="emscripten.zip"
GTEST_SRC="https://github.com/arielm/googletest/archive/${GTEST_ZIP}"

rm -rf dist

# -----------
# DOWNLOADING
# -----------

if [ ! -f $GTEST_ZIP ]; then
  echo "DOWNLOADING ${GTEST_SRC}"
  curl -L -O $GTEST_SRC
fi

if [ ! -f $GTEST_ZIP ]; then
  echo "DOWNLOADING FAILED!"
  exit 1
fi

# ---------
# UNPACKING
# ---------

echo "UNPACKING ${$GTEST_ZIP}"
unzip $GTEST_ZIP

if [ ! -d $GTEST_DIR ]; then
  echo "UNPACKING FAILED!"
  exit 1
fi

mv ${GTEST_DIR} dist
ln -s dist/include include

echo "DONE!"
