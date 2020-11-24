//
//  ASAnimal.h
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASAnimal : NSObject

@property (assign, nonatomic) NSInteger nubersOfLegs;
@property (assign, nonatomic) NSInteger movingSpeed;

- (void) move;

@end

NS_ASSUME_NONNULL_END
