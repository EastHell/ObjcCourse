//
//  ASStudent.h
//  BitwiseTest
//
//  Created by Aleksandr on 04/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ASStudentSubjectTypeBiology         = 1 << 0,
    ASStudentSubjectTypeMath            = 1 << 1,
    ASStudentSubjectTypeDevelopment     = 1 << 2,
    ASStudentSubjectTypeEngineering     = 1 << 3,
    ASStudentSubjectTypeArt             = 1 << 4,
    ASStudentSubjectTypePsychology      = 1 << 5,
    ASStudentSubjectTypeAnatomy         = 1 << 6
} ASStudentSubjectType;

NS_ASSUME_NONNULL_BEGIN

@interface ASStudent : NSObject

@property (assign, nonatomic) ASStudentSubjectType subjectType;

//@property (assign, nonatomic) BOOL studiesBiology;
//@property (assign, nonatomic) BOOL studiesMath;
//@property (assign, nonatomic) BOOL studiesDevelopment;
//@property (assign, nonatomic) BOOL studiesEngineering;
//@property (assign, nonatomic) BOOL studiesArt;
//@property (assign, nonatomic) BOOL studiesPhycology;
//@property (assign, nonatomic) BOOL studiesAnatomy;

@end

NS_ASSUME_NONNULL_END
