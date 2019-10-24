//
//  DirectoryDataSource.h
//  TableViewNavigation
//
//  Created by Aleksandr on 19/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DirectoryDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithFolderPath:(NSString *)path;
- (void)refreshContent;
- (NSString *)selectedPath;
- (BOOL)isDirectoryAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)directoryNameAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
