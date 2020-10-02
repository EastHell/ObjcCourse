//
//  User.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 08/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UserSex) {
    UserSexNotSpecified = 0,
    UserSexFemale,
    UserSexMale
};

typedef NS_ENUM(NSUInteger, UserRelativeType) {
    UserRelativeTypeSibling,
    UserRelativeTypeParent,
    UserRelativeTypeChild,
    UserRelativeTypeGrandparent,
    UserRelativeTypeGrandchild
};

typedef NS_ENUM(NSUInteger, UserRelation) {
    UserRelationSingle = 1,
    UserRelationInARelationship,
    UserRelationEngaged,
    UserRelationMarried,
    UserRelationItIsComplicated,
    UserRelationActivelySearching,
    UserRelationInLove
};

typedef NS_ENUM(NSUInteger, UserPersonalPolitical) {
    UserPersonalPoliticalCommunist = 1,
    UserPersonalPoliticalSocialist,
    UserPersonalPoliticalModerate,
    UserPersonalPoliticalLiberal,
    UserPersonalPoliticalConservative,
    UserPersonalPoliticalMonarchist,
    UserPersonalPoliticalUltraconservative,
    UserPersonalPoliticalApathetic,
    UserPersonalPoliticalLibertian
};

typedef NS_ENUM(NSUInteger, UserPersonalPeopleMain) {
    UserPersonalPeopleMainIntellectAndCreativity = 1,
    UserPersonalPeopleMainKindnessAndHonesty,
    UserPersonalPeopleMainHealthAndBeauty,
    UserPersonalPeopleMainWealthAndPower,
    UserPersonalPeopleMainCourageAndPersistance,
    UserPersonalPeopleMainHumorAndLoveForLife
};

typedef NS_ENUM(NSUInteger, UserPersonalLifeMain) {
    UserPersonalLifeMainFamilyAndChildren = 1,
    UserPersonalLifeMainCareerAndMoney,
    UserPersonalLifeMainEntertainmentAndLeisure,
    UserPersonalLifeMainScienceAndResearch,
    UserPersonalLifeMainImprovingTheWorld,
    UserPersonalLifeMainPersonalDevelopment,
    UserPersonalLifeMainBeautyAndArt,
    UserPersonalLifeMainFameAndInfluence
};

typedef NS_ENUM(NSUInteger, UserPersonalSmoking) {
    UserPersonalSmokingVeryNegative = 1,
    UserPersonalSmokingNegative,
    UserPersonalSmokingNeutral,
    UserPersonalSmokingCompromisable,
    UserPersonalSmokingPositive
};

typedef NS_ENUM(NSUInteger, UserPersonalAlcohol) {
    UserPersonalAlcoholVeryNegative = 1,
    UserPersonalAlcoholNegative,
    UserPersonalAlcoholNeutral,
    UserPersonalAlcoholCompromisable,
    UserPersonalAlcoholPositive
};

struct Contacts {
    NSString *mobilePhone;
    NSString *homePhone;
};

struct Education {
    NSString *university;
    NSString *universityName;
    NSString *faculty;
    NSString *facultyName;
    NSString *graduation;
};

struct University {
    NSString *ID;
    NSString *country;
    NSString *city;
    NSString *name;
    NSString *faculty;
    NSString *facultyName;
    NSString *chair;
    NSString *chairName;
    NSString *graduation;
};

struct School {
    NSString *ID;
    NSString *country;
    NSString *city;
    NSString *name;
    NSString *yearFrom;
    NSString *yearTo;
    NSString *yearGraduated;
    NSString *schoolClass;
    NSString *speciality;
    NSString *type;
    NSString *typeStr;
};

struct LastSeen {
    NSString *time;
    NSString *platform;
};

struct Counters {
    NSUInteger albums;
    NSUInteger videos;
    NSUInteger audios;
    NSUInteger notes;
    NSUInteger friends;
    NSUInteger groups;
    NSUInteger onlineFriends;
    NSUInteger mutualFriends;
    NSUInteger userVideos;
    NSUInteger followers;
    NSUInteger userPhotos;
    NSUInteger subscriptions;
};

struct Occupation {
    NSString *type;
    NSUInteger ID;
    NSString *name;
};

struct Relative {
    NSString *ID;
    UserRelativeType type;
};

struct Personal {
    UserPersonalPolitical political;
    NSString *languages;
    NSString *religion;
    NSString *inspiredBy;
    UserPersonalPeopleMain peopleMain;
    UserPersonalLifeMain lifeMain;
    UserPersonalSmoking smoking;
    UserPersonalAlcohol alcohol;
};

@interface User : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) BOOL deactivated;
@property (assign, nonatomic) BOOL hidden;
@property (assign, nonatomic) BOOL verified;
@property (assign, nonatomic) BOOL blackListed;
@property (assign, nonatomic) UserSex sex;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *homeTown;
@property (strong, nonatomic) NSURL *photo50URL;
@property (strong, nonatomic) NSURL *photo100URL;
@property (strong, nonatomic) NSURL *photo200origURL;
@property (strong, nonatomic) NSURL *photo200URL;
@property (strong, nonatomic) NSURL *photo400origURL;
@property (strong, nonatomic) NSURL *photoMaxURL;
@property (strong, nonatomic) NSURL *photoMaxOrigURL;
@property (assign, nonatomic) BOOL online;
@property (strong, nonatomic) NSString *lists;
@property (strong, nonatomic) NSString *domain;
@property (assign, nonatomic) BOOL hasMobile;
@property (assign, nonatomic) struct Contacts contacts;
@property (strong, nonatomic) NSURL *site;
@property (assign, nonatomic) struct Education education;
@property (strong, nonatomic) NSArray *universities;
@property (strong, nonatomic) NSArray *schools;
@property (strong, nonatomic) NSString *status;
@property (assign, nonatomic) struct LastSeen lastSeen;
@property (assign, nonatomic) NSUInteger followersCount;
@property (assign, nonatomic) NSUInteger commonCount;
@property (assign, nonatomic) struct Counters counters;
@property (assign, nonatomic) struct Occupation occupation;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSArray *relatives;
@property (assign, nonatomic) UserRelation relation;
@property (assign, nonatomic) struct Personal personal;
@property (strong, nonatomic) NSArray *connections;
@property (strong, nonatomic) NSArray *exports;
@property (assign, nonatomic) BOOL wallComments;
@property (strong, nonatomic) NSString *activities;
@property (strong, nonatomic) NSString *interests;
@property (strong, nonatomic) NSString *music;
@property (strong, nonatomic) NSString *movies;
@property (strong, nonatomic) NSString *tv;
@property (strong, nonatomic) NSString *books;
@property (strong, nonatomic) NSString *games;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSString *quotes;
@property (assign, nonatomic) BOOL canPosts;
@property (assign, nonatomic) BOOL canSeeAllPosts;
@property (assign, nonatomic) BOOL canSeeAudio;
@property (assign, nonatomic) BOOL canWritePrivateMessage;
@property (assign, nonatomic) NSInteger timezone;
@property (strong, nonatomic) NSString *screenName;

+ (User *)userWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
