//
//  ASStudent.m
//  BitwiseTest
//
//  Created by Aleksandr on 04/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (NSString *)description
{
    return [NSString stringWithFormat:@"Student studies:\r"
                                        "biology = %@\r"
                                        "math = %@\r"
                                        "development = %@\r"
                                        "engineering = %@\r"
                                        "art = %@\r"
                                        "psychology = %@\r"
                                        "anatomy = %@",
                                        [self answerByType:ASStudentSubjectTypeBiology],
                                        [self answerByType:ASStudentSubjectTypeMath],
                                        [self answerByType:ASStudentSubjectTypeDevelopment],
                                        [self answerByType:ASStudentSubjectTypeEngineering],
                                        [self answerByType:ASStudentSubjectTypeArt],
                                        [self answerByType:ASStudentSubjectTypePsychology],
                                        [self answerByType:ASStudentSubjectTypeAnatomy]];
}

- (NSString *)answerByType:(ASStudentSubjectType)type {
    return self.subjectType & type ? @"yes" : @"no";
}

@end
