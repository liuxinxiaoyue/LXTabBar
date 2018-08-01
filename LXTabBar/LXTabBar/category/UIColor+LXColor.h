//
//  UIColor+LXColor.h
//  LXRefreshDemo
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LXColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;
@end
