//
//  Attachment.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 30/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AttachmentType) {
    AttachmentTypePhoto,
    AttachmentTypePostedPhoto,
    AttachmentTypeVideo,
    AttachmentTypeAudio,
    AttachmentTypeDocument,
    AttachmentTypeGraffiti,
    AttachmentTypeLink,
    AttachmentTypeNote,
    AttachmentTypeApplicationContent,
    AttachmentTypePoll,
    AttachmentTypeWikiPage,
    AttachmentTypePhotoAlbum,
    AttachmentTypePhotosList,
    AttachmentTypeMarketItem,
    AttachmentTypeMarketCollection,
    AttachmentTypeSticker,
    AttachmentTypeCards
};

@protocol Attachment <NSObject>

@property (assign, nonatomic) AttachmentType type;

+ (instancetype)attachmentWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
