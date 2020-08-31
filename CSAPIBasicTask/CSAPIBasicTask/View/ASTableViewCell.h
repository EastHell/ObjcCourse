//
//  ASTableViewCell.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTableViewCell : UITableViewCell

@property (strong, nonatomic) void (^actionBlock)(void);

@end

NS_ASSUME_NONNULL_END
