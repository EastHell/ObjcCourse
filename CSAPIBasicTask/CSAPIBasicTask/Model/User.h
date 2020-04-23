//
//  User.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *photoURL;

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName photoURL:(NSURL *)photoURL;

@end

NS_ASSUME_NONNULL_END
