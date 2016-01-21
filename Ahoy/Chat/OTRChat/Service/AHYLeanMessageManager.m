//
//  AHYLeanMessageManager.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYLeanMessageManager.h"
#import "AHYDatabaseManager.h"
#import "OTRMessage.h"
#import "OTRBuddy.h"
#import "AHYReservationItem.h"
#import "AHYCommentItem.h"

#define kApplicationId @"y50bn2y6zwrrdgd79xuwtcsavci7wa889d9398d4fjzsyq0f"
#define kClientKey @"43ikwjhy6vkrcvym8y5wslpwksra17ro18ebsl7y6tx36wby"

@interface AHYLeanMessageManager()<AVIMClientDelegate>
{
    
}
@property (nonatomic, strong) AVIMClient *leanClient;

@property (nonatomic, copy) NSString *selfClientID;

@property (nonatomic, strong) AVIMConversation *currentConversation;

@property (nonatomic, strong) NSMutableArray* recentConversations;

@end

@implementation AHYLeanMessageManager

#pragma mark - init and setup
+ (void)setupApplication
{
    [AVOSCloud setApplicationId:kApplicationId clientKey:kClientKey];
#ifdef DEBUG
    [AVAnalytics setAnalyticsEnabled:NO];
    [AVOSCloud setVerbosePolicy:kAVVerboseShow];
    [AVLogger addLoggerDomain:AVLoggerDomainIM];
    [AVLogger addLoggerDomain:AVLoggerDomainCURL];
    [AVLogger setLoggerLevelMask:AVLoggerLevelAll];
#endif
}

+ (instancetype)sharedInstance
{
    static AHYLeanMessageManager *leanChatManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        leanChatManager = [[AHYLeanMessageManager alloc] init];
    });
    return leanChatManager;
}

- (void)setup {
    self.leanClient = [[AVIMClient alloc] init];
    self.leanClient.delegate = self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - getter

- (NSString *)clientID
{
    return _selfClientID;
}

- (AVIMConversation *)currentConversation
{
    return _currentConversation;
}

#pragma mark - public API For message delivery

- (void)openSessionWithClientID:(NSString *)clientID completion:(void (^)(BOOL succeeded, NSError *error))completion
{
    self.selfClientID = clientID;
    if (self.leanClient.status == AVIMClientStatusNone) {
        [self.leanClient openWithClientId:clientID callback:completion];
    } else {
        [self.leanClient closeWithCallback:^(BOOL succeeded, NSError *error) {
            [self.leanClient openWithClientId:clientID callback:completion];
        }];
    }
}

- (void)createConversationsWithClientIDs:(NSArray *)clientIDs
                        conversationType:(ConversationType)conversationType
{
    NSMutableArray *targetClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
    [targetClientIDs insertObject:self.selfClientID atIndex:0];
    
    AVIMConversationQuery *query = [self.leanClient conversationQuery];
    NSMutableArray *queryClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
    [query orderByDescending:@"createdAt"];
    [query whereKey:kAVIMKeyMember containsAllObjectsInArray:queryClientIDs];
    [query whereKey:AVIMAttr(@"type") equalTo:[NSNumber numberWithInt:conversationType]];
    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        if (error) {
            // 出错了，请稍候重试
            DLog(@"error occurred while create Conversation:%@",error.description);
        } else if (!objects || [objects count] < 1) {
            // 新建一个对话
            [self.leanClient createConversationWithName:nil
                                              clientIds:queryClientIDs
                                             attributes:@{@"type":[NSNumber numberWithInt:conversationType]}
                                                options:AVIMConversationOptionNone
                                               callback:^(AVIMConversation *conversation, NSError *error) {
                                                   self.currentConversation = conversation;
                                               }];
        } else {
            // 已经有一个对话存在，继续在这一对话中聊天
            AVIMConversation *conversation = [objects lastObject];
            self.currentConversation = conversation;
        }
    }];
    
}

- (void)createConversationsWithClientIDs:(NSArray *)clientIDs
                        conversationType:(ConversationType)conversationType
                              completion:(AVIMConversationResultBlock)completion
{
    NSMutableArray *targetClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
    [targetClientIDs insertObject:self.selfClientID atIndex:0];
    
    
    //record the conversation;
    AVIMConversationResultBlock newCompletion = ^(AVIMConversation *conversation, NSError *error)
    {
        self.currentConversation = conversation;
        if (completion) {
            completion(conversation,error);
        }
    };
    [self createConversationsOnClientIDs:targetClientIDs conversationType:conversationType completion:newCompletion];
}

- (void)fetchRecentConversationsWithBlock:(AVIMArrayResultBlock)block{
    AVIMConversationQuery* query=[self.leanClient conversationQuery];
    [query whereKey:kAVIMKeyMember containedIn:@[self.selfClientID]];
    query.limit=1000;
    [query findConversationsWithCallback:block];
}


#pragma mark - private API
- (void)createConversationsOnClientIDs:(NSArray *)clientIDs
                      conversationType:(int)conversationType
                            completion:(AVIMConversationResultBlock)completion {
    AVIMConversationQuery *query = [self.leanClient conversationQuery];
    NSMutableArray *queryClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
    [query orderByDescending:@"createdAt"];
    [query whereKey:kAVIMKeyMember containsAllObjectsInArray:queryClientIDs];
    [query whereKey:AVIMAttr(@"type") equalTo:[NSNumber numberWithInt:conversationType]];
    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        if (error) {
            // 出错了，请稍候重试
            completion(nil,error);
        } else if (!objects || [objects count] < 1) {
            // 新建一个对话
            [self.leanClient createConversationWithName:nil
                                              clientIds:queryClientIDs
                                             attributes:@{@"type":[NSNumber numberWithInt:conversationType]}
                                                options:AVIMConversationOptionNone
                                               callback:completion];
        } else {
            // 已经有一个对话存在，继续在这一对话中聊天
            AVIMConversation *conversation = [objects lastObject];
            completion(conversation,nil);
        }
    }];
}


#pragma - mark sendMesage

- (void)sendCommonMessage:(AVIMMessage *)message completion:(void (^)(void))completion
{
    [self.currentConversation sendMessage:message callback:^(BOOL succeeded, NSError *error)
     {
         if (succeeded) {
             if (completion) {
                 completion();
             }
         }else
         {
             DLog(@"send message error :%@",error.description);
         }
     }];
}

- (void)sendTypeMessage:(AVIMTypedMessage *)message completion:(void (^)(void))completion
{
    __block OTRMessage *msg = [[OTRMessage alloc] init];
    
    if ([message isKindOfClass:[AVIMTextMessage class]]) {
        AVIMTextMessage *textMessage = (AVIMTextMessage *)message;
        msg.text = textMessage.text;
    }
    msg.buddyUniqueId = message.clientId;
    msg.read = YES;
    msg.transportedSecurely = NO;
    msg.incoming = NO;
    msg.delivered = NO;
    msg.transporting = YES;
    
    __block OTRBuddy *buddy = nil;
    
    [self.currentConversation sendMessage:message callback:^(BOOL succeeded, NSError *error)
     {
         if (succeeded) {
             if (completion) {
                 completion();
                 [[AHYDatabaseManager sharedInstance].readWriteDatabaseConnection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
                     buddy = [msg buddyWithTransaction:transaction];
                     msg.delivered = YES;
                     msg.transporting = NO;
                     [msg saveWithTransaction:transaction];
                     buddy.lastMessageDate = msg.date;
                     [buddy saveWithTransaction:transaction];
                 }];
             }
         }else{
             [[AHYDatabaseManager sharedInstance].readWriteDatabaseConnection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
                 buddy = [msg buddyWithTransaction:transaction];
                 [msg saveWithTransaction:transaction];
                 buddy.lastMessageDate = msg.date;
                 [buddy saveWithTransaction:transaction];
             }];
             DLog(@"send message error :%@",error.description);
         }
     }];
}


#pragma mark - AVIMClientDelegate


- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message
{
    // 接收到新的普通消息
    
    __block OTRMessage *msg = [[OTRMessage alloc] init];
    msg.buddyUniqueId = message.clientId;
    msg.text = message.content;
    msg.read = [self.currentConversation.members containsObject:message.clientId];
    msg.incoming = YES;
    msg.transportedSecurely = NO;
    msg.date  = [NSDate dateWithTimeIntervalSince1970:message.deliveredTimestamp];
    __block OTRBuddy *buddy = nil;

    
    NSString *userID = message.clientId;
    
    __weak typeof(self)weakSelf = self;
    [[AHYDatabaseManager sharedInstance].readWriteDatabaseConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        buddy = [OTRBuddy fetchObjectWithUniqueID:userID transaction:transaction];
        if (!buddy)
        {

            buddy = [[OTRBuddy alloc] initWithUniqueId:userID];
            buddy.lastMessageDate = msg.date;
            buddy.accountUniqueId = self.selfClientID;
            [[AHYDatabaseManager sharedInstance].readWriteDatabaseConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction *stransaction) {
                [msg saveWithTransaction:stransaction];
                [buddy saveWithTransaction:stransaction];
            }];
        }
        else
        {
            [msg saveWithTransaction:transaction];
            buddy.lastMessageDate = msg.date;
            [buddy saveWithTransaction:transaction];
        }
        
        if (!msg.isRead)
        {
            [weakSelf updateIconBadgeNumber];
            [OTRMessage showLocalNotificationForMessage:msg];
        }
    }];
    
    
}

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message
{
    // 接收到新的富媒体消息
    __block OTRMessage *msg = [[OTRMessage alloc] init];
    __block AHYCommentItem *commentItem = nil;
    __block AHYReservationItem *reservationItem = nil;
    
    msg.buddyUniqueId = message.clientId;
    if([message isKindOfClass:[AVIMTextMessage class]])
    {
        msg.text = ((AVIMTextMessage *)message).text;
//        NSDictionary *attrDict = message.attributes;
//        if (attrDict.count > 0) {
//            NSString *type = [[attrDict valueForKey:@"ahy_type"] stringValue];
//            if ([type isEqualToString:AHYReservationType])
//            {
//                //need reset maybe starttime and endtime or starttime and duration;
//                reservationItem = [[AHYReservationItem alloc] init];
//                reservationItem.rsvDate = [[attrDict valueForKey:@"rsv_date"] stringValue];
//                reservationItem.rsvTime = [[attrDict valueForKey:@"rsv_date"] stringValue];
//                reservationItem.rsvNote = [[attrDict valueForKey:@"rsv_note"] stringValue];
//            }
//            else if([type isEqualToString:AHYCommentType])
//            {
//                commentItem = [[AHYCommentItem alloc] init];
//                commentItem.rate = [[attrDict valueForKey:@"comment_rate"] integerValue];
//            }
//        }
    }
    
    msg.read = [self.currentConversation.members containsObject:message.clientId];
    msg.incoming = YES;
    msg.transportedSecurely = NO;
    msg.date  = [NSDate dateWithTimeIntervalSince1970:(message.sendTimestamp/1000)];
    __block OTRBuddy *buddy = nil;

    NSString *userID = message.clientId;
    __weak typeof(self)weakSelf = self;
    [[AHYDatabaseManager sharedInstance].readWriteDatabaseConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        buddy = [OTRBuddy fetchObjectWithUniqueID:userID transaction:transaction];
        if (!buddy)
        {

            buddy = [[OTRBuddy alloc] initWithUniqueId:userID];
            buddy.lastMessageDate = msg.date;
            [[AHYDatabaseManager sharedInstance].readWriteDatabaseConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction *stransaction) {
                [msg saveWithTransaction:stransaction];
                [buddy saveWithTransaction:stransaction];
            }];
        }
        else
        {
            [msg saveWithTransaction:transaction];
            buddy.lastMessageDate = msg.date;
            [buddy saveWithTransaction:transaction];
        }
        
        if (!msg.isRead)
        {
            [weakSelf updateIconBadgeNumber];
            [OTRMessage showLocalNotificationForMessage:msg];
        }
    }];
    
    
}

- (void)client:(AVIMClient *)client didOfflineWithError:(NSError *)error {
    NSLog(@"offline error:%@", error);
}

-(void)updateIconBadgeNumber
{
    NSInteger unread = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unread+1];
}


@end
