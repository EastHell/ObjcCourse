//
//  LabelTextFieldTableViewCell.h
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelTextFieldTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) NSDateFormatter *dateFormatter;

@property (copy, nonatomic) void (^valueChanged)(NSString *propertyName, NSString *value);

- (void)dateChanged:(UIDatePicker *)sender;

@end

NS_ASSUME_NONNULL_END
