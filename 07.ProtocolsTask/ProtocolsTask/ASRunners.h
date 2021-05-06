//
//  ASRunners.h
//  ProtocolsTask
//
//  Created by Aleksandr on 23/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    sprint,
    maraphone
} runStyle;

@protocol ASRunners <NSObject>

@required
@property (assign, nonatomic) NSInteger speed;

- (void) run;

@optional
@property (assign, nonatomic) runStyle favoriteRunStyle;
- (NSString *) whatIsYourSpeed;

@end

NS_ASSUME_NONNULL_END
