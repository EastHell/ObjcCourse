//
//  User.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName photoURL:(NSURL *)photoURL
{
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _photoURL = photoURL;
    }
    return self;
}

@end
