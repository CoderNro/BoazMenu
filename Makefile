TARGET = DMT139z.dylib
ARCHS = arm64 arm64e
DEBUG = 0
FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore OpenGLES
CFLAGS = -fobjc-arc -fmodules -fPIC

include $(THEOS)/makefiles/common.mk

TOOL_NAME = DMT139z
$(TOOL_NAME)_FILES = main.m MenuViewController.m Features/NoRecoil.m Features/Wallhack.m Features/ESP.m Features/Aimbot.m
$(TOOL_NAME)_CFLAGS = -fobjc-arc -I./Features
$(TOOL_NAME)_FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore OpenGLES
$(TOOL_NAME)_INSTALL_PATH = /usr/lib

include $(THEOS_MAKE_PATH)/tool.mk

after-install::
	install.exec "killall -9 FreeFire"
