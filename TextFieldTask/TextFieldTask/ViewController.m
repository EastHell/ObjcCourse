//
//  ViewController.m
//  TextFieldTask
//
//  Created by Aleksandr on 13/09/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self.textFields firstObject] becomeFirstResponder];
    for (UITextField *field in self.textFields) {
        field.delegate = self;
    }
}

- (IBAction)actionTextChanged:(UITextField *)sender {
    NSUInteger index = [self.textFields indexOfObject:sender];
    UILabel *label = [self.labels objectAtIndex:index];
    NSString *string;
    if ([sender isEqual:self.textFields.lastObject] && ![self isValid:sender.text]) {
        if (sender.text.length >= 2) {
            string = [sender.text substringToIndex:sender.text.length - 1];
        } else {
            string = @"";
        }
        [sender setText:string];
    } else {
        string = sender.text;
    }
    [label setText:string];
}

- (BOOL)isValid:(NSString *)inputMail {
    
    BOOL isAtAlreadyExist = false;
    
    for (int i = 0; i < inputMail.length; i++) {
        if ([inputMail characterAtIndex:i] == '@') {
            if (isAtAlreadyExist || i == 0) {
                return false;
            }
            isAtAlreadyExist = true;
        }
        if ([inputMail characterAtIndex:i] == ' ') {
            return false;
        }
    }
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (![textField isEqual:self.textFields[5]]) {
        return YES;
    }
    
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //+XX (XXX) XXX-XXXX
    
    NSLog(@"new string = %@", newString);
    
    NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    
    newString = [validComponents componentsJoinedByString:@""];
    
    // XXXXXXXXXXXX
    
    NSLog(@"new string fixed = %@", newString);
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    
    NSMutableString* resultString = [NSMutableString string];
    
    /*
     XXXXXXXXXXXX
     +XX (XXX) XXX-XXXX
     */
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        
        NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
        
    }
    
    if ([newString length] > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        
        NSString* area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        
        NSString* countryCode = [newString substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    
    textField.text = resultString;
    
    return NO;	    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textFields.lastObject]) {
        [textField resignFirstResponder];
    } else {
        [[self.textFields objectAtIndex:[self.textFields indexOfObject:textField] + 1] becomeFirstResponder];
    }
    return true;
}

@end
