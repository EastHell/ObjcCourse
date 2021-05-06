//
//  UIView+MKAnnotationView.m
//  MapKitTask
//
//  Created by Aleksandr on 07/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "UIView+MKAnnotationView.h"

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *)rootAnnotationView {
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView *)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview rootAnnotationView];
}

@end
