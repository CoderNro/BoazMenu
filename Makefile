export THEOS = /opt/theos
export ARCHS = arm64 arm64e
export TARGET = iphone:latest:11.0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = DMT139z
$(TOOL_NAME)_FILES = main.m MenuViewController.m Features/NoRecoil.m Features/Wallhack.m Features/ESP.m Features/Aimbot.m
$(TOOL_NAME)_CFLAGS = -fobjc-arc -I./Features -I./
$(TOOL_NAME)_FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore OpenGLES
$(TOOL_NAME)_INSTALL_PATH = /usr/lib

include $(THEOS_MAKE_PATH)/tool.mk

after-package::
	@echo "Package created successfully!"
	@find . -name "*.dylib" -exec cp {} ./ \;
