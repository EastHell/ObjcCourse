//
//  UserTableViewCell.m
//  CoreDataTask
//
//  Created by Aleksandr on 05/03/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UserTableViewCell.h"
#import "CoreDataTask+CoreDataModel.h"

@interface UserTableViewCell ()

@end

@implementation UserTableViewCell

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
    
    self.selectedSwitch = [UISwitch new];
    self.selectedSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectedSwitch setHidden:YES];
    [self.selectedSwitch setOn:YES];
    [self.contentView addSubview:self.selectedSwitch];
    
    [self.selectedSwitch.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.selectedSwitch.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-30.f].active = YES;
    
    self.nameLabel = [UILabel new];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f].active = YES;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:30.f].active = YES;
    [self.nameLabel.trailingAnchor constraintEqualToAnchor:self.selectedSwitch.trailingAnchor constant:-30.f].active = YES;
    [self.nameLabel.bottomAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    
    self.emailLabel = [UILabel new];
    self.emailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.emailLabel setTextAlignment:NSTextAlignmentLeft];
    [self.emailLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:self.emailLabel];
    
    [self.emailLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor].active = YES;
    [self.emailLabel.leadingAnchor constraintEqualToAnchor:self.nameLabel.leadingAnchor].active = YES;
    [self.emailLabel.trailingAnchor constraintEqualToAnchor:self.nameLabel.trailingAnchor].active = YES;
    [self.emailLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8.f].active = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
