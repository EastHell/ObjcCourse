//
//  LabelTextFieldTableViewCell.m
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "LabelTextFieldTableViewCell.h"

@interface LabelTextFieldTableViewCell ()

@end

@implementation LabelTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)textFieldValueChanged:(UITextField *)sender {
    if (self.valueChanged) {
        self.valueChanged(self.label.text, sender.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (![self.label.text isEqualToString:@"grade"]) {
        if (self.valueChanged) {
            self.valueChanged(self.label.text, [textField.text stringByReplacingCharactersInRange:range withString:string]);
        }
        return YES;
    }
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    if (components.count > 1) {
        return NO;
    }
    
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (result.length > 1 && [result characterAtIndex:0] == '0') {
        return NO;
    }
    
    if (self.valueChanged) {
        self.valueChanged(self.label.text, result);
    }
    return YES;
}

- (void)dateChanged:(UIDatePicker *)sender {
    self.textField.text = [self.dateFormatter stringFromDate:sender.date];
    if (self.valueChanged) {
        self.valueChanged(self.label.text, [self.dateFormatter stringFromDate:sender.date]);
    }
}

@end
