//
//  KeyChainStorage.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "KeyChainStorage.h"

static NSString *const KeychainStorageErrorDomain = @"com.KeychainStorageErrorDomain";

@interface KeyChainStorage ()

@property (strong, nonatomic) NSData *tag;

@end

@implementation KeyChainStorage


+ (instancetype)keychainStorageWithTag:(NSString *)tag {
    KeyChainStorage *storage = [KeyChainStorage new];
    storage.tag = [tag dataUsingEncoding:NSUTF8StringEncoding];
    
    return storage;
}

#pragma mark - Keychain

- (BOOL)keychainAddItem:(NSData *)item errorPtr:(NSError **)error {
    NSDictionary *addquery = @{
                               (id)kSecClass:(id)kSecClassKey,
                               (id)kSecAttrApplicationTag:self.tag,
                               (id)kSecValueData:item
                               };
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)addquery, nil);
    if (status != errSecSuccess) {
        if (error) {
            *error = [NSError errorWithDomain:KeychainStorageErrorDomain code:status
                                     userInfo:@{NSLocalizedDescriptionKey:@"Cannot add Item to Keychain"}];
        }
        return NO;
    } else {
        if (error) {
            *error = nil;
        }
    }
    return YES;
}

- (NSData *)keychainFindItemWithErrorPtr:(NSError **)error {
    NSDictionary *findquery = @{
                                (id)kSecClass:(id)kSecClassKey,
                                (id)kSecAttrApplicationTag:self.tag,
                                (id)kSecReturnData:@YES
                                };
    CFTypeRef item;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)findquery, &item);
    if (status!=errSecSuccess) {
        if (error) {
            *error = [NSError errorWithDomain:KeychainStorageErrorDomain code:status
                                     userInfo:@{NSLocalizedDescriptionKey:@"Cannot find Item in Keychain"}];
        }
        return nil;
    } else {
        if (error) {
            *error = nil;
        }
    }
    NSData *result = [NSData dataWithData:(__bridge NSData *)item];
    CFRelease(item);
    return result;
}

- (BOOL)keychainUpdateItem:(NSData *)item errorPtr:(NSError **)error {
    NSDictionary *query = @{
                            (id)kSecClass:(id)kSecClassKey,
                            (id)kSecAttrApplicationTag:self.tag
                            };
    NSDictionary *attributes = @{
                                 (id)kSecValueData:item
                                 };
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributes);
    if (status!=errSecSuccess || status!=errSecItemNotFound) {
        if (error) {
            *error = [NSError errorWithDomain:KeychainStorageErrorDomain code:status
                                     userInfo:@{NSLocalizedDescriptionKey:@"Cannot update Item in Keychain"}];
        }
        return NO;
    } else {
        if (error) {
            *error = nil;
        }
    }
    return YES;
}

- (BOOL)keychainDeleteItemWithErrorPtr:(NSError **)error {
    NSDictionary *query = @{
                            (id)kSecClass:(id)kSecClassKey,
                            (id)kSecAttrApplicationTag:self.tag
                            };
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status!=errSecSuccess || status!=errSecItemNotFound) {
        if (error) {
            *error = [NSError errorWithDomain:KeychainStorageErrorDomain code:status
                                     userInfo:@{NSLocalizedDescriptionKey:@"Cannot delete Item from Keychain"}];
        }
        return NO;
    }
    if (error) {
        *error = nil;
    }
    return YES;
}

@end
