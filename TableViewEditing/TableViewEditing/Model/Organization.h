//
//  Organization.h
//  TableViewEditing
//
//  Created by Aleksandr on 14/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Worker.h"

NS_ASSUME_NONNULL_BEGIN

@interface Organization : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray<Worker *> *workers;

- (instancetype)initWithOrganizationName:(NSString *)organizationName;

@end

NS_ASSUME_NONNULL_END
