//
//  Student.h
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

typedef NS_ENUM(NSUInteger, StudentGender) {
    StudentGenderMale = 0,
    StudentGenderFemale = 1
};

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *dateOfBirth;
@property (assign, nonatomic) StudentGender gender;
@property (assign, nonatomic) NSInteger grade;
@property (weak, nonatomic) Student *friend;

- (void)reset;

@end

NS_ASSUME_NONNULL_END
