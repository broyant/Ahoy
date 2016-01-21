//
//  ChatMediaFileManager.h
//  TestLeanCloud
//
//  Created by broyant on 15/10/19.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OTRMediaItem, IOCipher;

extern NSString *const kChatRootDirectory;
extern NSString *const kChatMediaDirectory;

@interface AHYChatMediaFileManager : NSObject

@property (nonatomic, strong, readonly) IOCipher *ioCipher;

- (void)setData:(NSData *)data
        forItem:(OTRMediaItem *)mediaItem
  buddyUniqueId:(NSString *)buddyUniqueId
     completion:(void (^)(NSInteger bytesWritten, NSString * filePath, NSError *error))completion
completionQueue:(dispatch_queue_t)completionQueue;

- (void)dataForItem:(OTRMediaItem *)mediaItem
      buddyUniqueId:(NSString *)buddyUniqueId
         completion:(void (^)(NSData *data, NSError *error))completion
    completionQueue:(dispatch_queue_t)completionQueue;

- (void)dataForItemID:(NSString *)itemID
        buddyUniqueId:(NSString *)buddyUniqueId
           completion:(void (^)(NSData *, NSError *))completion
      completionQueue:(dispatch_queue_t)completionQueue;

-(void)deleteMediaFileOfBuddy:(NSString *)buddyUniqueId
                   completion:(void (^)(BOOL successed, NSError *error))completion
              completionQueue:(dispatch_queue_t)completionQueue;

-(void)deleteMessage:(NSString *)mediaUniqueId
       buddyUniqueId:(NSString *)buddyUniqueId
          completion:(void (^)(BOOL successed, NSError *error))completion
     completionQueue:(dispatch_queue_t)completionQueue;

-(void)deleteAllMediaFileOfAccount:(NSString *)accountId
                        completion:(void (^)(BOOL successed, NSError *error))completion
                   completionQueue:(dispatch_queue_t)completionQueue;

- (void)emoticonName:(NSString *)imageName subName:(NSString *)subName completion:(void (^)(UIImage *image))completion;

+ (NSString *)pathForMediaItem:(OTRMediaItem *)mediaItem buddyUniqueId:(NSString *)buddyUniqueId;

+ (NSString *)pathForMediaItemUniqueId:(NSString *)uniqueId buddyUniqueId:(NSString *)buddyUniqueId;

+ (instancetype)sharedInstance;


@end
