//
//  EducationTableViewCell.h
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 26/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EducationSwitchDelegate <NSObject>

- (void)switchedEducation:(NSString *)education value:(BOOL)value;

@end

@interface EducationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UISwitch *educationSwitch;
@property (weak, nonatomic) id <EducationSwitchDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
