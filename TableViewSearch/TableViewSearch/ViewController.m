//
//  ViewController.m
//  TableViewSearch
//
//  Created by Aleksandr on 25/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Utility.h"
#import "Student.h"
#import "StudentSection.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *students;
@property (strong, nonatomic) NSArray *sections;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSOperation *currentOperation;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.students = [NSArray array];
    
    for (int i = 0; i < 10 + arc4random_uniform(200000); i++) {
        Student *newStudent = [[Student alloc]
                               initWithName:[NSString randomNameWithMaxLength:10]
                               secondName:[NSString randomNameWithMaxLength:10]
                               birthday:[self generateRandomDateWithinDaysBeforeToday:10000]];
        self.students = [self.students arrayByAddingObject:newStudent];
    }
    
    [self generateSectionsInBackgroundFromArray:self.students withFilter:self.searchBar.text];
}

#pragma mark - Table view data source

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    
    for (StudentSection *section in self.sections) {
        [array addObject:[section.sectionName substringToIndex:1]];
    }
    
    return array;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    StudentSection *group = [self.sections objectAtIndex:section];
    return group.sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    StudentSection *group = [self.sections objectAtIndex:section];
    return group.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIndetifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellIndetifier"];
    }
    
    StudentSection *group = [self.sections objectAtIndex:indexPath.section];
    Student *currentStudent = [group.students objectAtIndex:indexPath.row];
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", currentStudent.name, currentStudent.secondName];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:currentStudent.birthday];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self generateSectionsInBackgroundFromArray:self.students withFilter:self.searchBar.text];
}

#pragma mark - segmentedControlActions

- (IBAction)actionValueChanged:(UISegmentedControl *)sender {
    [self generateSectionsInBackgroundFromArray:self.students withFilter:self.searchBar.text];
}


#pragma Mark - Utility

- (NSDate *)generateRandomDateWithinDaysBeforeToday:(NSUInteger)daysBack {
    NSUInteger day = arc4random_uniform((u_int32_t)daysBack);  // explisit cast
    NSUInteger hour = arc4random_uniform(23);
    NSUInteger minute = arc4random_uniform(59);
    
    NSDate *today = [NSDate new];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *offsetComponents = [NSDateComponents new];
    [offsetComponents setDay:(day * -1)];
    [offsetComponents setHour:hour];
    [offsetComponents setMinute:minute];
    
    NSDate *randomDate = [gregorian dateByAddingComponents:offsetComponents
                                                    toDate:today
                                                   options:0];
    
    return randomDate;
}

- (NSArray *)generateSectionsFromArray:(NSArray *)array withFilter:(NSString *)filterString {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
        static NSCalendar *calendar = nil;
        if (!calendar) {
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        }
        
        NSInteger month1 = [calendar component:NSCalendarUnitMonth fromDate:obj1.birthday];
        NSInteger month2 = [calendar component:NSCalendarUnitMonth fromDate:obj2.birthday];
        NSComparisonResult monthResult;
        
        if (month1 < month2) {
            monthResult = NSOrderedAscending;
        } else if (month1 > month2) {
            monthResult = NSOrderedDescending;
        } else {
            monthResult = NSOrderedSame;
        }
        
        NSComparisonResult nameResult = [obj1.name compare:obj2.name options:NSCaseInsensitiveSearch];
        NSComparisonResult secondNameResult = [obj1.secondName  compare:obj2.secondName options:NSCaseInsensitiveSearch];
        
        NSComparisonResult result = NSOrderedSame;
        
        switch (self.segmentedControl.selectedSegmentIndex) {
            case 0:
                result = nameResult != NSOrderedSame ? nameResult : secondNameResult;
                result = result != NSOrderedSame ? result : monthResult;
                break;
            case 1:
                result = secondNameResult != NSOrderedSame ? secondNameResult : nameResult;
                result = result != NSOrderedSame ? result : monthResult;
                break;
            case 2:
                result = monthResult != NSOrderedSame ? monthResult : nameResult;
                result = result != NSOrderedSame ? result : secondNameResult;
                break;
        }
        
        return result;
    }];
    
    NSMutableArray *sectionsArray = [NSMutableArray array];
    
    NSString *currentSection = nil;
    for (Student *student in sortedArray) {
        
        if (filterString.length > 0 && ([student.name rangeOfString:filterString].location == NSNotFound && [student.secondName rangeOfString:filterString].location == NSNotFound)) {
            continue;
        }
        
        NSString *sectionName = nil;
        
        static NSDateFormatter *df = nil;
        if (!df) {
            df = [NSDateFormatter new];
            [df setDateFormat:@"MMMM"];
        }
        
        switch (self.segmentedControl.selectedSegmentIndex) {
            case 0:
                sectionName = [student.name substringToIndex:1];
                break;
            case 1:
                sectionName = [student.secondName substringToIndex:1];
                break;
            case 2:
                sectionName = [df stringFromDate:student.birthday];
                break;
            default:
                sectionName = [df stringFromDate:student.birthday];
                break;
        }
        
        StudentSection *section = nil;
        
        if (![currentSection isEqualToString:sectionName]) {
            section = [[StudentSection alloc] init];
            section.sectionName = sectionName;
            section.students = [NSMutableArray array];
            currentSection = sectionName;
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        
        section.students = [section.students arrayByAddingObject:student];
    }
    
    return sectionsArray;
}

- (void)generateSectionsInBackgroundFromArray:(NSArray *)array withFilter:(NSString *)filterString {
    [self.currentOperation cancel];
    
    __weak ViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSArray *sectionsArray = [weakSelf generateSectionsFromArray:array withFilter:filterString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sections = sectionsArray;
            [weakSelf.tableView reloadData];
            
            self.currentOperation = nil;
        });
    }];
    
    [self.currentOperation start];
}

@end
