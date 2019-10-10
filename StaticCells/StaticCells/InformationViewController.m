//
//  InformationViewController.m
//  StaticCells
//
//  Created by Aleksandr on 10/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "InformationViewController.h"
#import "IValidator.h"
#import "FieldValidator.h"
#import "IPhoneFormatter.h"
#import "PhoneFormatter.h"

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

@property (strong, nonatomic) id <IValidator> validator;
@property (strong, nonatomic) id <IPhoneFormatter> phoneFormatter;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.validator = [FieldValidator new];
    self.phoneFormatter = [PhoneFormatter new];
    
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
        return [self.validator validateName:string];
    }
    
    if ([textField isEqual:self.ageField]) {
        return [self.validator validateAge:string];
    }
    
    if ([textField isEqual:self.numberField]) {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *formattedPhone = [self.phoneFormatter format:newString insertionString:string];
        
        if (!formattedPhone) {
            return NO;
        }
        
        textField.text = formattedPhone;
        self.numberLabel.text = formattedPhone;
        
        return NO;
    }
    
    if ([textField isEqual:self.mailField]) {
        NSString *newString = [textField.text stringByAppendingString:string];
        return [self.validator validateEmail:newString];
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
        UITextField *nextTextField = [self.textFieldsArray objectAtIndex:index + 1];
        [textField resignFirstResponder];
        [nextTextField becomeFirstResponder];
    }
    return YES;
}
@end
