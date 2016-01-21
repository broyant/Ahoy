//
//  OTRMessage+JSQMessageData.m
//  Off the Record
//
//  Created by David Chiles on 5/12/14.
//  Copyright (c) 2014 Chris Ballinger. All rights reserved.
//

#import "OTRMessage+JSQMessageData.h"
#import "AHYDatabaseManager.h"
#import "OTRBuddy.h"

#import "OTRMediaItem.h"
#import "YapDatabaseRelationshipTransaction.h"


@implementation OTRMessage (JSQMessageData)

- (NSString *)senderId
{
    __block NSString *sender = @"";
    [[AHYDatabaseManager sharedInstance].readOnlyDatabaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction) {
        OTRBuddy *buddy = [self buddyWithTransaction:transaction];
        if (self.isIncoming) {
            sender = buddy.uniqueId;
        }
        else {
//            OTRAccount *account = [buddy accountWithTransaction:transaction];
            sender = buddy.accountUniqueId;
        }
    }];
    return sender;
}

- (NSString *)senderDisplayName {
    __block NSString *sender = @"";
    [[AHYDatabaseManager sharedInstance].readOnlyDatabaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction) {
        OTRBuddy *buddy = [self buddyWithTransaction:transaction];
        if (self.isIncoming) {
            if ([buddy.displayName length]) {
                sender = buddy.displayName;
            }
            else {
                sender = buddy.uniqueId;
            }
        }
        else {
//            OTRAccount *account = [buddy accountWithTransaction:transaction];
//            if ([account.displayName length]) {
//                sender = account.displayName;
//            }
//            else {
//                sender = account.username;
//            }
            sender = buddy.accountUniqueId;
        }
    }];
    return sender;
}

- (NSUInteger)messageHash
{
    return [self hash];
}

- (BOOL)isMediaMessage
{
    if ([self.mediaItemUniqueId length]) {
        return YES;
    }
    return NO;
}

- (id<JSQMessageMediaData>)media
{
    __block id <JSQMessageMediaData>media = nil;
    [[AHYDatabaseManager sharedInstance].readOnlyDatabaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction) {
        media = [OTRMediaItem fetchObjectWithUniqueID:self.mediaItemUniqueId transaction:transaction];
    }];
    return media;
}


@end
