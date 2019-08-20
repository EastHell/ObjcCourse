//
//  PaintingView.m
//  UIViewDrawingsTask
//
//  Created by Aleksandr on 17/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "PaintingView.h"

@interface PaintingView ()

@property (strong, nonatomic) NSMutableArray *lines;

@end

@implementation PaintingView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];
    CGPoint point = [touch locationInView:self];
    if (self.lines == nil){
        self.lines = [NSMutableArray array];
    }
    NSMutableArray *line = [NSMutableArray arrayWithObject:[NSValue valueWithCGPoint:point]];
    [self.lines addObject:line];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];
    CGPoint point = [touch locationInView:self];
    
    [[self.lines lastObject] addObject:[NSValue valueWithCGPoint:point]];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    
    for (NSMutableArray *line in self.lines) {
        NSLog(@"1");
        for (int i = 0; i < line.count; i++) {
            CGPoint point = [[line objectAtIndex:i] CGPointValue];
            NSLog(@"%@", NSStringFromCGPoint(point));
            if (i == 0) {
                CGContextMoveToPoint(context, point.x, point.y);
            }
            else {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
    }
    
    CGContextStrokePath(context);
}


@end
