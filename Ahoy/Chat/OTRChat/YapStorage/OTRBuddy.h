//
//  OTRBuddy.h
//  Off the Record
//
//  Created by David Chiles on 3/28/14.
//  Copyright (c) 2014 Chris Ballinger. All rights reserved.
//

#import "OTRYapDatabaseObject.h"
@import UIKit;

@class AHYChatAccount, OTRMessage;

typedef NS_ENUM(NSInteger, OTRBuddyStatus) {
    OTRBuddyStatusOffline   = 4,
    OTRBuddyStatusXa        = 3,
    OTRBuddyStatusDnd       = 2,
    OTRBuddyStatusAway      = 1,
    OTRBuddyStatusAvailable = 0
};

typedef NS_ENUM(int, OTRChatState) {
    kOTRChatStateUnknown   = 0,
    kOTRChatStateActive    = 1,
    kOTRChatStateComposing = 2,
    kOTRChatStatePaused    = 3,
    kOTRChatStateInactive  = 4,
    kOTRChatStateGone      = 5
};

extern const struct OTRBuddyAttributes {
    __unsafe_unretained NSString *userName;
	__unsafe_unretained NSString *displayName;
	__unsafe_unretained NSString *composingMessageString;
	__unsafe_unretained NSString *statusMessage;
	__unsafe_unretained NSString *chatState;
    __unsafe_unretained NSString *lastSentChatState;
    __unsafe_unretained NSString *status;
    __unsafe_unretained NSString *lastMessageDate;
    __unsafe_unretained NSString *avatarData;
    __unsafe_unretained NSString *encryptionStatus;
    __unsafe_unretained NSString *blocking;
    __unsafe_unretained NSString *companyName;
    __unsafe_unretained NSString *currentTopicName;
    __unsafe_unretained NSString *extraInfoAttr;
} OTRBuddyAttributes;

extern const struct OTRBuddyRelationships {
	__unsafe_unretained NSString *accountUniqueId;
} OTRBuddyRelationships;

extern const struct OTRBuddyEdges {
	__unsafe_unretained NSString *account;
} OTRBuddyEdges;

@interface OTRBuddy : OTRYapDatabaseObject <YapDatabaseRelationshipNode>

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *composingMessageString;
@property (nonatomic, strong) NSString *statusMessage;
@property (nonatomic) OTRChatState chatState;
@property (nonatomic) OTRChatState lastSentChatState;
@property (nonatomic) OTRBuddyStatus status;
@property (nonatomic, strong) NSDate *lastMessageDate;
@property (nonatomic, getter=isBlocked) BOOL blocking;

//add for companyinfo and topic
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *currentTopicName;
//add for extra Personal Info
@property (nonatomic,strong) NSDictionary *extraInfoAttr;
/**
 * Setting this value does a comparison of against the previously value
 * to invalidate the OTRImages cache.
 */
@property (nonatomic, strong) NSData *avatarData;

@property (nonatomic, strong) NSString *accountUniqueId;

/**
 The current or generated avatar image either from avatarData or the initials from displayName or username
 
 @return An UIImage from the OTRImages NSCache
 */
- (UIImage *)avatarImage;
- (NSInteger)numberOfMessagesWithTransaction:(YapDatabaseReadTransaction *)transaction;
- (NSInteger)numberOfUnreadMessagesWithTransaction:(YapDatabaseReadTransaction *)transaction;
- (OTRMessage *)lastMessageWithTransaction:(YapDatabaseReadTransaction *)transaction;
- (AHYChatAccount *)accountWithTransaction:(YapDatabaseReadTransaction *)transaction;
- (void)setAllMessagesRead:(YapDatabaseReadWriteTransaction *)transaction;
- (void)updateLastMessageDateWithTransaction:(YapDatabaseReadTransaction *)transaction;

- (NSDate *)latestPendingReversationDate:(YapDatabaseReadTransaction *)transaction;

+ (instancetype)fetchBuddyForUniqueId:(NSString *)userid
                          accountId:(NSString *)accountid
                          transaction:(YapDatabaseReadTransaction *)transaction;

+ (instancetype)fetchBuddyWithUserid:(NSString *)userid
                      withAccountUid:(NSString *)accountid
                         transaction:(YapDatabaseReadTransaction *)transaction;

+ (instancetype)fetchBuddyWithID:(NSString *)userid withAccountUid:(NSString *)accountid transaction:(YapDatabaseReadTransaction *)transaction;


+ (void)resetAllChatStatesWithTransaction:(YapDatabaseReadWriteTransaction *)transaction;
+ (void)resetAllBuddyStatusesWithTransaction:(YapDatabaseReadWriteTransaction *)transaction;

+ (void)deleteBuddyWithUniqueBuddyId:(NSString *)uniqueBuddyId transaction:(YapDatabaseReadWriteTransaction *)transaction;


@end
