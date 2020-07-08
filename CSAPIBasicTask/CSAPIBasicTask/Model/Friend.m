//
//  Friend.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Friend.h"
#import <UIKit/UIKit.h>

@implementation Friend

+ (Friend *)userWithUserID:(NSString *)userID
               firstName:(NSString *)firstName
                lastName:(NSString *)lastName
                photoUrl:(NSURL *)photoURL
         canAccessClosed:(BOOL)canAccessClosed
                isClosed:(BOOL)closed
               trackCode:(NSString *)trackCode {
    
    Friend *newUser = [[Friend alloc] init];
    newUser.userID = userID;
    newUser.firstName = firstName;
    newUser.lastName = lastName;
    newUser.photoURL = photoURL;
    newUser.canAccessClosed = canAccessClosed;
    newUser.closed = closed;
    newUser.trackCode = trackCode;
    return newUser;
}

@end
