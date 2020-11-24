//
//  ViewController.m
//  GesturesTask
//
//  Created by Aleksandr on 01/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIImageView *imView;

@property (assign, nonatomic) CGFloat imViewScale;
@property (assign, nonatomic) CGFloat imViewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    imView.backgroundColor = [UIColor clearColor];
    imView.center = self.view.center;
    imView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    imView.image = [UIImage imageNamed:@"sman.jpg"];
    
    [self.view addSubview:imView];
    self.imView = imView;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *rightSwipeRecognizer =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    
    UISwipeGestureRecognizer *leftSwipeRecognizer =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeRecognizer];
    
    UITapGestureRecognizer *doubleTapDoubleTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleDoubleTapDoubleTouch:)];
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    UIPinchGestureRecognizer *pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotationGesture];
}

#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer *)tapGesture {
    [UIImageView animateWithDuration:2
                          animations:^{
                              self.imView.center = [tapGesture locationInView:self.view];
                          }];
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)swipeGesture {
    for (int i = 0; i < 4; i++) {
        CGAffineTransform currentTransform = self.imView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2);
        [UIImageView animateWithDuration:1
                                   delay:0
                                 options:0
                              animations:^{
                                  self.imView.transform = newTransform;
                              } completion:^(BOOL finished) {
                              }];
    }
}

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)swipeGesture {
    for (int i = 0; i < 4; i++) {
        CGAffineTransform currentTransform = self.imView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2);
        [UIImageView animateWithDuration:1
                                   delay:0
                                 options:0
                              animations:^{
                                  self.imView.transform = newTransform;
                              } completion:^(BOOL finished) {
                              }];
    }
}

- (void)handleDoubleTapDoubleTouch:(UITapGestureRecognizer *)tapGesture {
    [self.imView.layer removeAllAnimations];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGesture {
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.imViewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.imViewScale;
    
    CGAffineTransform currentTransform = self.imView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.imView.transform = newTransform;
    
    self.imViewScale = pinchGesture.scale;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)rotationGesture {
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.imViewRotation = 0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.imViewRotation;
    
    CGAffineTransform currentTransform = self.imView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.imView.transform = newTransform;
    
    self.imViewRotation = rotationGesture.rotation;
}

@end
