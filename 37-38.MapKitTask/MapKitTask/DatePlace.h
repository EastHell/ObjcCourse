//
//  DatePlace.h
//  MapKitTask
//
//  Created by Aleksandr on 09/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePlace : NSObject <MKAnnotation>

#pragma mark - MKAnnotation

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
