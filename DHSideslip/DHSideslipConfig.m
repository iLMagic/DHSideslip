//
//  DHSideslipConfig.m
//  DHSideslip
//
//  Created by DH on 2018/11/23.
//  Copyright © 2018年 DH. All rights reserved.
//

#import "DHSideslipConfig.h"

@implementation DHSideslipConfig

@end

@implementation DHSideslipInnerConfig


+ (instancetype)defaltWithIsPresent:(BOOL)isPresent {
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig new];
    [config setValue:@(isPresent) forKey:@"isPresent"];
    config.maskViewAlpha = 0.3f;
    config.allowMaskViewTap = NO;
    config.allowMaskViewPan = YES;
    config.needMaskView = YES;
    config.scale = 0.7f;
    config.duration = 0.3f;
    return config;
}

+ (instancetype)defaultPresentConfig {
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig defaltWithIsPresent:YES];
    config.direction = DHSideslipDirectionToRight;
    config.gestureType = DHSideslipGestureTypeScreenEdgesPan;
    return config;
}

+ (instancetype)defaultDismissConfig {
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig defaltWithIsPresent:NO];
    config.gestureType = DHSideslipGestureTypePan;
    config.direction = DHSideslipDirectionToLeft;
    return config;
}

+ (instancetype)defaultPush {
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig defaltWithIsPresent:YES];
    [config setValue:@(YES) forKey:@"isPushPop"];
    config.needMaskView = NO;
    config.scale = 1.0f;
    config.direction = DHSideslipDirectionToLeft;
//    config.gestureType = DHSideslipGestureTypeScreenEdgesPan;
    return config;
}

+ (instancetype)defaultPop {
    DHSideslipInnerConfig *config = [DHSideslipInnerConfig defaltWithIsPresent:NO];
    [config setValue:@(YES) forKey:@"isPushPop"];
    config.needMaskView = NO;
    config.direction = DHSideslipDirectionToRight;
    config.gestureType = DHSideslipGestureTypeScreenEdgesPan;
    return config;

}
@end
