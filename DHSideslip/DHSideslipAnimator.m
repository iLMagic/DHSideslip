//
//  DHDrawerAnimator.m
//  DHSideslip
//
//  Created by DH on 2018/11/1.
//  Copyright © 2018年 DH. All rights reserved.
//

#import "DHSideslipAnimator.h"
#import "DHSideslipConfig.h"
#import "UIViewController+DHSideslip.h"
#import "UIGestureRecognizer+DHSideslip.h"

@interface DHSideslipAnimator ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGR;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
@end

@implementation DHSideslipAnimator

- (instancetype)initWithConfig:(DHSideslipInnerConfig *)config {
    if (self = [super init]) {
        _config = config;
        
        if (_config.needMaskView) {
            _maskView = ({
                UIView *view = [UIView new];
                view.backgroundColor = [UIColor blackColor];
                view;
            });
        }
        
        _tapGR = ({
            UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap:)];
            gr.dh_config = [self convertConfig];
            gr;
        });
        _panGR = ({
            UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewPan:)];
            gr.dh_config = [self convertConfig];
            gr;
        });

        if (_config.allowMaskViewPan) {
            [_maskView addGestureRecognizer:_panGR];
        }
        if (_config.allowMaskViewTap) {
            [_maskView addGestureRecognizer:_tapGR];
        }

    }
    return self;
}

- (void)maskViewTap:(UITapGestureRecognizer *)gr {
    NSDictionary *dict = @{@"config" : gr.dh_config};
    [[NSNotificationCenter defaultCenter] postNotificationName:DHSideslipMaskViewTapGRNotificationName object:nil userInfo:dict];
}

- (void)maskViewPan:(UIPanGestureRecognizer *)gr {
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        DHSideslipDirection tempDirection;
        CGPoint velocity = [gr velocityInView:_maskView];
        // 判断手势方向
        CGFloat absX = fabs(velocity.x);
        CGFloat absY = fabs(velocity.y);
        if (absX > absY) {
            if (velocity.x > 0) {
                tempDirection = DHSideslipDirectionToRight;
            } else {
                tempDirection = DHSideslipDirectionToLeft;
            }
        } else {
            if (velocity.y > 0) {
                tempDirection = DHSideslipDirectionToBottom;
            } else {
                tempDirection = DHSideslipDirectionToTop;
            }
        }
        if (tempDirection == gr.dh_config.direction) {
            NSDictionary *dict = @{@"config" : gr.dh_config,
                                   @"gr" : gr};
            [[NSNotificationCenter defaultCenter] postNotificationName:DHSideslipMaskViewPanGRNotificationName object:nil userInfo:dict];
        }
    }
}

- (DHSideslipInnerConfig *)convertConfig {
    DHSideslipInnerConfig *newConfig = [DHSideslipInnerConfig defaultDismissConfig];
    if (_config.direction == DHSideslipDirectionToRight) {
        newConfig.direction = DHSideslipDirectionToLeft;
    } else if (_config.direction == DHSideslipDirectionToLeft) {
        newConfig.direction = DHSideslipDirectionToRight;
    } else if (_config.direction == DHSideslipDirectionToBottom) {
        newConfig.direction = DHSideslipDirectionToTop;
    } else if (_config.direction == DHSideslipDirectionToTop) {
        newConfig.direction = DHSideslipDirectionToBottom;
    } else {
        NSAssert(NO, @"error");
    }
    return newConfig;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _config.duration;
}

// // 在present的时候，dismiss的时候都会调用这个方法
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (!fromView) {
        fromView = fromVC.view;
    }
    if (!toView) {
        toView = toVC.view;
    }
    UIView *containerView = transitionContext.containerView;
//    containerView.backgroundColor = [UIColor clearColor];
    
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
//    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromVC];
    CGRect fromViewInitFrame = [transitionContext initialFrameForViewController:fromVC];
    
    if (_config.isPresent) {
        // 获取toView的宽度，高度。
        CGFloat w = toViewFinalFrame.size.width;
        CGFloat h = toViewFinalFrame.size.height;
        // 计算初始view的frame
        CGFloat x = 0; CGFloat y = 0;
        if (_config.direction == DHSideslipDirectionToRight) {
            x = CGRectGetMinX(fromViewInitFrame) - w;
        } else if (_config.direction == DHSideslipDirectionToLeft) {
            x = CGRectGetMaxX(fromViewInitFrame);
        } else if (_config.direction == DHSideslipDirectionToBottom) {
            y = CGRectGetMinY(fromViewInitFrame) - h;
        } else if (_config.direction == DHSideslipDirectionToTop) {
            y = CGRectGetMaxY(fromViewInitFrame);
        } else {
            NSAssert(NO, @"error");
        }
        toView.frame = CGRectMake(x, y, w, h);
        
        _maskView.frame = containerView.bounds;
        _maskView.alpha = 0.0f;
        // 先加入maskView
        [containerView addSubview:_maskView];
        // toView最后加入，在最上层
        [containerView addSubview:toView];
    } else {
        
    }
    
    [UIView animateWithDuration:_config.duration animations:^{
        if (self.config.isPresent) {
            toView.frame = toViewFinalFrame;
            self.maskView.alpha = self.config.maskViewAlpha;
            if (self.config.isPushPop) {
                CGFloat offset = -CGRectGetWidth(fromView.frame) * 0.5;
                fromView.frame = CGRectOffset(fromView.frame, offset, 0);
            }
        } else {
            CGFloat w = fromViewInitFrame.size.width;
            CGFloat h = fromViewInitFrame.size.height;
            CGFloat x = fromViewInitFrame.origin.x, y = fromViewInitFrame.origin.y;
            // 计算初始view的最终的frame
            if (self.config.direction == DHSideslipDirectionToRight) {
                x = CGRectGetMaxX(toViewFinalFrame);
            } else if (self.config.direction == DHSideslipDirectionToLeft) {
                x = CGRectGetMinX(toViewFinalFrame) - w;
            } else if (self.config.direction == DHSideslipDirectionToBottom) {
                y = CGRectGetMaxY(toViewFinalFrame);
            } else if (self.config.direction == DHSideslipDirectionToTop) {
                y = CGRectGetMinY(toViewFinalFrame) - h;
            } else {
                NSAssert(NO, @"error");
            }
            fromView.frame = CGRectMake(x, y, w, h);
            if (self.config.isPushPop) {
                CGFloat offset = CGRectGetWidth(toView.frame) * 0.5;
                toView.frame = CGRectOffset(toView.frame, offset, 0);
                NSLog(@"%@", NSStringFromCGRect(toView.frame));
            }

        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        if (self.config.isPresent && wasCancelled) {
            [self.maskView removeFromSuperview];
        }
        if (!self.config.isPresent && !wasCancelled) {
            [self.maskView removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end

