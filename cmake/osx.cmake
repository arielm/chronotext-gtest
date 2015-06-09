if (NOT DEFINED OSX_ARCHS)
  set(OSX_ARCHS "x86_64")
endif()

if (NOT DEFINED OSX_DEPLOYMENT_TARGET)
  set(OSX_DEPLOYMENT_TARGET 10.7)
endif()

# ---

set (CMAKE_OSX_ARCHITECTURES
  ${OSX_ARCHS}
  CACHE STRING "cmake_osx_architectures/osx"
)

set (CMAKE_CXX_FLAGS
  "-mmacosx-version-min=${OSX_DEPLOYMENT_TARGET} -stdlib=libc++"
  CACHE STRING "cmake_cxx_flags/osx"
)
