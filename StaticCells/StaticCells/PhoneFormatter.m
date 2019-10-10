//
//  PhoneFormatter.m
//  StaticCells
//
//  Created by Aleksandr on 10/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "PhoneFormatter.h"
#import "Constants.h"

@interface PhoneFormatter()

@property (nonatomic, strong) NSCharacterSet *decimalValidationSet;

@end

@implementation PhoneFormatter

- (NSString *)format:(NSString *)phone insertionString:(NSString *)insertionString {
    NSString *newString = [self validatePhoneNumber:phone withInsertionString:insertionString];
    
    if (!newString) {
        return nil;
    }
    
    newString = [self formattedPhoneWithString:newString];
    return newString;
}

- (NSString *)validatePhoneNumber:(NSString *)phone withInsertionString:(NSString *)insertionString {
    NSString *newPhone = nil;
    
    NSArray *components = [insertionString componentsSeparatedByCharactersInSet:self.decimalValidationSet];
    
    if (components.count > 1) {
        return nil;
    }
    
    NSArray *validComponents = [phone componentsSeparatedByCharactersInSet:self.decimalValidationSet];
    newPhone = [validComponents componentsJoinedByString:@""];
    
    if (newPhone.length > (LocalNumberMaxLength + AreaCodeMaxLength + CountryCodeMaxLength)) {
        return nil;
    }
    
    return newPhone;
}

- (NSString *)formattedPhoneWithString:(NSString *)string {
    NSMutableString *resultString = [NSMutableString string];
    
    NSInteger localNumberLength = MIN(string.length, LocalNumberMaxLength);
    
    if (localNumberLength > 0) {
        NSString *number = [string substringFromIndex:(int)string.length - localNumberLength];
        
        [resultString appendString:number];
        
        if (resultString.length > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if (string.length > LocalNumberMaxLength) {
        NSInteger areaCodeLength = MIN((int)string.length - LocalNumberMaxLength, AreaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)string.length - LocalNumberMaxLength - areaCodeLength, areaCodeLength);
        
        NSString *area = [string substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if (string.length > LocalNumberMaxLength + AreaCodeMaxLength) {
        NSInteger countryCodeLength = MIN((int)string.length - LocalNumberMaxLength - AreaCodeMaxLength, CountryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        
        NSString *countryCode = [string substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    return [resultString copy];
}

- (NSCharacterSet *)decimalValidationSet {
    if (!_decimalValidationSet) {
        _decimalValidationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    }
    
    return _decimalValidationSet;
}

@end
