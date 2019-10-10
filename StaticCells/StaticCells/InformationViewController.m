//
//  InformationViewController.m
//  StaticCells
//
//  Created by Aleksandr on 10/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *secondNameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *mailField;

@property (strong, nonatomic) NSArray<UITextField *> *textFieldsArray;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *mailLabel;

@property (strong, nonatomic) NSArray<UILabel *> *labelsFieldsArray;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.textFieldsArray = [NSArray arrayWithObjects:
                            self.nameField,
                            self.secondNameField,
                            self.ageField,
                            self.loginField,
                            self.passwordField,
                            self.numberField,
                            self.mailField ,
                            nil];
    self.labelsFieldsArray = [NSArray arrayWithObjects:
                              self.nameLabel,
                              self.secondNameLabel,
                              self.ageLabel,
                              self.loginLabel,
                              self.passwordLabel,
                              self.numberLabel,
                              self.mailLabel,
                              nil];
    [self.nameField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.nameField] || [textField isEqual:self.secondNameField]) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
        NSCharacterSet *charactersValidationSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:charactersValidationSet];
        
        if([components count] > 1) {
            return NO;
        }
        return YES;
    }
    
    if ([textField isEqual:self.ageField]) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
        NSCharacterSet *decimalValidationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:decimalValidationSet];
        
        if([components count] > 1 || [string characterAtIndex:0] == '0') {
            return NO;
        }
        return YES;
    }
    
    if ([textField isEqual:self.numberField]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString = [validComponents componentsJoinedByString:@""];
        
        static const int localNumberMaxLength = 7;
        static const int areaCodeMaxLength = 3;
        static const int countryCodeMaxLength = 3;
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return NO;
        }
        
        
        NSMutableString *resultString = [NSMutableString string];
        
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
        
        if (localNumberLength > 0) {
            
            NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            
            [resultString appendString:number];
            
            if ([resultString length] > 3) {
                [resultString insertString:@"-" atIndex:3];
            }
            
        }
        
        if ([newString length] > localNumberMaxLength) {
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            
            NSString *area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@) ", area];
            
            [resultString insertString:area atIndex:0];
        }
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            
            NSString *countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
        }
        
        
        textField.text = resultString;
        self.numberLabel.text = resultString;
        return NO;
    }
    
    if ([textField isEqual:self.mailField]) {
        
        NSCharacterSet *atValidationSet = [NSCharacterSet characterSetWithCharactersInString:@"@"];
        NSString *newString = [textField.text stringByAppendingString:string];
        NSArray *components = [newString componentsSeparatedByCharactersInSet:atValidationSet];
        
        if([components count] > 2) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

- (IBAction)fieldChangedAction:(UITextField *)sender {
    NSUInteger index = [self.textFieldsArray indexOfObject:sender];
    UILabel *label = [self.labelsFieldsArray objectAtIndex:index];
    [label setText:sender.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textFieldsArray.lastObject]) {
        [textField resignFirstResponder];
    } else {
        NSUInteger index = [self.textFieldsArray indexOfObject:textField];
        UITextField *field = [self.textFieldsArray objectAtIndex:index + 1];
        [textField resignFirstResponder];
        [field becomeFirstResponder];
    }
    return YES;
}



@end
