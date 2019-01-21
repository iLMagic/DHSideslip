//
//  DHDrawerTransitionDelegate.h
//  DHDrawerMenu
//
//  Created by DH on 2018/11/5.
//  Copyright © 2018年 DH. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"

@class DHSideslipInnerConfig;
@interface DHSideslipTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, weak) UIGestureRecognizer *gr;
@property (nonatomic, strong) DHSideslipInnerConfig *config;
- (instancetype)initWithConfig:(DHSideslipInnerConfig *)config;

//- (instancetype)initWithPushPop;
@end


