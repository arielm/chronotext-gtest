#!/bin/sh

GTEST_VER1=1
GTEST_VER2=7
GTEST_VER3=0

GTEST_DIR="gtest-${GTEST_VER1}.${GTEST_VER2}.${GTEST_VER3}"
GTEST_ZIP="gtest-${GTEST_VER1}.${GTEST_VER2}.${GTEST_VER3}.zip"
GTEST_SRC="http://googletest.googlecode.com/files/${GTEST_ZIP}"

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
