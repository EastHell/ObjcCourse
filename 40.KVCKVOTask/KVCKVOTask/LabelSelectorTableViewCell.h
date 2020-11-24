//
//  LabelSelectorTableViewCell.h
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelSelectorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (copy, nonatomic) void (^segmentedControlValueChanged)(NSInteger selectedItemIndex);

@end

NS_ASSUME_NONNULL_END
