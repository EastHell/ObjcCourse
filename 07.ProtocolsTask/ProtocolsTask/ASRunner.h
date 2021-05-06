//
//  ASRunner.h
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASHuman.h"
#import "ASRunners.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASRunner : ASHuman <ASRunners>

@property (assign, nonatomic) NSInteger speed;
@property (assign, nonatomic) runStyle favoriteRunStyle;

@end

NS_ASSUME_NONNULL_END
