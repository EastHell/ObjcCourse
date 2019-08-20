//
//  DrawingView.m
//  UIViewDrawingsTask
//
//  Created by Aleksandr on 12/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    for (int i = 0; i < 5; i++)
        [self drawStarAt:CGPointMake(50 + arc4random_uniform(CGRectGetMaxX(rect) - 100), 50 + arc4random_uniform(CGRectGetMaxY(rect) - 100))
                    size:50.f];
#pragma mark - imageDrawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 50, 50));
    CGContextAddEllipseInRect(context, CGRectMake(0, 50, 50, 50));
    CGContextAddEllipseInRect(context, CGRectMake(0, 100, 50, 50));
    CGContextFillPath(context);
}

- (void)drawStarAt:(CGPoint)point size:(CGFloat)size {
#pragma mark - starDrawing
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    
    CGPoint center = point;
    const CGFloat STAR_SIZE = size;
    CGFloat angle = ((2.0 * M_PI) / 5.0) * 2.0;
    
    CGContextMoveToPoint(context, center.x, center.y - STAR_SIZE);
    
    for (int i = 1; i < 6; i++)
    {
        CGFloat x = -STAR_SIZE * sin(i * angle);
        CGFloat y = -STAR_SIZE * cos(i * angle);
        CGContextAddLineToPoint(context, x + center.x, y + center.y);
    }
    CGContextFillPath(context);
    
#pragma mark - ellipsesDrawing
    
    angle = ((2.0 * M_PI) / 5.0);
    CGContextMoveToPoint(context, center.x, center.y - STAR_SIZE);
    
    for (int i = 0; i < 5; i++)
    {
        CGFloat x = -STAR_SIZE * sin(i * angle);
        CGFloat y = -STAR_SIZE * cos(i * angle);
        CGContextAddEllipseInRect(context, CGRectMake(x + center.x - size/4, y + center.y - size/4, size/2, size/2));
        CGContextMoveToPoint(context, x + center.x, y + center.y);
    }
    CGContextStrokePath(context);
    
#pragma mark - connectEllipses
    
    CGContextMoveToPoint(context, center.x, center.y - STAR_SIZE);
    
    for (int i = 0; i < 6; i++)
    {
        CGFloat x = -STAR_SIZE * sin(i * angle);
        CGFloat y = -STAR_SIZE * cos(i * angle);
        CGContextAddLineToPoint(context, x + center.x, y + center.y);
    }
    CGContextStrokePath(context);
}


@end
