//
//  AHYDatabaseView.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYDatabaseView.h"
#import "YapDatabaseView.h"
#import "YapDatabase.h"
#import "AHYDatabaseManager.h"
#import "OTRBuddy.h"

#import "OTRMessage.h"
#import "YapDatabaseFullTextSearch.h"
#import "YapDatabaseFilteredView.h"

NSString *AHYConversationDatabaseViewExtensionName = @"AHYConversationDatabaseViewExtensionName";
NSString *AHYBlockedBuddyDatabaseViewExtensionName = @"AHYBlockedBuddyDatabaseViewExtensionName";
NSString *AHYChatDatabaseViewExtensionName = @"AHYChatDatabaseViewExtensionName";
NSString *AHYAllAccountDatabaseViewExtensionName = @"AHYAllAccountDatabaseViewExtensionName";
NSString *AHYBuddyNameSearchDatabaseViewExtensionName = @"AHYBuddyBuddyNameSearchDatabaseViewExtensionName";
NSString *AHYAllBuddiesDatabaseViewExtensionName = @"AHYAllBuddiesDatabaseViewExtensionName";
NSString *AHYAllSubscriptionRequestsViewExtensionName = @"AllSubscriptionRequestsViewExtensionName";
NSString *AHYAllPushAccountInfoViewExtensionName = @"AHYAllPushAccountInfoViewExtensionName";
NSString *AHYUnreadMessagesViewExtensionName = @"AHYUnreadMessagesViewExtensionName";


NSString *AHYAllAccountGroup = @"All Accounts";
NSString *AHYConversationGroup = @"Conversation";
NSString *AHYBlockedGroup = @"BlockedGroup";
NSString *AHYChatMessageGroup = @"Messages";
NSString *AHYBuddyGroup = @"Buddy";
NSString *AHYUnreadMessageGroup = @"Unread Messages";
NSString *AHYAllPresenceSubscriptionRequestGroup = @"AHYAllPresenceSubscriptionRequestGroup";

NSString *AHYPushTokenGroup = @"Tokens";
NSString *AHYPushDeviceGroup = @"Devices";
NSString *AHYPushAccountGroup = @"Account";



@implementation AHYDatabaseView

/*
 *register the conversation list view.
 *
 */
+ (BOOL)registerConversationDatabaseView
{
    YapDatabaseView *conversationView = [[AHYDatabaseManager sharedInstance].database registeredExtension:AHYConversationDatabaseViewExtensionName];
    if (conversationView) {
        return YES;
    }
    
    YapDatabaseViewGrouping *viewGrouping = [YapDatabaseViewGrouping withObjectBlock:^NSString *(YapDatabaseReadTransaction *transaction,NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[OTRBuddy class]])
        {
            OTRBuddy *buddy = (OTRBuddy *)object;
            if (buddy.lastMessageDate && !buddy.blocking) {
                return AHYConversationGroup;
            }
        }
        return nil; // exclude from view
    }];
    
    YapDatabaseViewSorting *viewSorting = [YapDatabaseViewSorting withObjectBlock:^NSComparisonResult(YapDatabaseReadTransaction *transaction,NSString *group, NSString *collection1, NSString *key1, id object1, NSString *collection2, NSString *key2, id object2) {
        if ([group isEqualToString:AHYConversationGroup]) {
            if ([object1 isKindOfClass:[OTRBuddy class]] && [object2 isKindOfClass:[OTRBuddy class]]) {
                OTRBuddy *buddy1 = (OTRBuddy *)object1;
                OTRBuddy *buddy2 = (OTRBuddy *)object2;
                return [buddy2.lastMessageDate compare:buddy1.lastMessageDate];
            }
        }
        return NSOrderedSame;
    }];
    
    YapDatabaseViewOptions *options = [[YapDatabaseViewOptions alloc] init];
    options.isPersistent = YES;
    options.allowedCollections = [[YapWhitelistBlacklist alloc] initWithWhitelist:[NSSet setWithObject:[OTRBuddy collection]]];
    
    YapDatabaseView *databaseView = [[YapDatabaseView alloc] initWithGrouping:viewGrouping
                                                                      sorting:viewSorting
                                                                   versionTag:@"1"
                                                                      options:options];
    return [[AHYDatabaseManager sharedInstance].database registerExtension:databaseView withName:AHYConversationDatabaseViewExtensionName];
}

+ (BOOL)registerBlockedBuddyDatabaseView
{
    YapDatabaseView *blockedView = [[AHYDatabaseManager sharedInstance].database registeredExtension:AHYBlockedBuddyDatabaseViewExtensionName];
    if (blockedView) {
        return YES;
    }
    
    YapDatabaseViewGrouping *viewGrouping = [YapDatabaseViewGrouping withObjectBlock:^NSString *(YapDatabaseReadTransaction *transaction, NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[OTRBuddy class]])
        {
            OTRBuddy *buddy = (OTRBuddy *)object;
            if (buddy.lastMessageDate && buddy.blocking) {
                return AHYBlockedGroup;
            }
        }
        return nil; // exclude from view
    }];
    
    YapDatabaseViewSorting *viewSorting = [YapDatabaseViewSorting withObjectBlock:^NSComparisonResult(YapDatabaseReadTransaction *transaction, NSString *group, NSString *collection1, NSString *key1, id object1, NSString *collection2, NSString *key2, id object2) {
        if ([group isEqualToString:AHYBlockedGroup]) {
            if ([object1 isKindOfClass:[OTRBuddy class]] && [object2 isKindOfClass:[OTRBuddy class]]) {
                OTRBuddy *buddy1 = (OTRBuddy *)object1;
                OTRBuddy *buddy2 = (OTRBuddy *)object2;
                return [buddy2.lastMessageDate compare:buddy1.lastMessageDate];
            }
        }
        return NSOrderedSame;
    }];
    
    YapDatabaseViewOptions *options = [[YapDatabaseViewOptions alloc] init];
    options.isPersistent = YES;
    options.allowedCollections = [[YapWhitelistBlacklist alloc] initWithWhitelist:[NSSet setWithObject:[OTRBuddy collection]]];
    
    YapDatabaseView *databaseView = [[YapDatabaseView alloc] initWithGrouping:viewGrouping
                                                                      sorting:viewSorting
                                                                   versionTag:@"1"
                                                                      options:options];
    return [[AHYDatabaseManager sharedInstance].database registerExtension:databaseView withName:AHYBlockedBuddyDatabaseViewExtensionName];
}

+ (BOOL)registerChatDatabaseView
{
    if ([[AHYDatabaseManager sharedInstance].database registeredExtension:AHYChatDatabaseViewExtensionName]) {
        return YES;
    }
    
    YapDatabaseViewGrouping *viewGrouping = [YapDatabaseViewGrouping withObjectBlock:^NSString *(YapDatabaseReadTransaction *transaction, NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[OTRMessage class]])
        {
            return ((OTRMessage *)object).buddyUniqueId;
        }
        return nil;
    }];
    
    YapDatabaseViewSorting *viewSorting = [YapDatabaseViewSorting withObjectBlock:^NSComparisonResult(YapDatabaseReadTransaction *transaction, NSString *group, NSString *collection1, NSString *key1, id object1, NSString *collection2, NSString *key2, id object2) {
        if ([object1 isKindOfClass:[OTRMessage class]] && [object2 isKindOfClass:[OTRMessage class]]) {
            OTRMessage *message1 = (OTRMessage *)object1;
            OTRMessage *message2 = (OTRMessage *)object2;
            
            return [message1.date compare:message2.date];
        }
        return NSOrderedSame;
    }];
    
    YapDatabaseViewOptions *options = [[YapDatabaseViewOptions alloc] init];
    options.isPersistent = YES;
    options.allowedCollections = [[YapWhitelistBlacklist alloc] initWithWhitelist:[NSSet setWithObject:[OTRMessage collection]]];
    
    
    
    YapDatabaseView *view = [[YapDatabaseView alloc] initWithGrouping:viewGrouping
                                                              sorting:viewSorting
                                                           versionTag:@"1"
                                                              options:options];
    return [[AHYDatabaseManager sharedInstance].database registerExtension:view withName:AHYChatDatabaseViewExtensionName];
}

+ (BOOL)registerBuddyNameSearchDatabaseView
{
    if ([[AHYDatabaseManager sharedInstance].database registeredExtension:AHYBuddyNameSearchDatabaseViewExtensionName]) {
        return YES;
    }
    
    NSArray *propertiesToIndex = @[OTRBuddyAttributes.userName,OTRBuddyAttributes.displayName];
    
    YapDatabaseFullTextSearchHandler *searchHandler = [YapDatabaseFullTextSearchHandler withObjectBlock:^(NSMutableDictionary *dict, NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[OTRBuddy class]])
        {
            OTRBuddy *buddy = (OTRBuddy *)object;
            
            if([buddy.uniqueId length]) {
                [dict setObject:buddy.uniqueId forKey:OTRBuddyAttributes.userName];
            }
            
            if ([buddy.displayName length]) {
                [dict setObject:buddy.displayName forKey:OTRBuddyAttributes.displayName];
            }
            
            
        }
    }];
    
    YapDatabaseFullTextSearch *fullTextSearch = [[YapDatabaseFullTextSearch alloc] initWithColumnNames:propertiesToIndex handler:searchHandler];
    
    return [[AHYDatabaseManager sharedInstance].database registerExtension:fullTextSearch withName:AHYBuddyNameSearchDatabaseViewExtensionName];
}

+ (BOOL)registerAllBuddiesDatabaseView
{
    if ([[AHYDatabaseManager sharedInstance].database registeredExtension:AHYAllBuddiesDatabaseViewExtensionName]) {
        return YES;
    }
    
    YapDatabaseViewGrouping *viewGrouping = [YapDatabaseViewGrouping withObjectBlock:^NSString *(YapDatabaseReadTransaction *transaction, NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[OTRBuddy class]]) {
            return AHYBuddyGroup;
        }
        return nil;
    }];
    
    YapDatabaseViewSorting *viewSorting = [YapDatabaseViewSorting withObjectBlock:^NSComparisonResult(YapDatabaseReadTransaction *transaction, NSString *group, NSString *collection1, NSString *key1, id object1, NSString *collection2, NSString *key2, id object2) {
        
        OTRBuddy *buddy1 = (OTRBuddy *)object1;
        OTRBuddy *buddy2 = (OTRBuddy *)object2;
        
        if (buddy1.status == buddy2.status) {
            NSString *buddy1String = buddy1.uniqueId;
            NSString *buddy2String = buddy2.uniqueId;
            
            if ([buddy1.displayName length]) {
                buddy1String = buddy1.displayName;
            }
            
            if ([buddy2.displayName length]) {
                buddy2String = buddy2.displayName;
            }
            
            return [buddy1String compare:buddy2String options:NSCaseInsensitiveSearch];
        }
        else if (buddy1.status < buddy2.status) {
            return NSOrderedAscending;
        }
        else{
            return NSOrderedDescending;
        }
    }];
    
    
    YapDatabaseViewOptions *options = [[YapDatabaseViewOptions alloc] init];
    options.isPersistent = YES;
    options.allowedCollections = [[YapWhitelistBlacklist alloc] initWithWhitelist:[NSSet setWithObject:[OTRBuddy collection]]];
    
    YapDatabaseView *view = [[YapDatabaseView alloc] initWithGrouping:viewGrouping
                                                              sorting:viewSorting
                                                           versionTag:@"1"
                                                              options:options];
    return [[AHYDatabaseManager sharedInstance].database registerExtension:view withName:AHYAllBuddiesDatabaseViewExtensionName];
    
}

+ (BOOL)registerUnreadMessagesView
{
    
    YapDatabaseViewFiltering *viewFiltering = [YapDatabaseViewFiltering withObjectBlock:^BOOL(YapDatabaseReadTransaction *transaction,NSString *group, NSString *collection, NSString *key, id object) {
        
        if ([object isKindOfClass:[OTRMessage class]]) {
            return !((OTRMessage *)object).isRead;
        }
        return NO;
    }];
    
    YapDatabaseFilteredView *filteredView = [[YapDatabaseFilteredView alloc] initWithParentViewName:AHYChatDatabaseViewExtensionName
                                                                                          filtering:viewFiltering];
    
    
    return [[AHYDatabaseManager sharedInstance].database registerExtension:filteredView withName:AHYUnreadMessagesViewExtensionName];
}







@end
