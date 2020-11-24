//
//  FieldValidator.m
//  StaticCells
//
//  Created by Aleksandr on 10/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "FieldValidator.h"
#import "Constants.h"

@interface FieldValidator()

@property (nonatomic, strong) NSCharacterSet *nameValidationSet;
@property (nonatomic, strong) NSCharacterSet *decimalValidationSet;
@property (nonatomic, strong) NSCharacterSet *emailValidationSet;

@end

@implementation FieldValidator

- (BOOL)validateName:(NSString *)name {
    if ([name isEqualToString:@""]) {
        return YES;
    }
    
    NSArray *components = [name componentsSeparatedByCharactersInSet:self.nameValidationSet];
    
    if (components.count > 1) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateAge:(NSString *)age {
    if ([age isEqualToString:@""]) {
        return YES;
    }
    
    NSArray *components = [age componentsSeparatedByCharactersInSet:self.decimalValidationSet];
    
    if (components.count > 1 || [age characterAtIndex:0] == '0') {
        return NO;
    }
    
    return YES;
}


- (BOOL)validateEmail:(NSString *)email {
    NSArray *components = [email componentsSeparatedByCharactersInSet:self.emailValidationSet];
    
    if (components.count > 2) {
        return NO;
    }
    
    return YES;
}


#pragma mark - Lazy

- (NSCharacterSet *)nameValidationSet {
    if (!_nameValidationSet) {
        _nameValidationSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "] invertedSet];
    }
    
    return _nameValidationSet;
}

- (NSCharacterSet *)decimalValidationSet {
    if (!_decimalValidationSet) {
        _decimalValidationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    }
    
    return _decimalValidationSet;
}

- (NSCharacterSet *)emailValidationSet {
    if (!_emailValidationSet) {
        _emailValidationSet = [NSCharacterSet characterSetWithCharactersInString:@"@"];
    }
    
    return _emailValidationSet;
}

@end
