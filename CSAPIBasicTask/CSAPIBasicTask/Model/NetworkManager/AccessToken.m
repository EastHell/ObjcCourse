//
//  AccessToken.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "AccessToken.h"
#import "KeyChainStorage.h"

@interface AccessToken () <NSSecureCoding>

@property (readwrite) NSString *token;

@end

@implementation AccessToken

+ (instancetype)currentAcessToken {
    KeyChainStorage *storage = [KeyChainStorage keychainStorageWithTag:@"CSAPIBasicTask.keys.access_token"];
    return [NSKeyedUnarchiver unarchivedObjectOfClass:[AccessToken class]
                                             fromData:[storage keychainFindItemWithErrorPtr:nil] error:nil];
}

+ (void)addToken:(NSString *)token {
    KeyChainStorage *storage = [KeyChainStorage keychainStorageWithTag:@"CSAPIBasicTask.keys.access_token"];
    AccessToken *accessToken = [AccessToken new];
    accessToken.token = token;
    [storage keychainDeleteItemWithErrorPtr:nil];
    [storage
     keychainAddItem:[NSKeyedArchiver archivedDataWithRootObject:accessToken requiringSecureCoding:YES error:nil]
     errorPtr:nil];
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.token forKey:@"token_key"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.token = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"token_key"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
