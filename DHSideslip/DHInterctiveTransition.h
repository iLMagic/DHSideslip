//
//  DHInterctiveTransition.h
//  DHDrawerMenu
//
//  Created by DH on 2018/11/5.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"

@class DHSideslipInnerConfig;
@interface DHInterctiveTransition : UIPercentDrivenInteractiveTransition


/**
 初始化方法

 @param gr gr
 @param config config，direction只接收一个值
 @return vc
 */
- (instancetype)initWithGR:(UIGestureRecognizer *)gr config:(DHSideslipInnerConfig *)config;

//- (instancetype)initWithGR:(UIGestureRecognizer *)gr modalType:(DHModalType)type NS_DESIGNATED_INITIALIZER;
//
//- (instancetype)init NS_UNAVAILABLE;

@end

