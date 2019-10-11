//
//  UIColor+Utility.m
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor *)randomColor {
    CGFloat r = (float)(arc4random_uniform(256)) / 255;
    CGFloat g = (float)(arc4random_uniform(256)) / 255;
    CGFloat b = (float)(arc4random_uniform(256)) / 255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

@end
