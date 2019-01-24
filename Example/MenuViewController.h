//
//  MenuViewController.h
//  Example
//
//  Created by DH on 2019/1/23.
//  Copyright © 2019年 DH. All rights reserved.
//

#import "DHViewController.h"
#import "UIViewController+DHSideslip.h"

@interface MenuViewController : DHViewController

- (instancetype)initWithIsRegisterGesture:(BOOL)isGes dismissConfig:(DHSideslipConfigBlockType)dismissConfig;

@end

