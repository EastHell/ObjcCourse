//
//  ASDog.h
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASAnimal.h"
#import "ASJumpers.h"
#import "ASRunners.h"
#import "ASSwimmers.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASDog : ASAnimal <ASJumpers, ASRunners, ASSwimmers>

@property (assign, nonatomic) NSInteger jumpHeight;
@property (assign, nonatomic) NSInteger jumpsCount;
@property (assign, nonatomic) NSInteger speed;
@property (strong, nonatomic) NSString *favoriteSwimStyle;
@property (assign, nonatomic) NSInteger swimstylesKnow;

@end

NS_ASSUME_NONNULL_END
