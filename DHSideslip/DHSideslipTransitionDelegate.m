//
//  DHDrawerTransitionDelegate.m
//  DHDrawerMenu
//
//  Created by DH on 2018/11/5.
//  Copyright © 2018年 DH. All rights reserved.
//

#import "DHSideslipTransitionDelegate.h"
#import "DHSideslipAnimator.h"
#import "DHInterctiveTransition.h"
#import "DHPresentationController.h"
#import "DHSideslipConfig.h"
//#import "DHSideslipPushPopAnimator.h"

@interface DHSideslipTransitionDelegate ()
@property (nonatomic, strong) DHSideslipAnimator *animator;
@property (nonatomic, assign) BOOL isPushPop;

@end

@implementation DHSideslipTransitionDelegate

- (instancetype)initWithConfig:(DHSideslipInnerConfig *)config {
    if (self = [super init]) {
        _config = config;
        _animator = [[DHSideslipAnimator alloc] initWithConfig:_config];
    }
    return self;
}

//- (instancetype)initWithPushPop {
//    if (self = [super init]) {
//        _isPushPop = YES;
//    }
//    return self;
//}

- (void)setConfig:(DHSideslipInnerConfig *)config {
    _config = config;
    _animator.config = config;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
        return _animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
        return _animator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
        if (_gr) {
            DHInterctiveTransition *transition = [[DHInterctiveTransition alloc] initWithGR:_gr config:_config];
            return transition;
        } else {
            return nil;
        }
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
        if (_gr) {
            DHInterctiveTransition *transition = [[DHInterctiveTransition alloc] initWithGR:_gr config:_config];
            return transition;
        } else {
            return nil;
        }
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[DHPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting config:_config];
}



- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
