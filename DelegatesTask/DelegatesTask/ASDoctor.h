//
//  ASDoctor.h
//  DelegatesTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPatient.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASDoctor : NSObject <ASPatientDelegate>

- (void)printRaport;

@end

NS_ASSUME_NONNULL_END
