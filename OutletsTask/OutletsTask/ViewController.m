//
//  ViewController.m
//  OutletsTask
//
//  Created by Aleksandr on 27/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Utility.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat fieldSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fieldSize = MIN(self.view.bounds.size.height, self.view.bounds.size.width) / 8.f;
    
    [self.fieldViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setFrame:CGRectMake([self xPositionForIndex:idx],
                                 [self yPositionForIndex:idx],
                                 self.fieldSize,
                                 self.fieldSize)];
    }];
    
    [self.redChessViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setFrame:CGRectMake((0.2f * self.fieldSize) + [self xPositionForIndex:idx],
                                 (0.2f * self.fieldSize) + [self yPositionForIndex:idx],
                                 0.6f * self.fieldSize,
                                 0.6f * self.fieldSize)];
    }];
    
    [self.whiteChessViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        idx = idx + 20;
        [obj setFrame:CGRectMake((0.2f * self.fieldSize) + [self xPositionForIndex:idx],
                                 (0.2f * self.fieldSize) + [self yPositionForIndex:idx],
                                 0.6f * self.fieldSize,
                                 0.6f * self.fieldSize)];
    }];
}

- (CGFloat)xPositionForIndex:(NSUInteger)index {
    return (index / 4) % 2 * self.fieldSize + (index % 4) * self.fieldSize * 2;
}

- (CGFloat)yPositionForIndex:(NSUInteger)index {
    const CGFloat ROWS_COUNT = 8;
    const CGFloat Y_START_POSITION = (self.view.bounds.size.height - self.fieldSize * ROWS_COUNT) / 2;
    
    return Y_START_POSITION + (index / 4) * self.fieldSize;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:
(id<UIViewControllerTransitionCoordinator>)coordinator {
    UIColor *color = [UIColor randomColor];
    
    [self.fieldViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = color;
    }];
}


@end
