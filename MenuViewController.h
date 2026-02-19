#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
+ (instancetype)shared;
- (void)toggleMenuVisibility;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *menuPanel;
@property (nonatomic, assign) BOOL isMenuVisible;
@property (nonatomic, assign) CGPoint lastLocation;
@end
