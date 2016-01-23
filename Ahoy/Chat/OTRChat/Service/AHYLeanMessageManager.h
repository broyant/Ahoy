//
//  AHYLeanMessageManager.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

#define WEAKSELF typeof(self) __weak weakSelf = self;
#ifdef DEBUG
#define DLog(xx, ...) NSLog(@"%s(%d): " xx, ((strrchr(__FILE__, '/') ? : __FILE__- 1) + 1), __LINE__, ##__VA_ARGS__)
#else
#define DLog(xx, ...) ((void)0)
#endif

#define kJobsClientID @"Jobs"
#define kCookClientID @"Cook"
#define kWozClientID @"Woz"

#define kDidReceiveCommonMessageNotification @"didReceiveCommonMessageNotification"
#define kDidReceiveTypedMessageNotification @"didReceiveTypedMessageNotification"

typedef enum : NSInteger{
    ConversationTypeOneToOne = 0,
    ConversationTypeGroup = 1,
}ConversationType;

@interface AHYLeanMessageManager : NSObject

/**
 *  set up for appID and app key
 */
+ (void)setupApplication;
/**
 *  return the shared Instance,Singleton.
 *
 *  @return
 */

+ (instancetype)sharedInstance;

//+ (instancetype)manager;
/**
 *
 *  @return the client ID
 */
- (NSString *)clientID;
/**
 *  return the current Conversation
 
 *  @return
 */

- (AVIMConversation *)currentConversation;
/**
 *
 *  @param clientID   the client ID
 *  @param completion the call-back;
 */
- (void)openSessionWithClientID:(NSString *)clientID completion:(void (^)(BOOL succeeded, NSError *error))completion;
/**
 *
 *  @param clientIDs
 *  @param conversationType
 */

- (void)createConversationsWithClientIDs:(NSArray *)clientIDs conversationType:(ConversationType)conversationType;
/**
 *  create a conversation;
 *  @param clientIDs        clientIDs
 *  @param conversationType conversationType
 *  @param completion       completion
 */
- (void)createConversationsWithClientIDs:(NSArray *)clientIDs conversationType:(ConversationType)conversationType completion:(AVIMConversationResultBlock)completion;
/**
 *  return the recent conversations
 *
 *  @param block
 */
- (void)fetchRecentConversationsWithBlock:(AVIMArrayResultBlock)block;
/**
 *
 *  @param message
 *  @param completion
 */
- (void)sendCommonMessage:(AVIMMessage *)message completion:(void (^)(void))completion;
/**
 *
 *  @param message
 *  @param completion
 */
- (void)sendTypeMessage:(AVIMTypedMessage *)message completion:(void (^)(BOOL))completion;

@end
