//
//  ButtonTableViewCell.m
//  CoreDataTask
//
//  Created by Aleksandr on 24/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "ButtonTableViewCell.h"

@implementation ButtonTableViewCell

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
    
    self.button = [[UIButton alloc] init];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor yellowColor]];
    [self.contentView addSubview:self.button];
    
    [self.button.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.button.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    
    [self.button.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    [self.button.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
