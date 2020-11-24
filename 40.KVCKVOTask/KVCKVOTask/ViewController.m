//
//  ViewController.m
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "LabelTextFieldTableViewCell.h"
#import "LabelSelectorTableViewCell.h"
#import "Student.h"

@interface ViewController ()

@property (strong, nonatomic) Student *student;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.student = [Student new];
    
    [self.student addObserver:self
                   forKeyPath:@"firstName"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    [self.student addObserver:self
                   forKeyPath:@"lastName"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    [self.student addObserver:self
                   forKeyPath:@"dateOfBirth"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    [self.student addObserver:self
                   forKeyPath:@"gender"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    [self.student addObserver:self
                   forKeyPath:@"grade"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
#pragma mark - Mastah
    
    NSMutableArray<Student *> *students = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        Student *newStudent = [Student new];
        
        if (i > 0) {
            students.lastObject.friend = newStudent;
        }
        
        [students addObject:newStudent];
    }
    
    students.lastObject.friend = self.student;
    [students addObject:self.student];
    
    [students.firstObject setValue:@"ALESHA" forKeyPath:@"friend.friend.friend.friend.friend.firstName"];
    
#pragma mark - Superman
    
    [students removeAllObjects];
    
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSTimeInterval timeBetween = [endDate timeIntervalSince1970];
    
    for (int i = 0; i < 10; i++) {
        Student *newStudent = [Student new];
        newStudent.firstName = [NSString stringWithFormat:@"Name%d", i];
        
        NSTimeInterval randomInterval = ((NSTimeInterval)arc4random_uniform(UINT32_MAX))/UINT32_MAX * timeBetween;
        NSDate *randomDate = [startDate dateByAddingTimeInterval:randomInterval];
        newStudent.dateOfBirth = randomDate;
        
        newStudent.grade = arc4random_uniform(5) + 1;
        
        [students addObject:newStudent];
    }
    
    NSArray<NSString *> *allNames = [students valueForKeyPath:@"@unionOfObjects.firstName"];
    NSLog(@"%@", allNames);
    
    NSDate *ealiestDateOfBirth = [students valueForKeyPath:@"@min.dateOfBirth"];
    NSDate *latestDateOfBirth = [students valueForKeyPath:@"@max.dateOfBirth"];
    NSLog(@"earliest: %@ \tlatest: %@", [self.dateFormatter stringFromDate:ealiestDateOfBirth], [self.dateFormatter stringFromDate:latestDateOfBirth]);
    
    NSNumber *sum = [students valueForKeyPath:@"@sum.grade"];
    NSNumber *avg = [students valueForKeyPath:@"@avg.grade"];
    NSLog(@"sum: %@, avg: %@", sum, avg);
}

- (void)dealloc
{
    [self.student removeObserver:self forKeyPath:@"firstName"];
    [self.student removeObserver:self forKeyPath:@"lastName"];
    [self.student removeObserver:self forKeyPath:@"dateOfBirth"];
    [self.student removeObserver:self forKeyPath:@"gender"];
    [self.student removeObserver:self forKeyPath:@"grade"];
}

#pragma mark - Oberver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath: %@\nobject: %@\n change: %@", keyPath, object, change);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Student";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier = indexPath.row == 3 ? @"LabelSelectorTableViewCell" : @"LabelTextFieldTableViewCell";
    
    const NSArray<NSString *> *studentProperties = @[@"firstName",
                                               @"lastName",
                                               @"dateOfBirth",
                                               @"gender",
                                               @"grade"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if ([cell isKindOfClass:[LabelTextFieldTableViewCell class]]) {
        LabelTextFieldTableViewCell *labelTextFieldCell = (LabelTextFieldTableViewCell *)cell;
        
        labelTextFieldCell.label.text = studentProperties[indexPath.row];
        
        NSString *keyPath = [NSString stringWithFormat:@"student.%@", studentProperties[indexPath.row]];
        id value = [self valueForKeyPath:keyPath];
        NSString *text;
        if (!value) {
            text = @"";
        } else if ([value isKindOfClass:[NSString class]]) {
            text = value;
        } else if ([value isKindOfClass:[NSNumber class]]) {
            text = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
        } else if ([value isKindOfClass:[NSDate class]]) {
            self.datePicker.date = value;
            text = [self.dateFormatter stringFromDate:value];
        }
        
        labelTextFieldCell.textField.text = text;
        
        if (indexPath.row == 2) {
            labelTextFieldCell.dateFormatter = self.dateFormatter;
            [self.datePicker addTarget:labelTextFieldCell action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            labelTextFieldCell.textField.inputView = self.datePicker;
        }
        
        labelTextFieldCell.valueChanged = ^(NSString * _Nonnull propertyName, NSString * _Nonnull value) {
            if ([propertyName isEqualToString:@"dateOfBirth"]) {
                self.student.dateOfBirth = [self.dateFormatter dateFromString:value];
            } else if ([propertyName isEqualToString:@"grade"]) {
                self.student.grade = [value integerValue];
            } else {
                [self.student setValue:value forKey:propertyName];
            }
        };
        
        return labelTextFieldCell;
    } else if ([cell isKindOfClass:[LabelSelectorTableViewCell class]]) {
        LabelSelectorTableViewCell *labelSelectorCell = (LabelSelectorTableViewCell *)cell;
        
        labelSelectorCell.label.text = studentProperties[indexPath.row];
        labelSelectorCell.segmentedControlValueChanged = ^(NSInteger selectedItemIndex) {
            self.student.gender = (StudentGender)selectedItemIndex;
        };
        
        NSString *keyPath = [NSString stringWithFormat:@"student.%@", studentProperties[indexPath.row]];
        NSNumber *selectedSegmentIndex = [self valueForKeyPath:keyPath];
        [labelSelectorCell.segmentedControl setSelectedSegmentIndex: selectedSegmentIndex?[selectedSegmentIndex integerValue]:UISegmentedControlNoSegment];
        
        return labelSelectorCell;
    }
    
    return cell;
}

#pragma mark - Lazy properties

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"dd.MM.yyyy"];
    }
    return _dateFormatter;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

@end
