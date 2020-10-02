//
//  Group.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GroupClosed) {
    GroupClosedOpen = 0,
    GroupClosedClosed,
    GroupClosedPrivate
};

typedef NS_ENUM(NSUInteger, GroupAdminLevel) {
    GroupAdminLevelModerator = 1,
    GroupAdminLevelEditor,
    GroupAdminLevelAdministrator
};

typedef NS_ENUM(NSUInteger, GroupType) {
    GroupTypeGroup,
    GroupTypePublicPage,
    GroupTypeEvent
};

struct Place {
    NSString *pid;
    NSString *title;
    double latitude;
    double longitude;
    NSString *type;
    NSString *country;
    NSString *city;
    NSString *address;
};

@interface Group : NSObject

@property (strong, nonatomic) NSString *gid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screen_name;
@property (assign, nonatomic) GroupClosed is_closed;
@property (assign, nonatomic) BOOL is_admin;
@property (assign, nonatomic) GroupAdminLevel admin_level;
@property (assign, nonatomic) BOOL is_member;
@property (assign, nonatomic) GroupType type;
@property (strong, nonatomic) NSURL *photo;
@property (strong, nonatomic) NSURL *photo_medium;
@property (strong, nonatomic) NSURL *photo_big;
@property (assign, nonatomic) BOOL *is_messages_allowed;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (assign, nonatomic) struct Place place;
@property (strong, nonatomic) NSString *communityDescription;
@property (strong, nonatomic) NSString *wiki_page;
@property (assign, nonatomic) NSUInteger members_count;
@property (strong, nonatomic) NSDictionary *counters;
@property (strong, nonatomic) NSDate *start_date;
@property (strong, nonatomic) NSDate *end_date;
@property (assign, nonatomic) BOOL can_post;
@property (assign, nonatomic) BOOL can_see_all_posts;
@property (strong, nonatomic) NSString *activity;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *contacts;

+ (Group *)groupWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
