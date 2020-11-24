//
//  UIView+MKAnnotationView.h
//  MapKitTask
//
//  Created by Aleksandr on 07/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotationView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MKAnnotationView)

- (MKAnnotationView *)rootAnnotationView;

@end

NS_ASSUME_NONNULL_END
