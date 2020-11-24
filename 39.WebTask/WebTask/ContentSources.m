//
//  ContentSources.m
//  WebTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ContentSources.h"

@implementation ContentSources

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.web = @{@"habr" : @"https://habr.com",
                     @"swiftbook" : @"https://swiftbook.ru"
                     };
        /*NSString *objcPath = [[NSBundle mainBundle] pathForResource:@"Gellovey_M__Sila_Objective_C_2_0" ofType:@"pdf"];
        NSString *iosPath = [[NSBundle mainBundle] pathForResource:@"iOS_Security_Guide" ofType:@"pdf"];*/
        self.pdf = @{@"Obj-c" : @"Gellovey_M__Sila_Objective_C_2_0.pdf",
                     @"iOS" : @"iOS_Security_Guide.pdf"
                     };
    }
    return self;
}

@end
