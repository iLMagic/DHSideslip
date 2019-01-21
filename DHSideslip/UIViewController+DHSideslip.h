//
//  UIViewController+DHSideslip.h
//  DHDrawerMenu
//
//  Created by DH on 2018/11/23.
//  Copyright © 2018年 DH. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DHSideslipConst.h"
#import "DHSideslipConfig.h"

UIKIT_EXTERN NSString * const dh_sideslipTransitionDelegateKey;
//UIKIT_EXTERN NSString * const dismissConfigHandlerKey;
//UIKIT_EXTERN NSString * const presentConfigHandlerKey;
//UIKIT_EXTERN NSString * const sideslipTranstionDelegateKey;

//typedef UIViewController *(^DHSideslipControllerBlockType)(void);
@class DHSideslipTransitionDelegate;
@interface UIViewController (DHSideslip)
// 为了强引用transitionDelegate.到presentedVC，生命周期同presentedVC.
@property (nonatomic, strong) DHSideslipTransitionDelegate *dh_sideslipTransitionDelegate;


/**
 present手势注册

 @param config config 配置
 @param handler handler
 */
- (void)dh_sideslipRegisterGestureForPresentWithConfig:(DHSideslipConfigBlockType)config willPresentedViewControllerHandler:(DHSideslipControllerBlockType)handler;

/**
 立即present出vc

 @param viewController 即将被present的控制器
 @param config config 自定义弹出方式
 */
- (void)dh_sideslipPresentViewController:(UIViewController *)viewController config:(DHSideslipConfigBlockType)config;


/**
 dismiss手势注册

 @param config config
 */
- (void)dh_sideslipRegisterGestureForDismissWithConfig:(DHSideslipConfigBlockType)config;


/**
 dismiss

 @param config config
 */
- (void)dh_sideslipDismissViewControllerWithConfig:(DHSideslipConfigBlockType)config;


- (void)dh_sideslipPushViewController:(UIViewController *)viewController;

- (void)dh_sideslipPopViewController;
@end


