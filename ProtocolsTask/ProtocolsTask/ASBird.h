//
//  ASBird.h
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASAnimal.h"
#import "ASSwimmers.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASBird : ASAnimal <ASSwimmers>

@property (strong, nonatomic) NSString *favoriteSwimStyle;

@end

NS_ASSUME_NONNULL_END
