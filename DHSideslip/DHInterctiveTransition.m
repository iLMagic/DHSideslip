//
//  DHInterctiveTransition.m
//  DHDrawerMenu
//
//  Created by DH on 2018/11/5.
//  Copyright © 2018年 DH. All rights reserved.
//

/*
 不管是present还是dismiss.
 在这个地方只需要关注到手势从开始到结束的偏移量
 */

#import "DHInterctiveTransition.h"
#import "DHSideslipConfig.h"

@interface DHInterctiveTransition ()
// 保存手势
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, weak) UIGestureRecognizer *gr;
@property (nonatomic, weak) DHSideslipInnerConfig *config;

@property (nonatomic, assign) CGPoint beginPoint;
@end

@implementation DHInterctiveTransition

- (instancetype)initWithGR:(UIGestureRecognizer *)gr config:(DHSideslipInnerConfig *)config {
    if (self = [super init]) {
        if (!config) {
            NSAssert(NO, @"config is not allow nil.");
        }
        
        if (!gr) {
            NSAssert(NO, @"gr is not allow nil.");
        }
  
        _config = config;
        _gr = gr;
        [_gr addTarget:self action:@selector(grEvent:)];
//         began事件消息传递
        [self grEvent:gr];
    }
    return self;
}


- (void)grEvent:(UIGestureRecognizer *)gr {
    
    CGPoint point = [gr locationInView:_transitionContext.containerView];
//    NSLog(@"当前x坐标为：%f", point.x);
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        _beginPoint = point;
        NSLog(@"起始点：%f", point.x);
    } else if (gr.state == UIGestureRecognizerStateChanged) {
        CGFloat percent = [self calculatePercentWithCurrentPoint:point];
        [self updateInteractiveTransition:percent];
        NSLog(@"比例：%f", percent);
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        CGFloat percent = [self calculatePercentWithCurrentPoint:point];
        if (percent > 0.5) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
    } else {
        CGFloat percent = [self calculatePercentWithCurrentPoint:point];
        if (percent > 0.5) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
    }
}

#pragma mark - UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext]; 
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [_gr removeTarget:self action:@selector(grEvent:)];
}

- (CGFloat)calculatePercentWithCurrentPoint:(CGPoint)point {

    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGSize size = CGSizeZero;
    
    if (_config.isPresent) {
        size = [_transitionContext finalFrameForViewController:toVC].size;
    } else {
        size = [_transitionContext initialFrameForViewController:fromVC].size;
    }

    CGFloat offset, percent = .0f;
    if (_config.direction == DHSideslipDirectionToRight) {
        offset = point.x - _beginPoint.x;
        percent = offset / size.width;
    } else if (_config.direction == DHSideslipDirectionToLeft) {
        offset  = _beginPoint.x - point.x;
        percent = offset / size.width;
    } else if (_config.direction == DHSideslipDirectionToTop) {
        offset = _beginPoint.y - point.y;
        percent = offset / size.height;
    } else if (_config.direction == DHSideslipDirectionToBottom) {
        offset = point.y -_beginPoint.y;
        percent = offset / size.height;
    } else {
        NSAssert(NO, @"argument error");
    }
    return percent;
}


@end
