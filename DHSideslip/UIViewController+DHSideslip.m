//
//  UIViewController+DHSideslip.m
//  DHDrawerMenu
//
//  Created by DH on 2018/11/23.
//  Copyright © 2018年 DH. All rights reserved.
//



#import "UIViewController+DHSideslip.h"
#import <objc/runtime.h>
#import "DHSideslipTransitionDelegate.h"
#import "UIGestureRecognizer+DHSideslip.h"


NSString * const dh_sideslipTransitionDelegateKey = @"dh_sideslipTransitionDelegateKey";

@interface UIViewController ()
@end

@implementation UIViewController (DHSideslip)

- (void)dh_sideslipRegisterGestureForPresentWithConfig:(DHSideslipConfigBlockType)config willPresentedViewControllerHandler:(DHSideslipControllerBlockType)handler {
    
    DHSideslipInnerConfig *presentConfig = [DHSideslipInnerConfig defaultPresentConfig];
    if (config) {
        config(presentConfig);
    }
    
    // 注册手势
    UIGestureRecognizer *gr = [self dh_sideslipCreateGR:presentConfig];
    gr.dh_presentVCHandler = handler;
    gr.dh_config = presentConfig;
    [self.view addGestureRecognizer:gr];
    
}

- (void)dh_sideslipPresentViewController:(UIViewController *)viewController config:(DHSideslipConfigBlockType)config {

    DHSideslipInnerConfig *presentConfig = [DHSideslipInnerConfig defaultPresentConfig];
    if (config) {
        config(presentConfig);
    }
    [self dh_innerSideslipPresentWithConfig:presentConfig gr:nil presentedVC:viewController];
}


- (void)dh_sideslipRegisterGestureForDismissWithConfig:(DHSideslipConfigBlockType)config {
    // 首先保证这个view一定是被present出来的
//    NSAssert(self.presentingViewController, @"This view controller is not presented");
    DHSideslipInnerConfig *dismissConfig = [DHSideslipInnerConfig defaultDismissConfig];
    if (config) {
        config(dismissConfig);
    }

    // 注册手势
    UIGestureRecognizer *gr = [self dh_sideslipCreateGR:dismissConfig];
    gr.dh_config = dismissConfig;
    [self.view addGestureRecognizer:gr];
}

- (void)dh_sideslipDismissViewControllerWithConfig:(DHSideslipConfigBlockType)config {
    // 首先保证这个view一定是被present出来的
    NSAssert(self.presentingViewController, @"This view controller is not presented");
    DHSideslipInnerConfig *dismissConfig = [DHSideslipInnerConfig defaultDismissConfig];
    if (config) {
        config(dismissConfig);
    }
    
    [self dh_innerSideslipDismissWithConfig:dismissConfig gr:nil];
}

#pragma mark - push
- (void)dh_sideslipPushViewController:(UIViewController *)viewController {
//    __weak
    dispatch_async(dispatch_get_main_queue(), ^{
        DHSideslipInnerConfig *popConfig = [DHSideslipInnerConfig defaultPop];
        // 注册手势
        UIViewController *vc;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (id)viewController;
            vc = nav.childViewControllers[0];
        } else {
            vc = viewController;
        }
        UIGestureRecognizer *gr = [vc dh_sideslipCreateGR:popConfig];
        gr.dh_config = popConfig;
        [vc.view addGestureRecognizer:gr];
    });
    
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig defaultPush];
    [self dh_innerSideslipPresentWithConfig:config gr:nil presentedVC:viewController];
}

#pragma mark - pop
- (void)dh_sideslipPopViewController {
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig defaultPop];

    [self dh_innerSideslipDismissWithConfig:config gr:nil];
}

- (void)dh_sideslipScreenPanGREvent:(UIPanGestureRecognizer *)gr {
    DHSideslipInnerConfig *config = gr.dh_config;
    if (gr.state == UIGestureRecognizerStateBegan) {
        if (config.isPresent) {
            // 创建控制器
            UIViewController *presentedVC = gr.dh_presentVCHandler();
            [self dh_innerSideslipPresentWithConfig:config gr:gr presentedVC:presentedVC];
        } else {
            [self dh_innerSideslipDismissWithConfig:config gr:gr];
        }
    }
}

- (void)dh_sideslipPanGREvent:(UIPanGestureRecognizer *)gr {

    DHSideslipInnerConfig *config = gr.dh_config;
    CGPoint velocity = [gr velocityInView:self.view];
    if (gr.state == UIGestureRecognizerStateBegan) {
        // 判断手势方向
        CGFloat absX = fabs(velocity.x);
        CGFloat absY = fabs(velocity.y);
        DHSideslipDirection currentDirection;
        if (absX > absY) {
            if (velocity.x > 0) {
                currentDirection = DHSideslipDirectionToRight;
            } else {
                currentDirection = DHSideslipDirectionToLeft;
            }
        } else {
            if (velocity.y > 0) {
                currentDirection = DHSideslipDirectionToBottom;
            } else {
                currentDirection = DHSideslipDirectionToTop;
            }
        }
        
        if (config.direction == currentDirection) {
            if (config.isPresent) {
                // 创建控制器
                UIViewController *presentedVC = gr.dh_presentVCHandler();
                [self dh_innerSideslipPresentWithConfig:config gr:gr presentedVC:presentedVC];
            } else {
                [self dh_innerSideslipDismissWithConfig:gr.dh_config gr:gr];
            }
        }
    }
    
}

- (UIGestureRecognizer *)dh_sideslipCreateGR:(DHSideslipInnerConfig *)config {
    if (config.gestureType == DHSideslipGestureTypePan) {
        UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dh_sideslipPanGREvent:)];
        return gr;
    } else if (config.gestureType == DHSideslipGestureTypeScreenEdgesPan) {
        UIScreenEdgePanGestureRecognizer *gr = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(dh_sideslipScreenPanGREvent:)];
        if (config.direction == DHSideslipDirectionToRight) {
            gr.edges = UIRectEdgeLeft;
        } else if (config.direction == DHSideslipDirectionToLeft) {
            gr.edges = UIRectEdgeRight;
        } else if (config.direction == DHSideslipDirectionToBottom) {
            gr.edges = UIRectEdgeTop;
        } else if (config.direction == DHSideslipDirectionToTop) {
            gr.edges = UIRectEdgeBottom;
        } else {
            NSAssert(NO, @"error");
        }
        return gr;
    } else {
        NSAssert(NO, @"The argument is not legal.");
        return nil;
    }
}



- (void)addMaskViewGRNoti {
    __weak typeof(self) weak_self = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:DHSideslipMaskViewPanGRNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DHSideslipInnerConfig *config = note.userInfo[@"config"];
        UIGestureRecognizer *gr = note.userInfo[@"gr"];
        [weak_self dh_innerSideslipDismissWithConfig:config gr:gr];
    }];
}



/**
 内部dismiss方法，点击事件，手势事件都调用

 @param config config
 @param gr gr
 */
- (void)dh_innerSideslipDismissWithConfig:(DHSideslipInnerConfig *)config gr:(UIGestureRecognizer *)gr {
    DHSideslipTransitionDelegate *delegate;
    // 有未被dismiss的vc
    if (self.transitioningDelegate) {
        if ([self.transitioningDelegate isKindOfClass:[DHSideslipTransitionDelegate class]]) {
            delegate = self.transitioningDelegate;
        } else {
            NSAssert(NO, @"The viewContoller is not by dh_present");
        }
    } else {
        if (self.navigationController.transitioningDelegate) {
            delegate = self.navigationController.transitioningDelegate;
        } else {
            NSAssert(NO, @"The viewContoller is not by dh_present");
        }
    }
    delegate.config = config;
    delegate.gr = gr;
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 内部present方法，点击事件，手势事件都调用

 @param config config
 @param gr gr
 @param vc vc
 */
- (void)dh_innerSideslipPresentWithConfig:(DHSideslipInnerConfig *)config gr:(UIGestureRecognizer *)gr presentedVC:(UIViewController *)vc {
    
    NSAssert(config, @"config not allow nil");
    NSAssert(vc, @"presentedVC not allow nil");
    
    [vc addMaskViewGRNoti];

//    if (!gr) {
//        config.direction = config.direction;
//    }
    DHSideslipTransitionDelegate *delegate = [[DHSideslipTransitionDelegate alloc] initWithConfig:config];
    // 强应用delegate.
    vc.dh_sideslipTransitionDelegate = delegate;
    delegate.gr = gr;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = delegate;
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - getter.setter

- (void)setDh_sideslipTransitionDelegate:(DHSideslipTransitionDelegate *)dh_sideslipTransitionDelegate {
    
    objc_setAssociatedObject(self, &dh_sideslipTransitionDelegate, dh_sideslipTransitionDelegate, OBJC_ASSOCIATION_RETAIN);
}

- (DHSideslipTransitionDelegate *)dh_sideslipTransitionDelegate {
    id object = objc_getAssociatedObject(self, &dh_sideslipTranstionDelegateKey);
    return object;
}
@end
