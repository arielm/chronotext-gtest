set (
  OSX_ARCHS
  "x86_64"
  CACHE STRING "osx_archs"
)

set (
  OSX_DEPLOYMENT_TARGET
  10.7
  CACHE STRING "osx_deployment_target"
)

# ---

set (CMAKE_OSX_ARCHITECTURES
  ${OSX_ARCHS}
  CACHE STRING "cmake_osx_architectures/osx"
)

set (CMAKE_CXX_FLAGS
  "-mmacosx-version-min=${OSX_DEPLOYMENT_TARGET} -stdlib=libc++"
  CACHE STRING "cmake_cxx_flags/osx"
)
