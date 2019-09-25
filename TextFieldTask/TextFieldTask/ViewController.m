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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textFields.lastObject]) {
        [textField resignFirstResponder];
    } else {
        [[self.textFields objectAtIndex:[self.textFields indexOfObject:textField] + 1] becomeFirstResponder];
    }
    return true;
}

@end
