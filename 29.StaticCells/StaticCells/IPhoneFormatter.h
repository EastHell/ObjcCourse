//
//  IPhoneFormatter.h
//  StaticCells
//
//  Created by Aleksandr on 10/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPhoneFormatter <NSObject>

- (NSString *)format:(NSString *)phone insertionString:(NSString *)insertionString;

@end
