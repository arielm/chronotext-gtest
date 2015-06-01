ifndef GTEST_PATH
  $(error GTEST_PATH MUST BE DEFINED!)
endif

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES := ../
LOCAL_SRC_FILES := ../hello_gtest.cpp
LOCAL_STATIC_LIBRARIES := gtest gtest_main

LOCAL_MODULE := hello_gtest
include $(BUILD_EXECUTABLE)

$(call import-add-path, $(GTEST_PATH)/android/prebuilt)
$(call import-module, gtest)
