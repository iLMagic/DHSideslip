//
//  DHPresentationController.m
//  DHSideslip
//
//  Created by DH on 2018/11/15.
//  Copyright © 2018年 DH. All rights reserved.
//

#import "DHPresentationController.h"
#import "DHSideslipConfig.h"

@interface DHPresentationController ()
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *finalPresentedView;
@property (nonatomic, strong) DHSideslipInnerConfig *config;
@end

@implementation DHPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController config:(DHSideslipInnerConfig *)config {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        _config = config;
    }
    return self;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGFloat w = self.containerView.bounds.size.width;
    CGFloat h = self.containerView.bounds.size.height;
    
    if (_config.direction == DHSideslipDirectionToLeft) {
        CGFloat x = w - w * _config.scale;
        return CGRectMake(x, 0, w * _config.scale, h);
    } else if (_config.direction == DHSideslipDirectionToRight) {
        return CGRectMake(0, 0, w * _config.scale, h);
    } else if (_config.direction == DHSideslipDirectionToTop) {
        CGFloat y = h - h * _config.scale;
        return CGRectMake(0, y, w, h * _config.scale);
    } else if (_config.direction == DHSideslipDirectionToBottom) {
        return CGRectMake(0, 0, w, h * _config.scale);
    } else {
        NSAssert(NO, @"error");
    }
    return CGRectZero;
}

@end

