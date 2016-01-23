//
//  AHYChatAccount.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYChatAccount.h"
#import "OTRConstants.h"

#import "AHYDatabaseManager.h"
#import "YapDatabaseRelationshipTransaction.h"
#import "OTRBuddy.h"
#import "OTRImages.h"

NSString *const OTRAimImageName               = @"aim.png";
NSString *const OTRGoogleTalkImageName        = @"gtalk.png";
NSString *const OTRXMPPImageName              = @"xmpp.png";
NSString *const OTRXMPPTorImageName           = @"xmpp-tor-logo.png";

@interface AHYChatAccount()
{
    
}

@end

@implementation AHYChatAccount

- (id)init {
    if(self = [super init])
    {
        _accountType = OTRAccountTypeNone;
    }
    return self;
}

- (id)initWithAccountType:(OTRAccountType)acctType {
    if (self = [self init]) {
        
        _accountType = acctType;
    }
    return self;
}

//- (OTRProtocolType)protocolType
//{
//    return OTRProtocolTypeNone;
//}

- (UIImage *)accountImage {
    return nil;
}

- (NSString *)accountDisplayName {
    return @"";
}


- (void)setAvatarData:(NSData *)avatarData {
    if (![self.avatarData isEqualToData:avatarData]) {
        _avatarData = avatarData;
        [OTRImages removeImageWithIdentifier:self.uniqueId];
    }
}

- (UIImage *)avatarImage {
    //on setAvatar clear this buddies image cache
    //invalidate if jid or display name changes
    return [OTRImages avatarImageWithUniqueIdentifier:self.uniqueId avatarData:self.avatarData displayName:self.displayName username:self.uniqueId];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@",NSStringFromClass([self class]), self.uniqueId];
}

- (NSArray *)allBuddiesWithTransaction:(YapDatabaseReadTransaction *)transaction {
    NSMutableArray *allBuddies = [NSMutableArray array];
    [[transaction ext:AHYYapDatabaseRelationshipName] enumerateEdgesWithName:OTRBuddyEdges.account destinationKey:self.uniqueId collection:[AHYChatAccount collection] usingBlock:^(YapDatabaseRelationshipEdge *edge, BOOL *stop)
     {
         OTRBuddy *buddy = [OTRBuddy fetchObjectWithUniqueID:edge.sourceKey transaction:transaction];
         [allBuddies addObject:buddy];
     }];
    return allBuddies;
}


#pragma mark NSCoding

#pragma - mark Class Methods


+ (NSArray *)allAccountsWithUserid:(NSString *)userid transaction:(YapDatabaseReadTransaction*)transaction {
    __block NSMutableArray *accountsArray = [NSMutableArray array];
    [transaction enumerateKeysAndObjectsInCollection:[AHYChatAccount collection] usingBlock:^(NSString *key, AHYChatAccount *account, BOOL *stop) {
        if ([account isKindOfClass:[AHYChatAccount class]] && [account.uniqueId isEqualToString:userid]){
            [accountsArray addObject:account];
        }
    }];
    return accountsArray;
}

+ (NSArray *)allAccountsWithTransaction:(YapDatabaseReadTransaction*)transaction {
    NSMutableArray *accounts = [NSMutableArray array];
    NSArray *allAccountKeys = [transaction allKeysInCollection:[AHYChatAccount collection]];
    [allAccountKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [accounts addObject:[[transaction objectForKey:obj inCollection:[AHYChatAccount collection]]copy]];
    }];
    return accounts;
    
}

+ (NSDictionary *)encodingBehaviorsByPropertyKey {
    NSMutableDictionary *behaviors = [NSMutableDictionary dictionaryWithDictionary:[super encodingBehaviorsByPropertyKey]];
    [behaviors setObject:@(MTLModelEncodingBehaviorExcluded) forKey:NSStringFromSelector(@selector(password))];
    return behaviors;
}


@end
