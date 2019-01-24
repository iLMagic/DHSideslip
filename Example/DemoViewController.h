//
//  DemoViewController.h
//  Example
//
//  Created by DH on 2019/1/23.
//  Copyright © 2019年 DH. All rights reserved.
//

#import "DHViewController.h"
#import "UIViewController+DHSideslip.h"

@class DHSideslipConfig;
@interface DemoViewController : DHViewController


- (instancetype)initWithisRegisterGesture:(BOOL)isGes isHaveNavigationController:(BOOL)isNav presentConfig:(DHSideslipConfigBlockType)presentConfig dismissConfig:(DHSideslipConfigBlockType)dismissConfig;

@end

