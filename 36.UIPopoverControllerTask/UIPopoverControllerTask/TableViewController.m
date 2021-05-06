//
//  TableViewController.m
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 20/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "TableViewController.h"
#import "InfoPopoverViewController.h"
#import "DatePickerPopoverViewController.h"
#import "EducationTableViewPopoverController.h"

@interface TableViewController () <UITextFieldDelegate, DatePickerDelegate, EducationDelegate>

#pragma mark - NavigationBarOutlets

@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoBarButton;

#pragma mark - TableViewOutlets

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *educationTextField;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextFieldsDelegate];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InfoPopoverSegue"]) {
        InfoPopoverViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoPopover"];
        vc.popoverPresentationController.sourceView = self.view;
        vc.popoverPresentationController.barButtonItem = self.infoBarButton;
    }
}

#pragma mark - UITextFieldDelegate

- (void)setTextFieldsDelegate {
    self.nameTextField.delegate = self;
    self.secondNameTextField.delegate = self;
    self.birthDateTextField.delegate = self;
    self.educationTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameTextField]) {
        [textField resignFirstResponder];
        [self.secondNameTextField becomeFirstResponder];
    } else if ([textField isEqual:self.secondNameTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - DatePickerDelegate

- (void)dateChanged:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    self.birthDateTextField.text = [formatter stringFromDate:date];
}

- (NSDate *)getDate {
    if (![self.birthDateTextField.text isEqualToString:@""]) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        return [formatter dateFromString:self.birthDateTextField.text];
    }
    return nil;
}

#pragma mark - EducationDelegate

- (void)educationChanged:(NSString *)education {
    self.educationTextField.text = education;
}

- (NSString *)getEducation {
    if (![self.educationTextField.text isEqualToString:@""]) {
        return self.educationTextField.text;
    }
    return nil;
}

#pragma mark - Actions

- (IBAction)birthDateTouchAction:(UITextField *)sender {
    [sender endEditing:YES];
    DatePickerPopoverViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerPopoverViewController"];
    vc.delegate = self;
    vc.popoverPresentationController.sourceView = sender.superview;
    vc.popoverPresentationController.sourceRect = [sender frame];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)educationTouchAction:(UITextField *)sender {
    [sender endEditing:YES];
    EducationTableViewPopoverController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EducationTableViewPopoverController"];
    vc.delegate = self;
    vc.popoverPresentationController.sourceView = sender.superview;
    vc.popoverPresentationController.sourceRect = [sender frame];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
