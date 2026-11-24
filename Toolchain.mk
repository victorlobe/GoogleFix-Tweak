# Shared by the tweak and GoogleFixPrefs. Include before $(THEOS)/makefiles/common.mk.
#
# Xcode 27's linker emits __picsymbolstub5 stubs without lazy binding; iOS 6's dyld crashes on
# them (EXC_ARM_DA_ALIGN in the image's initializer -> MobileSafari/Settings won't start).
# Link with ld-classic (ships with Xcode <= 26) via a symlink, because Theos can't handle the
# space in "/Applications/Xcode 26.6.app". Override with LD_CLASSIC=/path/to/ld-classic.
GF_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
LD_CLASSIC ?= $(shell ls /Applications/Xcode*.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ld-classic 2>/dev/null | head -1)
LD_CLASSIC_DIR := $(GF_ROOT)/.theos/ld-classic

ifneq ($(LD_CLASSIC),)
$(shell mkdir -p "$(LD_CLASSIC_DIR)" && ln -sfn "$(LD_CLASSIC)" "$(LD_CLASSIC_DIR)/ld")
ADDITIONAL_LDFLAGS += -B$(LD_CLASSIC_DIR)
else
$(warning [⚠️ ] ld-classic not found - the build will crash on iOS 6 if your Xcode's ld emits __picsymbolstub5)
endif
