APP_PLATFORM := android-16
APP_STL := gnustl_static
APP_CPPFLAGS := -fexceptions -frtti
APP_CPPFLAGS += -std=c++11 -D_LIBCPP_VERSION

NDK_TOOLCHAIN_VERSION := 4.9

APP_ABI := armeabi-v7a
#APP_OPTIM := debug
