//
//  ASStudent.h
//  MultithreadingTask
//
//  Created by Aleksandr on 01/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASStudent : NSObject

@property (strong, nonatomic) NSString *name;

- (instancetype)initWithName:(NSString *)name;
- (void)guessAnswerWithValue:(NSInteger)intValue min:(NSInteger)min max:(NSInteger)max completion:(dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
