//
//  UserTableViewCell.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 26/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UserTableViewCell.h"
#import "ImageCacher.h"

@interface UserTableViewCell ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}*/

- (void)addImageForUrl:(NSURL *)url {
    
    if (self.dataTask) {
        [self.dataTask cancel];
    }
    
    [self showLoader];
    
    self.imageView.image = [[ImageCacher sharedImageCacher] getImageForUrl:url];
    
    if (self.imageView.image) {
        [self hideLoader];
        return;
    }
    
    __weak UserTableViewCell *weakSelf = self;
    
    self.dataTask = [[NSURLSession sharedSession]
                     dataTaskWithURL:url
                     completionHandler:^(NSData * _Nullable data,
                                         NSURLResponse * _Nullable response,
                                         NSError * _Nullable error) {
                         if (!error) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 UIImage *image = [UIImage imageWithData:data];
                                 [[ImageCacher sharedImageCacher] cacheImage:image forUrl:url];
                                 weakSelf.imageView.image = image;
                                 [weakSelf hideLoader];
                             });
                         }
                     }];
    
    [self.dataTask resume];
}

- (void)showLoader {
    if (!self.activityIndicatorView) {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.activityIndicatorView setHidesWhenStopped:YES];
        self.imageView.image = nil;
        [self.imageView addSubview:self.activityIndicatorView];
        [self.imageView bringSubviewToFront:self.activityIndicatorView];
    } else {
        [self.activityIndicatorView startAnimating];
    }
}

- (void)hideLoader {
    if (self.activityIndicatorView) {
        [self.activityIndicatorView stopAnimating];
    }
}

@end
