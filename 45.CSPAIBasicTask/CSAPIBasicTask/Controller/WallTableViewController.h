//
//  WallTableViewController.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallTableViewController : UITableViewController

- (instancetype)initWithOwnerID:(NSString *)ownerID;

@end

NS_ASSUME_NONNULL_END
