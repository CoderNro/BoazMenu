export THEOS = /opt/theos
export ARCHS = arm64 arm64e
export TARGET = iphone:latest:11.0
export DEBUG = 0
export FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DMT139z
$(TWEAK_NAME)_FILES = main.m MenuViewController.m $(wildcard Features/*.m)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -I./Features -I./
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore OpenGLES
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = BackBoardServices

include $(THEOS_MAKE_PATH)/tweak.mk

after-package::
	@echo "✅ Build hoàn tất!"
	@find $(THEOS_STAGING_DIR) -name "*.dylib" -type f
	@echo "📦 Package được tạo trong thư mục packages/"
