//
//  FileCell.h
//  TableViewNavigation
//
//  Created by Aleksandr on 21/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileCell : UITableViewCell

-(void)configureWithFile:(NSString *)file size:(unsigned long long)size date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
