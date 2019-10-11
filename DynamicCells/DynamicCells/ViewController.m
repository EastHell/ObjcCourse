//
//  ViewController.m
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Utility.h"
#import "NSString+Generator.h"
#import "NameAndColor.h"
#import "Student.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<NameAndColor *> *colors;
@property (strong, nonatomic) NSMutableArray<Student *> *students;

@property (strong, nonatomic) NSPredicate *two;
@property (strong, nonatomic) NSPredicate *three;
@property (strong, nonatomic) NSPredicate *four;
@property (strong, nonatomic) NSPredicate *five;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.colors = [NSMutableArray array];
    
    for (int i = 0; i < 1000; i++) {
        UIColor *randomColor = [UIColor randomColor];
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        [randomColor getRed:&red green:&green blue:&blue alpha:nil];
        NameAndColor *nameAndColor = [[NameAndColor alloc] initWithColor:randomColor Name:[NSString stringWithFormat:@"R:%f,\tG:%f,\tB:%f", red, green, blue]];
        [self.colors addObject:nameAndColor];
    }
    
    self.students = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++) {
        Student *student = [[Student alloc] initWithName:[NSString randomNameWithMaxLength:7] SecondName:[NSString randomNameWithMaxLength:7] Average:2 + arc4random_uniform(4)];
        [self.students addObject:student];
    }
    
    [self.students sortUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
        NSComparisonResult result = [obj1.secondName compare:obj2.secondName options:NSCaseInsensitiveSearch | NSWidthInsensitiveSearch];
        if (result == NSOrderedSame) {
            return [obj1.name compare:obj2.name options:NSCaseInsensitiveSearch | NSWidthInsensitiveSearch];
        }
        return result;
    }];
}


#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [self.students filteredArrayUsingPredicate:self.two].count;
        case 1:
            return [self.students filteredArrayUsingPredicate:self.three].count;
        case 2:
            return [self.students filteredArrayUsingPredicate:self.four].count;
        case 3:
            return [self.students filteredArrayUsingPredicate:self.five].count;
        case 4:
            return self.colors.count;
        default:
            return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier;
    UITableViewCellStyle style;
    NSArray<Student *> *filteredStudents;
    switch (indexPath.section) {
        case 0:
            filteredStudents = [self.students filteredArrayUsingPredicate:self.two];
            identifier = @"student";
            style = UITableViewCellStyleValue1;
            break;
        case 1:
            filteredStudents = [self.students filteredArrayUsingPredicate:self.three];
            identifier = @"student";
            style = UITableViewCellStyleValue1;
            break;
        case 2:
            filteredStudents = [self.students filteredArrayUsingPredicate:self.four];
            identifier = @"student";
            style = UITableViewCellStyleValue1;
            break;
        case 3:
            filteredStudents = [self.students filteredArrayUsingPredicate:self.five];
            identifier = @"student";
            style = UITableViewCellStyleValue1;
            break;
        case 4:
            identifier = @"color";
            style = UITableViewCellStyleDefault;
            break;
        default:
            identifier = @"cell";
            style = UITableViewCellStyleDefault;
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:identifier];
    }
    
    switch (indexPath.section) {
        case 0:
        case 1:
        case 2:
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@",
                                   filteredStudents[indexPath.row].secondName,
                                   filteredStudents[indexPath.row].name];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%li", (long)filteredStudents[indexPath.row].average];
            if (filteredStudents[indexPath.row].average < 4) {
                cell.textLabel.textColor = UIColor.redColor;
            } else {
                cell.textLabel.textColor = UIColor.blackColor;
            }
            break;
        case 4:
            cell.backgroundColor = self.colors[indexPath.row].color;
            cell.textLabel.text = self.colors[indexPath.row].name;
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Lazy

- (NSPredicate *)two {
    if (!_two) {
        _two = [NSPredicate predicateWithBlock:^BOOL(Student *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if (evaluatedObject.average == 2) {
                return YES;
            }
            return NO;
        }];
    }
    
    return _two;
}

- (NSPredicate *)three {
    if (!_three) {
        _three = [NSPredicate predicateWithBlock:^BOOL(Student *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if (evaluatedObject.average == 3) {
                return YES;
            }
            return NO;
        }];
    }
    
    return _three;
}

- (NSPredicate *)four {
    if (!_four) {
        _four = [NSPredicate predicateWithBlock:^BOOL(Student *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if (evaluatedObject.average == 4) {
                return YES;
            }
            return NO;
        }];
    }
    
    return _four;
}

- (NSPredicate *)five {
    if (!_five) {
        _five = [NSPredicate predicateWithBlock:^BOOL(Student *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if (evaluatedObject.average == 5) {
                return YES;
            }
            return NO;
        }];
    }
    
    return _five;
}

@end
