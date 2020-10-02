//
//  WallPost.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 27/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "DirectlyUploadedPhoto.h"
#import "Video.h"
#import "Audio.h"
#import "Document.h"
#import "Graffiti.h"
#import "Link.h"
#import "Note.h"
#import "ApplicationContent.h"
#import "Poll.h"
#import "Photo.h"
#import "WikiPage.h"
#import "PhotoAlbum.h"
#import "PhotosList.h"
#import "MarketItem.h"
#import "MarketCollection.h"
#import "Sticker.h"
#import "Cards.h"

NS_ASSUME_NONNULL_BEGIN

struct Comments {
    NSUInteger count;
    BOOL can_post;
    BOOL groups_can_post;
};

struct Likes {
    NSUInteger count;
    BOOL user_likes;
    BOOL can_like;
    BOOL can_publish;
};

struct Reposts {
    NSUInteger count;
    BOOL user_reposted;
};

typedef NS_ENUM(NSUInteger, WallPostPostType) {
    WallPostPostTypePost,
    WallPostPostTypeCopy,
    WallPostPostTypeReply,
    WallPostPostTypePostpone,
    WallPostPostTypeSuggest
};

typedef NS_ENUM(NSUInteger, WallPostPostSourceType) {
    WallPostPostSourceTypeVK,
    WallPostPostSourceTypeWidget,
    WallPostPostSourceTypeApi,
    WallPostPostSourceTypeRSS,
    WallPostPostSourceTypeSMS
};

typedef NS_ENUM(NSUInteger, WallPostPostSourcePlatform) {
    WallPostPostSourcePlatformAndroid,
    WallPostPostSourcePlatformIPhone,
    WallPostPostSourcePlatformWPhone
};

typedef NS_ENUM(NSUInteger, WallPostPostSourceData) {
    WallPostPostSourceDataProfileActivity,
    WallPostPostSourceDataProfilePhoto,
    WallPostPostSourceDataComments,
    WallPostPostSourceDataLike,
    WallPostPostSourceDataPoll
};

struct PostSource {
    WallPostPostSourceType type;
    WallPostPostSourcePlatform platform;
    WallPostPostSourceData data;
    NSURL *url;
};

struct Place {
    NSString *ID;
    NSString *title;
    NSInteger latitude;
    NSInteger longitude;
    NSDate *created;
    NSURL *icon;
    NSString *country;
    NSString *city;
    NSInteger type;
    NSString *group_id;
    NSString *group_photo;
    NSInteger checkins;
    NSDate *updated;
    NSInteger address;
};

struct Geo {
    NSString *type;
    NSString *coordinates;
    struct Place place;
};

@interface WallPost : NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *owner_id;
@property (strong, nonatomic) NSString *from_id;
@property (strong, nonatomic) NSString *created_by;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *reply_owner_id;
@property (strong, nonatomic) NSString *reply_post_id;
@property (assign, nonatomic) BOOL friends_only;
@property (assign, nonatomic) struct Comments comments;
@property (assign, nonatomic) struct Likes likes;
@property (assign, nonatomic) struct Reposts reposts;
@property (assign, nonatomic) WallPostPostType post_type;
@property (assign, nonatomic) struct PostSource post_source;
@property (strong, nonatomic) NSArray<id <Attachment>> *attachments;
@property (assign, nonatomic) struct Geo geo;
@property (strong, nonatomic) NSString *signer_id;
@property (strong, nonatomic) NSArray<WallPost *> *history;
@property (assign, nonatomic) BOOL can_pin;
@property (assign, nonatomic) BOOL can_delete;
@property (assign, nonatomic) BOOL can_edit;
@property (assign, nonatomic) BOOL is_pinned;
@property (assign, nonatomic) BOOL marked_as_ads;
@property (assign, nonatomic) BOOL is_favorite;

+ (WallPost *)wallPostWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
