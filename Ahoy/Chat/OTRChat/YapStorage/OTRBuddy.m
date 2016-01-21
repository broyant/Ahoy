//
//  OTRBuddy.m
//  Off the Record
//
//  Created by David Chiles on 3/28/14.
//  Copyright (c) 2014 Chris Ballinger. All rights reserved.
//

#import "OTRBuddy.h"
#import "AHYChatAccount.h"
#import "OTRMessage.h"
#import "AHYDatabaseManager.h"
#import "YapDatabaseRelationshipTransaction.h"
#import "OTRImages.h"
#import "JSQMessagesAvatarImageFactory.h"
//#import "OTRKit.h"
#import "AHYCommentItem.h"

const struct OTRBuddyAttributes OTRBuddyAttributes = {
    .userName = @"userName",
	.displayName = @"displayName",
	.composingMessageString = @"composingMessageString",
	.statusMessage = @"statusMessage",
	.chatState = @"chatState",
	.lastSentChatState = @"lastSentChatState",
	.status = @"status",
    .lastMessageDate = @"lastMessageDate",
    .avatarData = @"avatarData",
    .encryptionStatus = @"encryptionStatus",
    .companyName = @"companyName",
    .currentTopicName = @"currentTopicName",
    .extraInfoAttr = @"extraInfoAttr"
};

const struct OTRBuddyRelationships OTRBuddyRelationships = {
	.accountUniqueId = @"accountUniqueId",
};

const struct OTRBuddyEdges OTRBuddyEdges = {
	.account = @"account",
};

@implementation OTRBuddy

- (id)init
{
    if (self = [super init]) {
        self.status = OTRBuddyStatusOffline;
        self.chatState = kOTRChatStateUnknown;
        self.lastSentChatState = kOTRChatStateUnknown;
    }
    return self;
}

- (UIImage *)avatarImage
{
    //on setAvatar clear this buddies image cache
    //invalidate if jid or display name changes 
    return [OTRImages avatarImageWithUniqueIdentifier:self.uniqueId avatarData:self.avatarData displayName:self.displayName username:self.uniqueId];
}

- (void)setAvatarData:(NSData *)avatarData
{
    if (![_avatarData isEqualToData: avatarData]) {
        _avatarData = avatarData;
        [OTRImages removeImageWithIdentifier:self.uniqueId];
    }
}

- (void)setDisplayName:(NSString *)displayName
{
    if (![_displayName isEqualToString:displayName]) {
        _displayName = displayName;
        if (!self.avatarData) {
            [OTRImages removeImageWithIdentifier:self.uniqueId];
        }
    }
}


- (BOOL)hasMessagesWithTransaction:(YapDatabaseReadTransaction *)transaction
{
    NSUInteger numberOfMessages = [[transaction ext:AHYYapDatabaseRelationshipName] edgeCountWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection]];
    return (numberOfMessages > 0);
}

- (NSInteger)numberOfMessagesWithTransaction:(YapDatabaseReadTransaction *)transaction
{
    NSUInteger numberOfMessages = [[transaction ext:AHYYapDatabaseRelationshipName] edgeCountWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection]];
    return numberOfMessages;
}

- (void)updateLastMessageDateWithTransaction:(YapDatabaseReadTransaction *)transaction
{
    __block NSDate *date = nil;
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop) {
        OTRMessage *message = [OTRMessage fetchObjectWithUniqueID:edge.sourceKey transaction:transaction];
        if (message) {
            if (!date) {
                date = message.date;
            }
            else {
                date = [date laterDate:message.date];
            }
        }
    }];
    self.lastMessageDate = date;
}

- (NSInteger)numberOfUnreadMessagesWithTransaction:(YapDatabaseReadTransaction *)transaction
{
    __block NSUInteger count = 0;
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop) {
        OTRMessage *message = [OTRMessage fetchObjectWithUniqueID:edge.sourceKey transaction:transaction];
        if (!message.isRead) {
            count += 1;
        }
    }];
    return count;
}

- (AHYChatAccount*)accountWithTransaction:(YapDatabaseReadTransaction *)transaction
{
    return [AHYChatAccount fetchObjectWithUniqueID:self.accountUniqueId transaction:transaction];
}

- (void)setAllMessagesRead:(YapDatabaseReadWriteTransaction *)transaction
{
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop) {
        OTRMessage *message = [[OTRMessage fetchObjectWithUniqueID:edge.sourceKey transaction:transaction] copy];
        
        if (!message.isRead || message.transporting) {
            message.read = YES;
            message.transporting = NO;
            [message saveWithTransaction:transaction];
        }

    }];
}
- (OTRMessage *)lastMessageWithTransaction:(YapDatabaseReadTransaction *)transaction
{
    __block OTRMessage *finalMessage = nil;
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop) {
        OTRMessage *message = [OTRMessage fetchObjectWithUniqueID:edge.sourceKey transaction:transaction];
        if (!finalMessage || [message.date compare:finalMessage.date] == NSOrderedDescending) {
            finalMessage = message;
        }
        
    }];
    return [finalMessage copy];
}

- (NSDate *)latestPendingReversationDate:(YapDatabaseReadTransaction *)transaction
{
    NSDate *date = nil;
    
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRMessageEdges.buddy destinationKey:self.uniqueId collection:[OTRBuddy collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop) {
        OTRMessage *message = [[OTRMessage fetchObjectWithUniqueID:edge.sourceKey transaction:transaction] copy];
        if (message.extraInfoAttr && message.extraInfoAttr.count > 0 && [[[message.extraInfoAttr valueForKey:@"type"] stringValue] isEqualToString:AHYCommentType])
        {
            NSString *startTime = [[message.extraInfoAttr valueForKey:@"rsv_startDate"] stringValue];
            
        }
        

        
    }];
    

    return date;
}

#pragma - mark YapDatabaseRelationshipNode

- (NSArray *)yapDatabaseRelationshipEdges
{
    NSArray *edges = nil;
    if (self.accountUniqueId) {
        YapDatabaseRelationshipEdge *accountEdge = [YapDatabaseRelationshipEdge edgeWithName:OTRBuddyEdges.account
                                                                              destinationKey:self.accountUniqueId
                                                                                  collection:[AHYChatAccount collection]
                                                                             nodeDeleteRules:YDB_DeleteSourceIfDestinationDeleted];
        edges = @[accountEdge];
    }
    
    
    return edges;
}

#pragma - mark Class Methods

+ (instancetype)fetchBuddyForUniqueId:(NSString *)uniqueId accountId:(NSString *)accountid transaction:(YapDatabaseReadTransaction *)transaction
{
    AHYChatAccount *account = [[AHYChatAccount allAccountsWithUserid:accountid transaction:transaction] firstObject];
    return [self fetchBuddyWithUserid:uniqueId withAccountUid:account.uniqueId transaction:transaction];
}

+ (instancetype)fetchBuddyWithUserid:(NSString *)userid withAccountUid:(NSString *)accountid transaction:(YapDatabaseReadTransaction *)transaction
{
    __block OTRBuddy *finalBuddy = nil;
    
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRBuddyEdges.account destinationKey:accountid collection:[AHYChatAccount collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop) {
        OTRBuddy * buddy = [transaction objectForKey:edge.sourceKey inCollection:[OTRBuddy collection]];
        if ([buddy.uniqueId isEqualToString:userid]) {
            *stop = YES;
            finalBuddy = buddy;
        }
    }];
    
    return [finalBuddy copy];
}

+ (instancetype)fetchBuddyWithID:(NSString *)userid withAccountUid:(NSString *)accountid transaction:(YapDatabaseReadTransaction *)transaction
{
    OTRBuddy * buddy = [transaction objectForKey:userid inCollection:[OTRBuddy collection]];
    if ([buddy.accountUniqueId isEqualToString:accountid]) {
        
       return  buddy;
    }
    
    return nil;
}

+ (void)resetAllChatStatesWithTransaction:(YapDatabaseReadWriteTransaction *)transaction
{
    NSMutableArray *buddiesToChange = [NSMutableArray array];
    [transaction enumerateKeysAndObjectsInCollection:[self collection] usingBlock:^(NSString *key, OTRBuddy *buddy, BOOL *stop) {
        if(buddy.chatState != kOTRChatStateUnknown)
        {
            [buddiesToChange addObject:buddy];
        }
    }];
    
    [buddiesToChange enumerateObjectsUsingBlock:^(OTRBuddy *buddy, NSUInteger idx, BOOL *stop) {
        buddy.chatState = kOTRChatStateUnknown;
        [buddy saveWithTransaction:transaction];
    }];
}

+ (void)resetAllBuddyStatusesWithTransaction:(YapDatabaseReadWriteTransaction *)transaction
{
    NSMutableArray *buddiesToChange = [NSMutableArray array];
    [transaction enumerateKeysAndObjectsInCollection:[self collection] usingBlock:^(NSString *key, OTRBuddy *buddy, BOOL *stop) {
        if(buddy.status != OTRBuddyStatusOffline)
        {
            [buddiesToChange addObject:buddy];
        }
    }];
    
    [buddiesToChange enumerateObjectsUsingBlock:^(OTRBuddy *buddy, NSUInteger idx, BOOL *stop) {
        buddy.status = OTRBuddyStatusOffline;
        [buddy saveWithTransaction:transaction];
    }];
}

+ (void)deleteBuddyWithUniqueBuddyId:(NSString *)uniqueBuddyId transaction:(YapDatabaseReadWriteTransaction *)transaction
{
    
}

@end
