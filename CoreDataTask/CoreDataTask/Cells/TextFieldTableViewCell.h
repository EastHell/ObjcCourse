//
//  TextFieldTableViewCell.h
//  CoreDataTask
//
//  Created by Aleksandr on 24/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *field;

@end

NS_ASSUME_NONNULL_END
