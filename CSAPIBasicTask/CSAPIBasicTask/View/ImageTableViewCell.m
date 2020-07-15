//
//  ImageTableViewCell.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 15/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "ImageTableViewCell.h"

@interface ImageTableViewCell ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIImageView *avatarImageView;

@end

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configure];
    }
    
    return self;
}

- (void)addImage:(UIImage *)image {
    
    if (image) {
        [self.activityIndicator stopAnimating];
    }
    
    self.avatarImageView.image = image;
}

- (void)configure {
    
    self.avatarImageView = [[UIImageView alloc] initWithImage:nil];
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.avatarImageView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor redColor];
    [self.contentView addSubview:self.activityIndicator];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    
    [self.avatarImageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.avatarImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f].active = YES;
    [self.avatarImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8.f].active = YES;
    
    [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
}

@end
