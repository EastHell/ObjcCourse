//
//  Student.h
//  TableViewSearch
//
//  Created by Aleksandr on 25/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *secondName;
@property (strong, nonatomic) NSDate *birthday;

- (instancetype)initWithName:(NSString *)name secondName:(NSString *)secondName birthday:(NSDate *)birthday;

@end

NS_ASSUME_NONNULL_END
