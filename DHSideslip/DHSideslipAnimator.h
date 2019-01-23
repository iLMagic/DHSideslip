//
//  DHDrawerAnimator.h
//  DHSideslip
//
//  Created by DH on 2018/11/1.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"


@class DHSideslipInnerConfig;
@interface DHSideslipAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) DHSideslipInnerConfig *config;
//- (instancetype)initWithIsPresent:(BOOL)isPresent NS_DESIGNATED_INITIALIZER;

//@property (nonatomic, weak) UIScreenEdgePanGestureRecognizer *panGR;

//- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithConfig:(DHSideslipInnerConfig *)config;

@end

