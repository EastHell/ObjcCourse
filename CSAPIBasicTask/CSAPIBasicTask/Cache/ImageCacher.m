//
//  ImageCacher.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 25/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "ImageCacher.h"
#import <UIKit/UIKit.h>

@interface ImageCacher ()

@property (strong, nonatomic) NSCache<id, UIImage *> *imageCache;

@end

@implementation ImageCacher

+ (ImageCacher *)sharedImageCacher {
    static ImageCacher *cacher = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacher = [[ImageCacher alloc] init];
    });
    
    return cacher;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [NSCache new];
    }
    return self;
}

- (void)cacheImage:(UIImage *)image forUrl:(NSURL *)url {
    [self.imageCache setObject:image forKey:url];
}

- (UIImage *)getImageForUrl:(NSURL *)url {
    return [self.imageCache objectForKey:url];
}

@end
