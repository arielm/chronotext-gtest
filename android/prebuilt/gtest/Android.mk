LOCAL_PATH := $(call my-dir)/../../../

include $(CLEAR_VARS)
LOCAL_MODULE := gtest
LOCAL_SRC_FILES := lib/android/$(TARGET_ARCH_ABI)/libgtest.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := gtest_main
LOCAL_SRC_FILES := lib/android/$(TARGET_ARCH_ABI)/libgtest_main.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
