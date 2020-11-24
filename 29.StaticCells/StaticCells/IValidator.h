//
//  IValidator.h
//  StaticCells
//
//  Created by Aleksandr on 10/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IValidator <NSObject>

- (BOOL)validateName:(NSString *)name;
- (BOOL)validateAge:(NSString *)age;
- (BOOL)validateEmail:(NSString *)email;

@end
