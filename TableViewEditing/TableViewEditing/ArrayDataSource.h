//
//  ArrayDataSource.h
//  TableViewEditing
//
//  Created by Aleksandr on 16/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model/Organization.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArrayDataSource : NSObject <UITableViewDataSource>

- (id)initWithOranizations:(NSArray<Organization *> *)organizations;

@end

NS_ASSUME_NONNULL_END
