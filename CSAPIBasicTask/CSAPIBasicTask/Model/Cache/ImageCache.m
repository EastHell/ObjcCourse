//
//  ImageCache.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 16/06/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "ImageCache.h"
#import "NetworkManager.h"
#import <UIKit/UIKit.h>

@interface ImageCache ()

@property (strong, nonatomic) NSCache<id, UIImage *> *cachedImages;
@property (strong, nonatomic) NSMutableDictionary<NSURL *, NSMutableArray<completionBlock> *> *loadingResponses;

@end

@implementation ImageCache

+ (ImageCache *)publicCache {
    
    static ImageCache *cache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[ImageCache alloc] init];
    });
    
    return cache;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cachedImages = [NSCache new];
        self.loadingResponses = [NSMutableDictionary dictionary];
    }
    return self;
}

- (UIImage *)imageWithUrl:(NSURL *)url {
    return [self.cachedImages objectForKey:url];
}

- (void)loadWithUrl:(NSURL *)url completion:(completionBlock)completion {
    
    UIImage *cachedImage = [self imageWithUrl:url];
    
    if (cachedImage) {
        completion(cachedImage);
        return;
    }
    
    NSMutableArray<completionBlock> *loadingResponsesForUrl = [self.loadingResponses objectForKey:url];
    if (loadingResponsesForUrl != nil) {
        [loadingResponsesForUrl addObject:completion];
        return;
    } else {
        [self.loadingResponses setObject:[@[completion] mutableCopy] forKey:url];
    }
    
    [[NetworkManager sharedNetwork] performRequestWithUrl:url onSuccess:^(NSData * _Nonnull data) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (!image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
            return;
        }
        
        [self.cachedImages setObject:image forKey:url];
        
        for (completionBlock block in [self.loadingResponses objectForKey:url]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(image);
            });
        }
    } onFailure:^(NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil);
        });
    }];
}

@end
