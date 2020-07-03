//
//  ImageCache.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 16/06/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;
typedef void(^completionBlock)(UIImage * _Nullable);

@interface ImageCache : NSObject

+ (ImageCache *)publicCache;
- (void)loadWithUrl:(NSURL *)url completion:(completionBlock)completion;

@end

NS_ASSUME_NONNULL_END
