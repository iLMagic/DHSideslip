//
//  DHSideslipConst.h
//  DHDrawerMenu
//
//  Created by DH on 2018/12/3.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHSideslipConfig;

typedef void(^DHSideslipConfigBlockType)(DHSideslipConfig *config);


typedef UIViewController *(^DHSideslipControllerBlockType)(void);

/**
 侧滑方向
 
 - DHSideslipDirectionToRight: 由左向右
 - DHSideslipDirectionToLeft: 由右向左
 - DHSideslipDirectionToBottom: 由上到下
 - DHSideslipDirectionToTop: 由下到上
 */
typedef NS_ENUM(NSInteger, DHSideslipDirection) {
    DHSideslipDirectionNone = 0,
    DHSideslipDirectionToRight,
    DHSideslipDirectionToLeft,
    DHSideslipDirectionToBottom,
    DHSideslipDirectionToTop
};

/**
 手势类型

 - DHSideslipGestureTypeUnknown: 未知
 - DHSideslipGestureTypePan: 滑动
 - DHSideslipGestureTypeScreenEdgesPan: 屏幕边缘滑动
 */
typedef NS_ENUM(NSInteger, DHSideslipGestureType) {
    DHSideslipGestureTypeUnknown,
    DHSideslipGestureTypePan,
    DHSideslipGestureTypeScreenEdgesPan,
};


UIKIT_EXTERN NSString * const DHSideslipMaskViewPanGRNotificationName;
