//
//  LabelTableViewCell.m
//  CoreDataTask
//
//  Created by Aleksandr on 25/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "LabelTableViewCell.h"

@implementation LabelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup {
    
    self.label = [UILabel new];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.label];
    
    [self.label.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.label.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.label.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    [self.label.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
