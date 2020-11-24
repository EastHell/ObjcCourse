//
//  Student.h
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *secondName;
@property (assign, nonatomic) NSInteger average;

- (instancetype)initWithName:(NSString *)name SecondName:(NSString *)secondName Average:(NSInteger)average;

@end

NS_ASSUME_NONNULL_END
