//
//  KeyChainStorage.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStorage : NSObject

+ (instancetype)keychainStorageWithTag:(NSString *)tag;
- (BOOL)keychainAddItem:(NSData *)item errorPtr:(NSError **)error;
- (NSData *)keychainFindItemWithErrorPtr:(NSError **)error;
- (BOOL)keychainUpdateItem:(NSData *)item errorPtr:(NSError **)error;
- (BOOL)keychainDeleteItemWithErrorPtr:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
