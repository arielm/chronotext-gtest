cmake_minimum_required (VERSION 3.2.2)

project (HelloGTest)

if (NO_CMAKE_FIND_ROOT_PATH)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
endif()

find_package (GTest REQUIRED)

if (NO_CMAKE_FIND_ROOT_PATH)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()

include_directories (${GTEST_INCLUDE_DIRS})

add_executable (HelloGTest HelloGTest.cpp)
target_link_libraries (HelloGTest ${GTEST_BOTH_LIBRARIES})
