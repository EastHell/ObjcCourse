//
//  ASSuperHuman.h
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASHuman.h"
#import "ASJumpers.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASSuperHuman : ASHuman <ASJumpers>

@property (strong, nonatomic) NSString* pantsColor;
@property (strong, nonatomic) NSString* superPower;
@property (assign, nonatomic) NSInteger jumpHeight;

@end

NS_ASSUME_NONNULL_END
