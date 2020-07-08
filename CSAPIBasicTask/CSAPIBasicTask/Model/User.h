//
//  User.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 08/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, userSex) {
    userSexNotSpecified = 0,
    userSexFemale,
    userSexMale
};

@interface User : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) BOOL deactivated;
@property (assign, nonatomic) BOOL hidden;
@property (assign, nonatomic) BOOL verified;
@property (assign, nonatomic) BOOL blackListed;
@property (assign, nonatomic) userSex sex;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *homeTown;
@property (strong, nonatomic) NSURL *photo50URL;
@property (strong, nonatomic) NSURL *photo100URL;
@property (strong, nonatomic) NSURL *photo200origURL;
@property (strong, nonatomic) NSURL *photo200URL;
@property (strong, nonatomic) NSURL *photo400origURL;
@property (strong, nonatomic) NSURL *photoMaxURL;
@property (strong, nonatomic) NSURL *photoMaxOrigURL;
@property (assign, nonatomic) BOOL online;
@property (strong, nonatomic) NSString *lists;
@property (strong, nonatomic) NSString *domain;
@property (assign, nonatomic) BOOL hasMobile;
@property (strong, nonatomic) NSString *mobilePhone;
@property (strong, nonatomic) NSString *homePhone;
@property (strong, nonatomic) NSURL *site;
@property (strong, nonatomic) NSString *universityID;
@property (strong, nonatomic) NSString *universityName;

@end

NS_ASSUME_NONNULL_END
