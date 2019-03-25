//
//  ASStudent.m
//  DictionaryTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.lastName, self.name];
}

@end
