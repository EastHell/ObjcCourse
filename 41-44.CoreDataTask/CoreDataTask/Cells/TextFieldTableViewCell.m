//
//  TextFieldTableViewCell.m
//  CoreDataTask
//
//  Created by Aleksandr on 24/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

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
    
    self.field = [[UITextField alloc] init];
    self.field.translatesAutoresizingMaskIntoConstraints = NO;
    [self.field setBorderStyle:UITextBorderStyleNone];
    [self.contentView addSubview:self.field];
    
    [self.field.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.field.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.f].active = YES;
    [self.field.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.f].active = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
