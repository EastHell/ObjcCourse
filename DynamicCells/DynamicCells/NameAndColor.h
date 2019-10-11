//
//  NameAndColor.h
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NameAndColor : NSObject

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithColor:(UIColor *)color Name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
