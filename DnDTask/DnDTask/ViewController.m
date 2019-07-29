//
//  ViewController.m
//  DnDTask
//
//  Created by Aleksandr on 27/07/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *draggingView;

@property (assign, nonatomic) CGPoint touchOffset;

@property (assign, nonatomic) CGPoint startingPoint;

@property (strong, nonatomic) NSMutableArray *freePoints;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    const CGFloat FIELD_SIDE_SIZE = MIN(CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame));
    
    [self makeChessFieldAtPoint:CGPointMake((CGRectGetWidth(self.view.frame) - FIELD_SIDE_SIZE) / 2,
                                            (CGRectGetHeight(self.view.frame) - FIELD_SIDE_SIZE) / 2)
                       WithSize:FIELD_SIDE_SIZE];
    
}

#pragma mark - Private Methods

- (void)makeChessFieldAtPoint:(CGPoint)point WithSize:(CGFloat)size {
    
    const CGFloat SQUARE_SIDE_SIZE = size / 8.f;
    self.freePoints = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 32; i++) {
        CGFloat x = SQUARE_SIDE_SIZE * 2 * (i % 4) + SQUARE_SIDE_SIZE * (((i / 4) + 1) % 2);
        CGFloat y = SQUARE_SIDE_SIZE * (i / 4);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(point.x + x,
                                                                point.y + y,
                                                                SQUARE_SIDE_SIZE,
                                                                SQUARE_SIDE_SIZE)];
        
        [view setBackgroundColor:UIColor.blackColor];
        [self.view addSubview:view];
        [self.freePoints addObject:[NSValue valueWithCGPoint:view.center]];
    }
    
    for (int i = 0; i < 12; i++) {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SQUARE_SIDE_SIZE * 0.6,
                                                                   SQUARE_SIDE_SIZE * 0.6)];
        redView.center = [self.freePoints[i] CGPointValue];
        [redView setBackgroundColor:UIColor.redColor];
        [self.view addSubview:redView];
    }
    
    for (int i = 20; i < 32; i++) {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SQUARE_SIDE_SIZE * 0.6,
                                                                   SQUARE_SIDE_SIZE * 0.6)];
        redView.center = [self.freePoints[i] CGPointValue];
        [redView setBackgroundColor:UIColor.whiteColor];
        [self.view addSubview:redView];
    }
    
    [self.freePoints removeObjectsInRange:NSMakeRange(20, 12)];
    [self.freePoints removeObjectsInRange:NSMakeRange(0, 12)];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint pointOnMainView = [touch locationInView:self.view];
    
    UIView* view = [self.view hitTest:pointOnMainView withEvent:event];
    
    if (view.backgroundColor != UIColor.blackColor && ![view isEqual:self.view]) {
        self.draggingView = view;
        self.startingPoint = self.draggingView.center;
        [self.freePoints addObject:[NSValue valueWithCGPoint:self.startingPoint]];
        
        [self.view bringSubviewToFront:self.draggingView];
        
        CGPoint touchPoint = [touch locationInView:self.draggingView];
        
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             self.draggingView.alpha = 0.3f;
                         }];
    } else {
        self.draggingView = nil;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.draggingView) {
        
        UITouch* touch = [touches anyObject];
        
        CGPoint pointOnMainView = [touch locationInView:self.view];
        
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                         pointOnMainView.y + self.touchOffset.y);
        
        self.draggingView.center = correction;
    }
}

- (void) onTouchesEndedAtPoint:(CGPoint)point {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingView.transform = CGAffineTransformIdentity;
                         self.draggingView.alpha = 1.f;
                         self.draggingView.center = point;
                     }];
    
    self.draggingView = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    int nearestPointIndex = 0;
    CGPoint nearestPoint = [self.freePoints[nearestPointIndex] CGPointValue];
    CGFloat shortestRange = sqrt(pow(nearestPoint.x - self.draggingView.center.x, 2.f) +
                                 pow(nearestPoint.y - self.draggingView.center.y, 2.f));
    for (int i = 1; i < self.freePoints.count; i++) {
        CGPoint currentPoint = [self.freePoints[i] CGPointValue];
        CGFloat currentRange = sqrt(pow(currentPoint.x - self.draggingView.center.x, 2.f) +
                                   pow(currentPoint.y - self.draggingView.center.y, 2.f));
        if (currentRange < shortestRange) {
            shortestRange = currentRange;
            nearestPoint = currentPoint;
            nearestPointIndex = i;
        }
    }
    
    [self onTouchesEndedAtPoint:nearestPoint];
    [self.freePoints removeObjectAtIndex:nearestPointIndex];
}

@end
