//
//  EducationTableViewPopoverController.m
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 24/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "EducationTableViewPopoverController.h"
#import "EducationTableViewCell.h"

@interface EducationTableViewPopoverController () <UIPopoverPresentationControllerDelegate, EducationSwitchDelegate>

@property (strong, nonatomic) NSArray<NSString *> *educationGrades;
@property (assign, nonatomic) NSInteger switchOnIndex;

@end

@implementation EducationTableViewPopoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.educationGrades = @[@"Incomplete Secondary", @"Secondary", @"Incomplete Higher", @"Higher"];
    
    NSString *education = [self.delegate getEducation];
    if (education) {
        self.switchOnIndex = [self.educationGrades indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj isEqualToString:education];
        }];
    } else {
        self.switchOnIndex = -1;
    }
    
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Education";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.educationGrades.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EducationTableViewCell class])];
    
    if (!cell.delegate) {
        cell.delegate = self;
    }
    
    cell.educationLabel.text = [self.educationGrades objectAtIndex:indexPath.row];
    if (self.switchOnIndex == indexPath.row) {
        [cell.educationSwitch setOn:YES];
    }
    
    return cell;
}

#pragma mark - EducationSwitchDelegate

- (void)switchedEducation:(nonnull NSString *)education value:(BOOL)value {
    NSInteger switchedIndex = [self.educationGrades indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj isEqualToString:education];
    }];
    
    if (self.switchOnIndex != -1) {
        EducationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.switchOnIndex inSection:0]];
        [cell.educationSwitch setOn:NO animated:YES];
    }
    
    if (value == NO) {
        self.switchOnIndex = -1;
        [self.delegate educationChanged:@""];
    } else {
        self.switchOnIndex = switchedIndex;
        [self.delegate educationChanged:self.educationGrades[switchedIndex]];
    }
    
}

@end
