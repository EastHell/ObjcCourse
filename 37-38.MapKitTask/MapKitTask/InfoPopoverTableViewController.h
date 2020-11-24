//
//  InfoPopoverTableViewController.h
//  MapKitTask
//
//  Created by Aleksandr on 08/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoPopoverTableViewController : UITableViewController

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *secondName;
@property (copy, nonatomic) NSString *dateOfBirth;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *address;

@end

NS_ASSUME_NONNULL_END
