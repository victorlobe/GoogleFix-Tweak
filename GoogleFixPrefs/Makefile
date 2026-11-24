ARCHS = armv7 arm64
TARGET := iphone:7.1

include ../Toolchain.mk
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = GoogleFixPrefs

GoogleFixPrefs_FILES = GFRootListController.m
GoogleFixPrefs_FRAMEWORKS = UIKit
GoogleFixPrefs_PRIVATE_FRAMEWORKS = Preferences
GoogleFixPrefs_INSTALL_PATH = /Library/PreferenceBundles
GoogleFixPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
