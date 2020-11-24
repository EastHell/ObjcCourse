//
//  DirectoryTableViewController.h
//  TableViewNavigation
//
//  Created by Aleksandr on 19/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DirectoryTableViewController : UITableViewController <UITableViewDelegate>

- (instancetype)initWithFolderPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
