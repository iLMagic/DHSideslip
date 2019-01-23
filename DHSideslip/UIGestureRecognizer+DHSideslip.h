//
//  UIGestureRecognizer+DHSideslip.h
//  DHSideslip
//
//  Created by DH on 2018/11/29.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"


UIKIT_EXTERN NSString * const dh_presentVCHandlerKey;
UIKIT_EXTERN NSString * const dh_configKey;
UIKIT_EXTERN NSString * const dh_sideslipTranstionDelegateKey; 

@class DHSideslipInnerConfig, DHSideslipTransitionDelegate;

@interface UIGestureRecognizer (DHSideslip)
@property (nonatomic, copy) DHSideslipControllerBlockType dh_presentVCHandler;
@property (nonatomic, copy) DHSideslipInnerConfig *dh_config;
@end
