if (NOT DEFINED IOS_ARCHS)
  set(IOS_ARCHS "armv7;arm64")
endif()

if (NOT DEFINED IOS_DEPLOYMENT_TARGET)
  set(IOS_DEPLOYMENT_TARGET 7.0)
endif()

# ---

set (CMAKE_OSX_SYSROOT iphoneos
  CACHE STRING "cmake_osx_sysroot/ios"
)

set (CMAKE_OSX_ARCHITECTURES
  "${IOS_ARCHS}"
  CACHE STRING "cmake_osx_architectures/ios"
)

set (CMAKE_CXX_FLAGS
  "-miphoneos-version-min=${IOS_DEPLOYMENT_TARGET} -stdlib=libc++"
  CACHE STRING "cmake_cxx_flags/ios"
)
