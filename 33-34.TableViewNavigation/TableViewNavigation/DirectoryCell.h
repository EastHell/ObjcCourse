//
//  DirectoryCell.h
//  TableViewNavigation
//
//  Created by Aleksandr on 21/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DirectoryCell : UITableViewCell

- (void)configureWothFolder:(NSString *)folder size:(unsigned long long)size;

@end

NS_ASSUME_NONNULL_END
