//
//  Friend.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

@interface Friend : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *photoURL;
@property (assign, nonatomic) BOOL canAccessClosed;
@property (assign, nonatomic) BOOL closed;
@property (strong, nonatomic) NSString *trackCode;

+ (Friend *)userWithUserID:(NSString *)userID firstName:(NSString *)firstName lastName:(NSString *)lastName
                photoUrl:(NSURL *)photoURL canAccessClosed:(BOOL)canAccessClosed isClosed:(BOOL)closed
               trackCode:(NSString *)trackCode;

@end

NS_ASSUME_NONNULL_END
