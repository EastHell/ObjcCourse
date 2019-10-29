//
//  BirthDateStudentsGroup.h
//  TableViewSearch
//
//  Created by Aleksandr on 26/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentSection : NSObject

@property (strong, nonatomic) NSArray *students;
@property (strong, nonatomic) NSString *sectionName;

@end

NS_ASSUME_NONNULL_END
