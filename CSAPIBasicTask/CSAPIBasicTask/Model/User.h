//
//  User.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

@interface User : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *photoURL;
@property (weak, nonatomic) UIImage *photo;
@property (assign, nonatomic) BOOL canAccessClosed;
@property (assign, nonatomic) BOOL closed;
@property (strong, nonatomic) NSString *trackCode;

+ (User *)userWithUserID:(NSString *)userID firstName:(NSString *)firstName lastName:(NSString *)lastName
                photoUrl:(NSString *)photoURL canAccessClosed:(BOOL)canAccessClosed isClosed:(BOOL)closed
               trackCode:(NSString *)trackCode;

@end

NS_ASSUME_NONNULL_END
