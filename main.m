#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import "MenuViewController.h"

static MenuViewController *menuVC = nil;
static UIWindow *menuWindow = nil;

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        window.windowLevel = UIWindowLevelAlert + 1;
        window.backgroundColor = [UIColor clearColor];
        window.rootViewController = [MenuViewController shared];
        window.hidden = NO;
        menuWindow = window;
    });
}

__attribute__((visibility("default")))
void toggleMenu() {
    if (menuVC) {
        [menuVC toggleMenuVisibility];
    }
}
