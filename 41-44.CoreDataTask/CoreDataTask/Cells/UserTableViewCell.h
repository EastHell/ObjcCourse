//
//  UserTableViewCell.h
//  CoreDataTask
//
//  Created by Aleksandr on 05/03/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface UserTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UISwitch *selectedSwitch;

@end

NS_ASSUME_NONNULL_END
