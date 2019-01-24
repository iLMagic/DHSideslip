//
//  MenuViewController.m
//  Example
//
//  Created by DH on 2019/1/23.
//  Copyright © 2019年 DH. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+DHSideslip.h"

@interface MenuViewController ()
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, assign) BOOL isGes;
@property (nonatomic, copy) DHSideslipConfigBlockType dismissConfig;
@end

@implementation MenuViewController

- (instancetype)initWithIsRegisterGesture:(BOOL)isGes dismissConfig:(DHSideslipConfigBlockType)dismissConfig {
    if (self = [super init]) {
        _isGes = isGes;
        _dismissConfig = dismissConfig;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"Menu";
    
    if (_isGes) {
        [self dh_sideslipRegisterGestureForDismissWithConfig:_dismissConfig];
    }

    _settingBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
        [btn setTitle:@"设置" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(settingBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });

    _backBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 200, 40)];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });

    
}

- (void)settingBtnDidClick {
    DHViewController *vc = [DHViewController new];
    vc.view.backgroundColor = [UIColor yellowColor];
    vc.title = @"设置";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self dh_sideslipPushViewController:nav];
    
}

- (void)backBtnDidClick {
    [self dh_sideslipDismissViewControllerWithConfig:_dismissConfig];
}

// 解决使用MLeaksFinder检测误判
- (BOOL)willDealloc {
    return NO;
}

@end
