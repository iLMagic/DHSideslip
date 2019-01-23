//
//  DHSideslipConfig.h
//  DHSideslip
//
//  Created by DH on 2018/11/23.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"


/**
 接收外部参数
 */
@interface DHSideslipConfig : NSObject
/**
 弹出视图对比原来视图的比例.默认值：0.7
 */
@property (nonatomic, assign) CGFloat scale;

/**
 动画执行时间，默认值0.3
 */
@property (nonatomic, assign) CGFloat duration;

/**
 弹出方向，默认从左向右
 */
@property (nonatomic, assign) DHSideslipDirection direction;

/**
 手势类型，默认Pan
 */
@property (nonatomic, assign) DHSideslipGestureType gestureType;

/**
 是否允许MaskView的点击事件，默认NO
 */
@property (nonatomic, assign) BOOL allowMaskViewTap;

/**
 是否允许MaskView的滑动事件,默认YES
 */
@property (nonatomic, assign) BOOL allowMaskViewPan;

/**
 maskView的最小透明度0.3
 */
@property (nonatomic, assign) CGFloat maskViewAlpha;

/**
 是否需要添加maskView， 默认为YES
 */
@property (nonatomic, assign) BOOL needMaskView;
@end


/**
 内部使用
 */
@interface DHSideslipInnerConfig : DHSideslipConfig
/**
 是否是present，
 */
@property (nonatomic, assign, readonly) BOOL isPresent;

/**
 是否为侧滑菜单中的push pop
 */
@property (nonatomic, assign, readonly) BOOL isPushPop;

+ (instancetype)defaultPresentConfig;
+ (instancetype)defaultDismissConfig;

+ (instancetype)defaultPush;
+ (instancetype)defaultPop;
@end
