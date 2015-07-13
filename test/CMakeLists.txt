cmake_minimum_required (VERSION 3.2.2)

project(TestGTest)

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

add_executable(TestGTest
  gtest-message_test.cc
  gtest-printers_test.cc
)

target_link_libraries(TestGTest ${GTEST_BOTH_LIBRARIES})

enable_testing()
add_test(NAME AllTests COMMAND ./run.sh)

#add_test(NAME MessageTest  COMMAND ./run.sh --gtest_filter=MessageTest.*)
#add_test(NAME PrintersTest COMMAND ./run.sh --gtest_filter=Print*Test.*)
