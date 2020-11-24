//
//  ASJumpers.h
//  ProtocolsTask
//
//  Created by Aleksandr on 23/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ASJumpers <NSObject>

@required
@property (assign, nonatomic) NSInteger jumpHeight;

- (void) jump;

@optional
@property (assign, nonatomic) NSInteger jumpsCount;
- (void) writeJumpsCount;

@end

NS_ASSUME_NONNULL_END
