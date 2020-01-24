//
//  Student.h
//  MapKitTask
//
//  Created by Aleksandr on 05/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Extensions/NSString+Utility.h"

NS_ASSUME_NONNULL_BEGIN


//Сделать композицию
@interface Student : NSObject <MKAnnotation>

typedef NS_ENUM(NSInteger, StudentSex) {
    StudentSexMale = 0,
    StudentSexFemale
};

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *secondName;
@property (assign, nonatomic) StudentSex sex;
@property (strong, nonatomic) NSDate *birthDate;

- (NSString *)getSexStringRepresentation;
- (NSString *)getYearOfBirthStringRepresentation;

#pragma mark - MKAnnotation

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
