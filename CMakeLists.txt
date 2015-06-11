cmake_minimum_required (VERSION 3.2.2)

include(ExternalProject)

ExternalProject_Add (gtest
  URL "https://github.com/arielm/googletest/archive/patches.zip"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND "${CMAKE_COMMAND}" -E create_symlink "${PROJECT_SOURCE_DIR}/build/gtest-prefix/src/gtest/include" "${PROJECT_SOURCE_DIR}/include"
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
