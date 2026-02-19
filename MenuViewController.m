#import "MenuViewController.h"
#import "Features/NoRecoil.h"
#import "Features/Wallhack.h"
#import "Features/ESP.h"
#import "Features/Aimbot.h"

@interface MenuViewController ()
@property (nonatomic, strong) UISwitch *noRecoilSwitch;
@property (nonatomic, strong) UISwitch *wallhackSwitch;
@property (nonatomic, strong) UISwitch *espSwitch;
@property (nonatomic, strong) UISwitch *aimbotSwitch;
@property (nonatomic, strong) UISlider *espRadiusSlider;
@property (nonatomic, strong) UILabel *versionLabel;
@end

@implementation MenuViewController

static MenuViewController *sharedInstance = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MenuViewController alloc] init];
    });
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(0, 0, 50, 50);
    
    // Icon menu
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.iconImageView.image = [UIImage imageNamed:@"icon.png"];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.userInteractionEnabled = YES;
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped)];
    [self.iconImageView addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(iconDragged:)];
    [self.iconImageView addGestureRecognizer:pan];
    
    [self.view addSubview:self.iconImageView];
    
    // Menu panel
    self.menuPanel = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 280, 320)];
    self.menuPanel.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.95];
    self.menuPanel.layer.cornerRadius = 15;
    self.menuPanel.layer.borderColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1].CGColor;
    self.menuPanel.layer.borderWidth = 1;
    self.menuPanel.hidden = YES;
    
    // Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 280, 30)];
    titleLabel.text = @"DMT139z Version 1.0";
    titleLabel.textColor = [UIColor colorWithRed:0 green:0.8 blue:1 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.menuPanel addSubview:titleLabel];
    
    // No Recoil (Đạn thẳng)
    UILabel *noRecoilLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 150, 30)];
    noRecoilLabel.text = @"Đạn thẳng";
    noRecoilLabel.textColor = [UIColor whiteColor];
    [self.menuPanel addSubview:noRecoilLabel];
    
    self.noRecoilSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 50, 51, 31)];
    [self.noRecoilSwitch addTarget:self action:@selector(noRecoilToggled:) forControlEvents:UIControlEventValueChanged];
    [self.menuPanel addSubview:self.noRecoilSwitch];
    
    // Wallhack
    UILabel *wallhackLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 150, 30)];
    wallhackLabel.text = @"Xuyên tường";
    wallhackLabel.textColor = [UIColor whiteColor];
    [self.menuPanel addSubview:wallhackLabel];
    
    self.wallhackSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 90, 51, 31)];
    [self.wallhackSwitch addTarget:self action:@selector(wallhackToggled:) forControlEvents:UIControlEventValueChanged];
    [self.menuPanel addSubview:self.wallhackSwitch];
    
    // ESP
    UILabel *espLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 150, 30)];
    espLabel.text = @"ESP Radar";
    espLabel.textColor = [UIColor whiteColor];
    [self.menuPanel addSubview:espLabel];
    
    self.espSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 130, 51, 31)];
    [self.espSwitch addTarget:self action:@selector(espToggled:) forControlEvents:UIControlEventValueChanged];
    [self.menuPanel addSubview:self.espSwitch];
    
    // ESP Radius
    UILabel *radiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 150, 30)];
    radiusLabel.text = @"Bán kính radar";
    radiusLabel.textColor = [UIColor whiteColor];
    radiusLabel.font = [UIFont systemFontOfSize:12];
    [self.menuPanel addSubview:radiusLabel];
    
    self.espRadiusSlider = [[UISlider alloc] initWithFrame:CGRectMake(15, 200, 250, 30)];
    self.espRadiusSlider.minimumValue = 50;
    self.espRadiusSlider.maximumValue = 300;
    self.espRadiusSlider.value = 150;
    [self.espRadiusSlider addTarget:self action:@selector(espRadiusChanged:) forControlEvents:UIControlEventValueChanged];
    [self.menuPanel addSubview:self.espRadiusSlider];
    
    // Aimbot
    UILabel *aimbotLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 240, 150, 30)];
    aimbotLabel.text = @"Aimbot 100%";
    aimbotLabel.textColor = [UIColor whiteColor];
    [self.menuPanel addSubview:aimbotLabel];
    
    self.aimbotSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 240, 51, 31)];
    [self.aimbotSwitch addTarget:self action:@selector(aimbotToggled:) forControlEvents:UIControlEventValueChanged];
    [self.menuPanel addSubview:self.aimbotSwitch];
    
    // Version
    self.versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 285, 280, 20)];
    self.versionLabel.text = @"DMT139z v1.0";
    self.versionLabel.textColor = [UIColor grayColor];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.font = [UIFont systemFontOfSize:10];
    [self.menuPanel addSubview:self.versionLabel];
    
    [self.view addSubview:self.menuPanel];
}

- (void)iconTapped {
    [self toggleMenuVisibility];
}

- (void)toggleMenuVisibility {
    self.isMenuVisible = !self.isMenuVisible;
    self.menuPanel.hidden = !self.isMenuVisible;
}

- (void)iconDragged:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:self.view];
    pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:self.view];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.lastLocation = pan.view.center;
        self.menuPanel.frame = CGRectMake(60, self.lastLocation.y - 160, 280, 320);
    }
}

- (void)noRecoilToggled:(UISwitch *)sender {
    [NoRecoil setEnabled:sender.isOn];
}

- (void)wallhackToggled:(UISwitch *)sender {
    [Wallhack setEnabled:sender.isOn];
}

- (void)espToggled:(UISwitch *)sender {
    [ESP setEnabled:sender.isOn];
    [ESP setRadius:self.espRadiusSlider.value];
}

- (void)espRadiusChanged:(UISlider *)sender {
    [ESP setRadius:sender.value];
}

- (void)aimbotToggled:(UISwitch *)sender {
    [Aimbot setEnabled:sender.isOn];
}

@end
