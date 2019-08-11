//
//  ViewController.m
//  AnimationsTask
//
//  Created by Aleksandr on 19/07/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Utility.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<UIView *> *views1;
@property (strong, nonatomic) NSMutableArray<UIView *> *fourSquareViews;
@property (strong, nonatomic) UIImageView *imView;

@end

@implementation ViewController

typedef enum {
    CornerPositionTopLeft,
    CornerPositionTopRight,
    CornerPositionBottomRight,
    CornerPositionBottomLeft
} CornerPosition;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.views1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                (40 * i) + CGRectGetMidY(self.view.bounds),
                                                                40,
                                                                40)];
        view.backgroundColor = [UIColor randomColor];
        [self.view addSubview:view];
        [self.views1 addObject:view];
    }
    
    NSMutableArray *fourSquares = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [self createViewWith:i];
        [self.view addSubview:view];
        [fourSquares addObject:view];
    }
    
    self.fourSquareViews = [fourSquares copy];
    
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imView.backgroundColor = [UIColor clearColor];
    
    UIImage *image1 = [UIImage imageNamed:@"1.png"];
    UIImage *image2 = [UIImage imageNamed:@"2.png"];
    UIImage *image3 = [UIImage imageNamed:@"3.png"];
    NSArray *images = [NSArray arrayWithObjects:image1, image2, image1, image3, nil];
    
    imView.animationImages = images;
    imView.animationDuration = 1.f;
    [imView startAnimating];
    [self.view addSubview:imView];
    self.imView = imView;
}

- (UIView *)createViewWith:(CornerPosition)position {
    CGPoint point;
    CGFloat size = 40.f;
    
    switch (position) {
        case CornerPositionTopLeft:
            point = CGPointMake(0, 0);
            break;
        case CornerPositionTopRight:
            point = CGPointMake(CGRectGetWidth(self.view.frame) - size, 0);
            break;
        case CornerPositionBottomLeft:
            point = CGPointMake(0, CGRectGetHeight(self.view.frame) - size);
            break;
        case CornerPositionBottomRight:
            point = CGPointMake(CGRectGetWidth(self.view.frame) - size,
                                CGRectGetHeight(self.view.frame) - size);
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(point.x,
                                                            point.y,
                                                            size,
                                                            size)];
    view.backgroundColor = [UIColor randomColor];
    return view;
}

- (void)moveViews:(NSMutableArray<UIView *> *)views {
    int direction = arc4random_uniform(2) - 1;
    [UIView animateWithDuration:6
                          delay:0
                        options:0
                     animations:^{
                         if (direction == 0) {
                             CGPoint tempPoint = [views objectAtIndex:0].center;
                             UIColor *tempColor = [views objectAtIndex:0].backgroundColor;
                             for (int i = 0; i < 3; i++) {
                                 [views objectAtIndex:i].center = [views objectAtIndex:i + 1].center;
                                 [views objectAtIndex:i].backgroundColor = [views objectAtIndex:i + 1].backgroundColor;
                             }
                             [views objectAtIndex:3].center = tempPoint;
                             [views objectAtIndex:3].backgroundColor = tempColor;
                         } else {
                             CGPoint tempPoint = [views objectAtIndex:3].center;
                             UIColor *tempColor = [views objectAtIndex:3].backgroundColor;
                             for (int i = 3; i > 0; i--) {
                                 [views objectAtIndex:i].center = [views objectAtIndex:i - 1].center;
                                 [views objectAtIndex:i].backgroundColor = [views objectAtIndex:i - 1].backgroundColor;
                             }
                             [views objectAtIndex:0].center = tempPoint;
                             [views objectAtIndex:0].backgroundColor = tempColor;
                         }
                         
                     }
                     completion:^(BOOL finished) {
                          __weak NSMutableArray<UIView *> *v = views;
                          [self moveViews:v];
                          
                      }];
}

- (void)moveImageView:(UIImageView *)view {
    CGRect rect = self.view.bounds;
    
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    
    CGFloat x = arc4random_uniform((int)CGRectGetWidth(rect) + CGRectGetMinX(rect));
    CGFloat y = arc4random_uniform((int)CGRectGetHeight(rect) + CGRectGetMinY(rect));
    
    CGFloat s = (float)arc4random_uniform(151) / 100.f + 0.5f;
    
    CGFloat r = (double)arc4random_uniform((int)(M_PI * 2 * 10000)) / 10000 - M_PI;
    
    CGFloat d = (float)arc4random_uniform(20001) / 10000 + 2;
    
    [UIView animateWithDuration:d
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.center = CGPointMake(x, y);
                         view.backgroundColor = [UIColor randomColor];
                         
                         CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
                         
                         CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                         
                         view.transform = transform;
                         
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation finished! %d", finished);
                         NSLog(@"view frame = %@ \r view bounds = %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
                         
                         __weak UIImageView *v = view;
                         [self moveImageView:v];
                     }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (int i = 0; i < self.views1.count; i++) {
        [self animateView:self.views1[i] withOptions:[self optionsForIndex:i]];
    }
    
    [self moveViews:self.fourSquareViews];
    [self moveImageView:self.imView];
}

- (UIViewAnimationOptions)optionsForIndex:(NSInteger)index {
    switch (index) {
        case 1:
            return UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
        case 2:
            return UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |
            UIViewAnimationOptionCurveEaseIn;
        case 3:
            return UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |
            UIViewAnimationOptionCurveEaseOut;
        default:
            return UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |
            UIViewAnimationOptionCurveLinear;
            break;
    }
}

- (void)animateView:(UIView *)view withOptions:(UIViewAnimationOptions)options {
    [UIView animateWithDuration:5
                          delay:0
                        options:options
                     animations:^{
                         view.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(view.frame) / 2,
                                                   view.frame.origin.y);
                     } completion:nil];
}

@end
