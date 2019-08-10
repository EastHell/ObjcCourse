//
//  UIColor+Utility.m
//  AnimationsTask
//
//  Created by Aleksandr on 10/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor *)randomColor {
    CGFloat r = (CGFloat)(arc4random_uniform(256)) / 255.f;
    CGFloat g = (CGFloat)(arc4random_uniform(256)) / 255.f;
    CGFloat b = (CGFloat)(arc4random_uniform(256)) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

@end
