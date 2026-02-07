# ReVanced Prebuilt Apps
LOCAL_PATH := $(call my-dir)

# Stock Nekogram
include $(CLEAR_VARS)
LOCAL_MODULE        := Nekogram
LOCAL_SRC_FILES     := product/app/Nekogram/tw.nekomimi.nekogram.apk
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(TARGET_OUT_PRODUCT)/app/Nekogram
LOCAL_INSTALLED_MODULE_STEM := tw.nekomimi.nekogram.apk
LOCAL_PRODUCT_MODULE := true
include $(BUILD_PREBUILT)

# Copy Nekogram native libs
include $(CLEAR_VARS)
LOCAL_MODULE := Nekogram_libdir
LOCAL_MODULE_CLASS := ETC
LOCAL_PRODUCT_MODULE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/app/Nekogram/lib
LOCAL_PREBUILT_MODULE_FILE := $(LOCAL_PATH)/product/app/Nekogram/lib/placeholder.txt
LOCAL_POST_INSTALL_CMD := \
    mkdir -p $(LOCAL_MODULE_PATH); \
    cp -rf $(LOCAL_PATH)/product/app/Nekogram/lib/* $(LOCAL_MODULE_PATH)/
include $(BUILD_PREBUILT)
