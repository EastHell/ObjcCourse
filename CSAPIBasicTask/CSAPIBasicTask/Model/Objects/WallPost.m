//
//  WallPost.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 27/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "WallPost.h"

@implementation WallPost

+ (WallPost *)wallPostWithJson:(NSDictionary *)json {
    
    WallPost *newPost = [WallPost new];
    
    newPost.text = [json objectForKey:@"text"];
    
    NSArray *attachments = [json objectForKey:@"attachments"];
    
    NSMutableArray<id <Attachment>> *attachmentsArray = [NSMutableArray new];
    
    [attachments enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull attachment, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *type = [attachment objectForKey:@"type"];
        NSDictionary *attachmentDictionary = [attachment objectForKey:type];;
        
        if ([type isEqualToString:@"photo"]) {
            [attachmentsArray addObject:[Photo photoWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"posted_photo"]) {
            [attachmentsArray addObject:[DirectlyUploadedPhoto directlyUploadedPhotoWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"video"]) {
            [attachmentsArray addObject:[Video videoWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"audio"]) {
            [attachmentsArray addObject:[Audio audioWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"doc"]) {
            [attachmentsArray addObject:[Document documentWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"graffiti"]) {
            [attachmentsArray addObject:[Graffiti graffitiWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"link"]) {
            [attachmentsArray addObject:[Link linkWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"note"]) {
            [attachmentsArray addObject:[Note noteWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"app"]) {
            [attachmentsArray addObject:[ApplicationContent applicationContentWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"poll"]) {
            [attachmentsArray addObject:[Poll pollWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"page"]) {
            [attachmentsArray addObject:[WikiPage wikiPageWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"album"]) {
            [attachmentsArray addObject:[PhotoAlbum photoAlbumWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"photos_list"]) {
            [attachmentsArray addObject:[PhotosList photosListWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"market"]) {
            [attachmentsArray addObject:[MarketItem marketItemWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"market_album"]) {
            [attachmentsArray addObject:[MarketCollection marketCollectionWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"sticker"]) {
            [attachmentsArray addObject:[Sticker stickerWithDictionary:attachmentDictionary]];
        } else if ([type isEqualToString:@"pretty_cards"]) {
            [attachmentsArray addObject:[Cards cardsWithDictionary:attachmentDictionary]];
        }
    }];
    
    newPost.attachments = [attachmentsArray copy];
    
    //NSLog(@"%@", [json objectForKey:@"copy_history"]);
    
    return newPost;
}

@end
