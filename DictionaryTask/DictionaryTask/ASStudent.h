//
//  ASStudent.h
//  DictionaryTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *greeting;

- (NSString *)fullName;

@end

NS_ASSUME_NONNULL_END
