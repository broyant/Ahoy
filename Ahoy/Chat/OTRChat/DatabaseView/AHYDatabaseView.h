//
//  AHYDatabaseView.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YapDatabaseViewMappings.h"
#import "YapDatabaseView.h"

//Extension Strings
extern NSString *AHYConversationDatabaseViewExtensionName;
extern NSString *AHYBlockedBuddyDatabaseViewExtensionName;
extern NSString *AHYChatDatabaseViewExtensionName;
extern NSString *AHYAllAccountDatabaseViewExtensionName;
extern NSString *AHYBuddyNameSearchDatabaseViewExtensionName;
extern NSString *AHYAllBuddiesDatabaseViewExtensionName;
extern NSString *AHYAllSubscriptionRequestsViewExtensionName;
extern NSString *AHYAllPushAccountInfoViewExtensionName;
extern NSString *AHYUnreadMessagesViewExtensionName;

// Group Strings
extern NSString *AHYAllAccountGroup;
extern NSString *AHYConversationGroup;
extern NSString *AHYBlockedGroup;
extern NSString *AHYChatMessageGroup;
extern NSString *AHYBuddyGroup;
extern NSString *AHYUnreadMessageGroup;
extern NSString *AHYAllPresenceSubscriptionRequestGroup;

extern NSString *AHYPushAccountGroup;
extern NSString *AHYPushDeviceGroup;
extern NSString *AHYPushTokenGroup;


@interface AHYDatabaseView : NSObject

//conversation view;
+ (BOOL)registerConversationDatabaseView;

//blocked buddy view
+ (BOOL)registerBlockedBuddyDatabaseView;

//message chat view
+ (BOOL)registerChatDatabaseView;

//buddy name search view
+ (BOOL)registerBuddyNameSearchDatabaseView;

//all buddy view
+ (BOOL)registerAllBuddiesDatabaseView;

//unread message view
+ (BOOL)registerUnreadMessagesView;

@end
