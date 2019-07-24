//
//  ViewController.m
//  AnimationsTask
//
//  Created by Aleksandr on 19/07/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<UIView *> *views1;
@property (strong, nonatomic) NSMutableArray<UIView *> *views2;
@property (strong, nonatomic) UIImageView *imView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.views1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * i, 40, 40)];
        view.backgroundColor = [self randomColor];
        [self.view addSubview:view];
        [self.views1 addObject:view];
    }
    
    self.views2 = [[NSMutableArray alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 40) * 0, (CGRectGetHeight(self.view.frame) - 40) * 0, 40, 40)];
    view.backgroundColor = [self randomColor];
    [self.view addSubview:view];
    [self.views2 addObject:view];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 40) * 0, (CGRectGetHeight(self.view.frame) - 40) * 1, 40, 40)];
    view1.backgroundColor = [self randomColor];
    [self.view addSubview:view1];
    [self.views2 addObject:view1];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 40) * 1, (CGRectGetHeight(self.view.frame) - 40) * 1, 40, 40)];
    view2.backgroundColor = [self randomColor];
    [self.view addSubview:view2];
    [self.views2 addObject:view2];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 40) * 1, (CGRectGetHeight(self.view.frame) - 40) * 0, 40, 40)];
    view3.backgroundColor = [self randomColor];
    [self.view addSubview:view3];
    [self.views2 addObject:view3];
    
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

-(UIColor *)randomColor {
    CGFloat r = (CGFloat)(arc4random_uniform(256)) / 255.f;
    CGFloat g = (CGFloat)(arc4random_uniform(256)) / 255.f;
    CGFloat b = (CGFloat)(arc4random_uniform(256)) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
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
                         view.backgroundColor = [self randomColor];
                         
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
    [UIView animateWithDuration:5
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         [self.views1 objectAtIndex:0].center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth([self.views1 objectAtIndex:0].frame) / 2, 20);
                         [self.views1 objectAtIndex:0].backgroundColor = [self randomColor];
    }
                     completion:^(BOOL finished) {}];
    [UIView animateWithDuration:5
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.views1 objectAtIndex:1].center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth([self.views1 objectAtIndex:1].frame) / 2, 60);
                         [self.views1 objectAtIndex:1].backgroundColor = [self randomColor];
    }
                     completion:^(BOOL finished) {}];
    [UIView animateWithDuration:5
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.views1 objectAtIndex:2].center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth([self.views1 objectAtIndex:2].frame) / 2, 100);
                         [self.views1 objectAtIndex:2].backgroundColor = [self randomColor];
    }
                     completion:^(BOOL finished) {}];
    [UIView animateWithDuration:5
                          delay:0
                        options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.views1 objectAtIndex:3].center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth([self.views1 objectAtIndex:3].frame) / 2, 140);
                         [self.views1 objectAtIndex:3].backgroundColor = [self randomColor];
    }
                     completion:^(BOOL finished) {}];
    [self moveViews:self.views2];
    [self moveImageView:self.imView];
}


@end
