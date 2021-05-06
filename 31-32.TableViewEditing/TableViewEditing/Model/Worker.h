//
//  Worker.h
//  TableViewEditing
//
//  Created by Aleksandr on 14/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Worker : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger salary;

- (instancetype)initWithName:(NSString *)name Salary:(NSInteger)salary;

@end

NS_ASSUME_NONNULL_END
