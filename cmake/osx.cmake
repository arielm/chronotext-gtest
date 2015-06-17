
set(OSX_ARCHS
  x86_64
  CACHE STRING "osx_archs"
)

set(OSX_DEPLOYMENT_TARGET 10.7
  CACHE STRING "osx_deployment_target"
)

# ---

set(CMAKE_OSX_ARCHITECTURES ${OSX_ARCHS})
set(CMAKE_CXX_FLAGS "-mmacosx-version-min=${OSX_DEPLOYMENT_TARGET} -stdlib=libc++ -std=c++11")

# ---

set(CMAKE_LIBRARY_ARCHITECTURE osx)

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL "CMAKE_TRY_COMPILE")
    configure_file(cmake/run.osx.sh.in run)
  endif()
endif()
