//
//  AHYChatAccount.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "OTRYapDatabaseObject.h"
@import UIKit;

typedef NS_ENUM(int, OTRAccountType) {
    OTRAccountTypeNone        = 0,
    OTRAccountTypeFacebook    = 1,
    OTRAccountTypeGoogleTalk  = 2,
    OTRAccountTypeJabber      = 3,
    OTRAccountTypeAIM         = 4,
    OTRAccountTypeXMPPTor     = 5
};

extern NSString *const OTRAimImageName;
extern NSString *const OTRGoogleTalkImageName;
extern NSString *const OTRXMPPImageName;
extern NSString *const OTRXMPPTorImageName;

@interface AHYChatAccount : OTRYapDatabaseObject

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, readonly) OTRAccountType accountType;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic) BOOL rememberPassword;
@property (nonatomic) BOOL autologin;

/**
 * Setting this value does a comparison of against the previously value
 * to invalidate the OTRImages cache.
 */
@property (nonatomic, strong) NSData *avatarData;

@property (nonatomic, strong) NSString *password;


- (id)initWithAccountType:(OTRAccountType)accountType;

- (UIImage *)avatarImage;

- (UIImage *)accountImage;

- (NSString *)accountDisplayName;

- (NSString *)protocolTypeString;

- (NSArray *)allBuddiesWithTransaction:(YapDatabaseReadTransaction *)transaction;

+ (NSArray *)allAccountsWithUserid:(NSString *)userid transaction:(YapDatabaseReadTransaction*)transaction;
+ (NSArray *)allAccountsWithTransaction:(YapDatabaseReadTransaction*)transaction;
@end
