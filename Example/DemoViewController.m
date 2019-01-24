//
//  DemoViewController.m
//  Example
//
//  Created by DH on 2019/1/23.
//  Copyright © 2019年 DH. All rights reserved.
//

#import "DemoViewController.h"
#import "MenuViewController.h"
#import "DHNavigationViewController.h"

@interface DemoViewController ()
@property (nonatomic, assign) BOOL isNav;
@property (nonatomic, assign) BOOL isGes;
@property (nonatomic, copy) DHSideslipConfigBlockType presentConfig;
@property (nonatomic, copy) DHSideslipConfigBlockType dismissConfig;

@end

@implementation DemoViewController

- (instancetype)initWithisRegisterGesture:(BOOL)isGes isHaveNavigationController:(BOOL)isNav presentConfig:(DHSideslipConfigBlockType)presentConfig dismissConfig:(DHSideslipConfigBlockType)dismissConfig {
    if (self = [super init]) {
        _isGes = isGes;
        _isNav = isNav;
        _presentConfig = presentConfig;
        _dismissConfig = dismissConfig;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weak_self = self;
    if (_isGes) {
        [self dh_sideslipRegisterGestureForPresentWithConfig:_presentConfig     willPresentedViewControllerHandler:^UIViewController *{
            MenuViewController *vc = [[MenuViewController alloc] initWithIsRegisterGesture:YES dismissConfig:weak_self.dismissConfig];
            if (weak_self.isNav) {
                DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:vc];
                return nav;
            } else {
                return vc;
            }
        }];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"sideslip" style:UIBarButtonItemStylePlain target:self action:@selector(leftNavClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backNavClick)];

}

- (void)leftNavClick {
    MenuViewController *vc = [[MenuViewController alloc] initWithIsRegisterGesture:YES dismissConfig:_dismissConfig];
    if (_isNav) {
        DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:vc];
        [self dh_sideslipPresentViewController:nav config:_presentConfig];
    } else {
        [self dh_sideslipPresentViewController:vc config:_presentConfig];
    }
}

- (void)backNavClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
