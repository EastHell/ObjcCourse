//
//  Organization.m
//  TableViewEditing
//
//  Created by Aleksandr on 14/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "Organization.h"

@implementation Organization

- (instancetype)initWithOrganizationName:(NSString *)organizationName
{
    self = [super init];
    if (self) {
        _name = [organizationName copy];
        _workers = [NSArray array];
    }
    return self;
}

@end
