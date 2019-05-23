//
//  ViewController.m
//  OutletsTask
//
//  Created by Aleksandr on 27/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat fieldSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fieldSize = MIN(self.view.bounds.size.height, self.view.bounds.size.width) / 8.f;
    
    [self.fieldViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setFrame:CGRectMake((idx / 4) % 2 * self.fieldSize + (idx % 4) * self.fieldSize * 2, (self.view.bounds.size.height - self.fieldSize * 8) / 2 + (idx / 4) * self.fieldSize, self.fieldSize, self.fieldSize)];
    }];
    
    [self.redChessViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setFrame:CGRectMake((0.2f * self.fieldSize) + (idx / 4) % 2 * self.fieldSize + (idx % 4) * self.fieldSize * 2, (0.2f * self.fieldSize) + (self.view.bounds.size.height - self.fieldSize * 8) / 2 + (idx / 4) * self.fieldSize, 0.6f * self.fieldSize, 0.6f * self.fieldSize)];
    }];
    
    [self.whiteChessViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        idx = idx + 20;
        [obj setFrame:CGRectMake((0.2f * self.fieldSize) + (idx / 4) % 2 * self.fieldSize + (idx % 4) * self.fieldSize * 2, (0.2f * self.fieldSize) + (self.view.bounds.size.height - self.fieldSize * 8) / 2 + (idx / 4) * self.fieldSize, 0.6f * self.fieldSize, 0.6f * self.fieldSize)];
    }];
}

-(CGFloat)randomFromZeroToOne {
    return (float)(arc4random_uniform(256)) / 255;
}

-(UIColor *)randomColor {
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UIColor *color = [self randomColor];
    [self.fieldViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = color;
//        CGRect frame = obj.frame;
//        if (size.height > size.width) {
//            frame.origin.x = frame.origin.x - (self.view.bounds.size.height - self.fieldSize * 8) / 2;
//            frame.origin.y = frame.origin.y + (self.view.bounds.size.height - self.fieldSize * 8) / 2;
//        } else {
//            frame.origin.x = frame.origin.x + (self.view.bounds.size.width - self.fieldSize * 8) / 2;
//            frame.origin.y = frame.origin.y - (self.view.bounds.size.width - self.fieldSize * 8) / 2;
//        }
//        [obj setFrame:frame];
    }];
}


@end
