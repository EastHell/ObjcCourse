//
//  FileCell.m
//  TableViewNavigation
//
//  Created by Aleksandr on 21/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "FileCell.h"

@interface FileCell()

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *sizeLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation FileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeFileView];
    }
    
    return self;
}

-(void)configureWithFile:(NSString *)file size:(unsigned long long)size date:(NSDate *)date {
    self.nameLabel.text = file;
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    }
    self.dateLabel.text = [dateFormatter stringFromDate:date];    
    self.sizeLabel.text = [self fileSizeFromValue:size];
    
}

-(void)makeFileView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.png"]];
    [self.contentView addSubview:self.imgView];
    [self anchorFileImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    [self anchorFileNameLabel];
    
    self.sizeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.sizeLabel];
    [self anchorFileSizeLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.dateLabel];
    [self anchorFileDateLabel];
}

- (void)anchorFileImageView {
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.imgView.heightAnchor constraintEqualToConstant:40.f],
                                              [self.imgView.widthAnchor constraintEqualToConstant:40.f],
                                              [self.imgView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:10.f],
                                              [self.imgView.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:10.f],
                                              [self.imgView.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:-10.f],
                                              [self.imgView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
}

- (void)anchorFileNameLabel {
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.nameLabel.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:10.f],
                                              [self.nameLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-100.f],
                                              [self.nameLabel.leftAnchor constraintEqualToAnchor:self.imgView.rightAnchor constant:10.f]]];
}

- (void)anchorFileSizeLabel {
    self.sizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.sizeLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.sizeLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10.f],
                                              [self.sizeLabel.leftAnchor constraintEqualToAnchor:self.nameLabel.rightAnchor constant:10.f]]];
}

- (void)anchorFileDateLabel {
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.dateLabel.leftAnchor constraintEqualToAnchor:self.nameLabel.leftAnchor],
                                              [self.dateLabel.rightAnchor constraintEqualToAnchor:self.nameLabel.rightAnchor],
                                              [self.dateLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:10.f],
                                              [self.dateLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:-10.f]]];
}

- (NSString *)fileSizeFromValue:(unsigned long long)size {
    static NSArray<NSString *> *units = nil;
    
    if (!units) {
        units = [NSArray arrayWithObjects:@"B", @"KB", @"MB", @"GB", @"TB", nil];
    }
    
    NSInteger index = 0;
    
    double fileSize = (double)size;
    
    while (fileSize > 1024 && index < units.count) {
        fileSize = fileSize / 1024;
        index ++;
    }
    
    return [NSString stringWithFormat:@"%.2f %@", fileSize, units[index]];
}

@end
