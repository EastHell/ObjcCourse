//
//  ASSwimmers.h
//  ProtocolsTask
//
//  Created by Aleksandr on 23/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ASSwimmers <NSObject>

@required
@property (strong, nonatomic) NSString *favoriteSwimStyle;

- (void) swim;

@optional
@property (assign, nonatomic) NSInteger swimstylesKnow;
- (NSString *) sayFavoriteSwimStyle;

@end

NS_ASSUME_NONNULL_END
