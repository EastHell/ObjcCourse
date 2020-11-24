//
//  LabelSelectorTableViewCell.m
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "LabelSelectorTableViewCell.h"

@implementation LabelSelectorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)segmentedValueChangedAction:(UISegmentedControl *)sender {
    if (self.segmentedControlValueChanged) {
        self.segmentedControlValueChanged(sender.selectedSegmentIndex);
    }
}


@end
