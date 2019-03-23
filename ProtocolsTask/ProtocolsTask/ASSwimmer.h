//
//  ASSwimmer.h
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASHuman.h"
#import "ASSwimmers.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASSwimmer : ASHuman <ASSwimmers>

@property (strong, nonatomic) NSString *favoriteSwimStyle;
@property (assign, nonatomic) NSInteger swimstylesKnow;

@end

NS_ASSUME_NONNULL_END
