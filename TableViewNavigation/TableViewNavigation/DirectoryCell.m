//
//  DirectoryCell.m
//  TableViewNavigation
//
//  Created by Aleksandr on 21/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "DirectoryCell.h"

@interface DirectoryCell()

@property (strong, nonatomic) UILabel *folderNameLabel;
@property (strong, nonatomic) UILabel *folderSizeLabel;
@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation DirectoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeFolderView];
    }
    
    return self;
}

- (void)configureWothFolder:(NSString *)folder size:(unsigned long long)size {
    self.folderNameLabel.text = folder;
    self.folderSizeLabel.text = [self fileSizeFromValue:size];
}

- (void)makeFolderView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"folder.png"]];
    [self.contentView addSubview:self.imgView];
    [self anchorFolderImageView];
    
    self.folderNameLabel = [UILabel new];
    [self.contentView addSubview:self.folderNameLabel];
    [self anchorFolderNameLabel];
    
    self.folderSizeLabel = [UILabel new];
    [self.contentView addSubview:self.folderSizeLabel];
    [self anchorFilderSizeLabel];
}

- (void)anchorFolderImageView {
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.imgView.heightAnchor constraintEqualToConstant:40.f],
                                              [self.imgView.widthAnchor constraintEqualToConstant:40.f],
                                              [self.imgView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10.f],
                                              [self.imgView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.imgView.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:10.f],
                                              [self.imgView.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:10.f]]];
}

- (void)anchorFolderNameLabel {
    self.folderNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.folderNameLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:10.f],
                                              [self.folderNameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.folderNameLabel.rightAnchor constraintEqualToAnchor:self.imgView.leftAnchor constant:-140.f]]];
}

- (void)anchorFilderSizeLabel {
    self.folderSizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[[self.folderSizeLabel.rightAnchor constraintEqualToAnchor:self.imgView.leftAnchor constant:-10.f],
                                              [self.folderSizeLabel.leftAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-140.f],
                                              [self.folderSizeLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
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
