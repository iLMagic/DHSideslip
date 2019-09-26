//
//  ViewController.m
//  Example
//
//  Created by DH on 2019/1/23.
//  Copyright © 2019年 DH. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+DHSideslip.h"
#import "DemoViewController.h"
#import "DHNavigationViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"向右滑动弹出(pan)",
                    @"向左滑动弹出(screen edges pan)",
                    @"action sheet弹出方式",
                    @"prsent弹出(仿push动画，带返回手势)",
                    ];
}

#pragma mark - tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"demo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            DemoViewController *vc = [[DemoViewController alloc] initWithisRegisterGesture:YES isHaveNavigationController:YES presentConfig:^(DHSideslipConfig *config) {
                config.gestureType = DHSideslipGestureTypePan;
                config.scale = 0.6;
                config.allowMaskViewTap = NO;
                config.allowMaskViewPan = YES;
            } dismissConfig:^(DHSideslipConfig *config) {
                config.direction = DHSideslipDirectionToLeft;
            }];
            DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:nav animated:YES completion:nil];
            
        } break;

        case 1: {
            DemoViewController *vc = [[DemoViewController alloc] initWithisRegisterGesture:YES isHaveNavigationController:YES presentConfig:^(DHSideslipConfig *config) {
                config.gestureType = DHSideslipGestureTypeScreenEdgesPan;
                config.direction = DHSideslipDirectionToLeft;
                config.scale = 0.6;
                config.allowMaskViewTap = NO;
                config.allowMaskViewPan = NO;
            } dismissConfig:^(DHSideslipConfig *config) {
                config.gestureType = DHSideslipGestureTypePan;
                config.direction = DHSideslipDirectionToRight;
            }];
            DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        } break;
            
        case 2: {
            DHViewController *vc = [DHViewController new];
            vc.view.backgroundColor = [UIColor redColor];
            [self dh_sideslipPresentViewController:vc config:^(DHSideslipConfig *config) {
                config.direction = DHSideslipDirectionToTop;
                config.scale = 0.4;
                config.maskViewAlpha = 0.5;
                config.allowMaskViewPan = NO;
                config.allowMaskViewTap = YES;
                config.duration = 0.25;
            }];
            // dismiss 同理
        } break;
        case 3: {
            DHViewController *vc = [DHViewController new];
            vc.view.backgroundColor = [UIColor redColor];
            DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:vc];
            [self dh_sideslipPushViewController:nav];
        } break;

        default:
            break;
    }
}
@end
