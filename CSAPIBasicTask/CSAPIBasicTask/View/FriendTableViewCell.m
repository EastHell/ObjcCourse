//
//  FriendTableViewCell.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/05/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendTableViewCell.h"

@interface FriendTableViewCell ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *usernameLabel;

@end

@implementation FriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor redColor];
    [self.contentView addSubview:self.activityIndicator];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    
    self.usernameLabel = [UILabel new];
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.usernameLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithImage:nil];
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.avatarImageView];
    
    [self.activityIndicator.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8.f].active = YES;
    [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.activityIndicator.heightAnchor constraintEqualToConstant:50.f].active = YES;
    [self.activityIndicator.widthAnchor constraintEqualToConstant:50.f].active = YES;
    
    [self.avatarImageView.leadingAnchor constraintEqualToAnchor:self.activityIndicator.leadingAnchor].active = YES;
    [self.avatarImageView.centerYAnchor constraintEqualToAnchor:self.activityIndicator.centerYAnchor].active = YES;
    [self.avatarImageView.heightAnchor constraintEqualToAnchor:self.activityIndicator.heightAnchor].active = YES;
    [self.avatarImageView.widthAnchor constraintEqualToAnchor:self.activityIndicator.widthAnchor].active = YES;
    
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.activityIndicator.trailingAnchor constant:8.f].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:8.f].active = YES;
    [self.usernameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
}

- (void)configureWithUserName:(NSString *)userName {
    self.usernameLabel.text = userName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.avatarImageView.image = nil;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}

- (void)addImage:(UIImage *)image {
    
    if (image) {
        [self.activityIndicator stopAnimating];
    }
    self.avatarImageView.image = image;
}

@end
