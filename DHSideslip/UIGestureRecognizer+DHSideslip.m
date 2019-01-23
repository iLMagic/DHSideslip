//
//  UIGestureRecognizer+DHSideslip.m
//  DHSideslip
//
//  Created by DH on 2018/11/29.
//  Copyright © 2018年 DH. All rights reserved.
//

#import "UIGestureRecognizer+DHSideslip.h"
#import <objc/runtime.h>

NSString * const dh_presentVCHandlerKey = @"dh_presentVCHandlerKey";
NSString * const dh_configKey = @"dh_configKey";
NSString * const dh_sideslipTranstionDelegateKey = @"dh_sideslipTranstionDelegateKey";


@implementation UIGestureRecognizer (DHSideslip)
- (void)setDh_config:(DHSideslipInnerConfig *)dh_config {
    objc_setAssociatedObject(self, &dh_configKey, dh_config, OBJC_ASSOCIATION_RETAIN);
}

- (DHSideslipInnerConfig *)dh_config {
    id object = objc_getAssociatedObject(self, &dh_configKey);
    return object;
}

- (void)setDh_presentVCHandler:(DHSideslipControllerBlockType)dh_presentVCHandler {
    
    objc_setAssociatedObject(self, &dh_presentVCHandlerKey, dh_presentVCHandler, OBJC_ASSOCIATION_COPY);
}

- (DHSideslipControllerBlockType)dh_presentVCHandler {
    id object = objc_getAssociatedObject(self, &dh_presentVCHandlerKey);
    return object;
}

- (void)setDh_sideslipTranstionDelegate:(DHSideslipTransitionDelegate *)dh_sideslipTranstionDelegate {
    objc_setAssociatedObject(self, &dh_sideslipTranstionDelegateKey, dh_sideslipTranstionDelegate, OBJC_ASSOCIATION_RETAIN);
}

- (DHSideslipTransitionDelegate *)dh_sideslipTranstionDelegate {
    id object = objc_getAssociatedObject(self, &dh_sideslipTranstionDelegateKey);
    return object;
}

@end
