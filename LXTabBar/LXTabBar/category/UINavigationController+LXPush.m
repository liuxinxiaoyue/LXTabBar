//
//  UINavigationController+LXPush.m
//  LXTabBarCode
//
//  Created by admin on 2018/7/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UINavigationController+LXPush.h"

@implementation UINavigationController (LXPush)

- (void)xb_pushViewController:(UIViewController *)controller animated:(BOOL)animation {
    if (controller.tabBarController == nil || controller.tabBarController.tabBar.isHidden) {
        [self pushViewController:controller animated:animation];
        return
    }
    if (self.viewControllers.count == 1) {
        controller.hidesBottomBarWhenPushed = true;
    }
    [self pushViewController:controller animated:animation];
}
@end
