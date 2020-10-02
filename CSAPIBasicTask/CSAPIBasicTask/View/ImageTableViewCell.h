//
//  ImageTableViewCell.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 15/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageTableViewCell : ASTableViewCell

- (void)addImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
