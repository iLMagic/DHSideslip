//
//  DHPresentationController.h
//  DHSideslip
//
//  Created by DH on 2018/11/15.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"

@class DHSideslipInnerConfig;
@interface DHPresentationController : UIPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController config:(DHSideslipInnerConfig *)config;

@end
