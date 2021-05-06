//
//  EducationTableViewCell.m
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 26/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "EducationTableViewCell.h"

@implementation EducationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)switchChanged:(UISwitch *)sender {
    [self.delegate switchedEducation:self.educationLabel.text value:sender.isOn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
