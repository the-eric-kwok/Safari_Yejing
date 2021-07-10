TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Safari_Yejing

Safari_Yejing_FILES = Tweak.x
Safari_Yejing_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
