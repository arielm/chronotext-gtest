cmake_minimum_required (VERSION 3.2.2)

project(TestGTest)

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

add_executable(TestGTest gtest-message_test.cc)
target_link_libraries(TestGTest ${GTEST_BOTH_LIBRARIES})

enable_testing()
add_test(NAME TestGTest COMMAND run)
