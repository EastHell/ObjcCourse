//
//  DatePickerPopoverViewController.m
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 22/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "DatePickerPopoverViewController.h"

@interface DatePickerPopoverViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate *date = [self.delegate getDate];
    if (date) {
        [self.datePicker setDate:date animated:YES];
    }    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.delegate = self;
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - DatePickerActions

- (IBAction)valueChangedAction:(UIDatePicker *)sender {
    [self.delegate dateChanged:sender.date];
}

@end
