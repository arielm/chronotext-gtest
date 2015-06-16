cmake_minimum_required (VERSION 3.2.2)

project (HelloGTest)

find_package (GTest REQUIRED)
include_directories (${GTEST_INCLUDE_DIRS})

add_executable (HelloGTest HelloGTest.cpp)
target_link_libraries (HelloGTest ${GTEST_BOTH_LIBRARIES})

enable_testing()
add_test (NAME MainTest COMMAND run)
