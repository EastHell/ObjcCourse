//
//  ImageCacher.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 25/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

@interface ImageCacher : NSObject

+ (ImageCacher *)sharedImageCacher;
- (void)cacheImage:(UIImage *)image forUrl:(NSURL *)url;
- (UIImage *)getImageForUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
