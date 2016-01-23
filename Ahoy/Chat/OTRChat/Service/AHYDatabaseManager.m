//
//  AHYDatabaseManager.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYDatabaseManager.h"
#import "AHYDatabaseView.h"
#import "YapDatabaseRelationship.h"
#import "YapDatabaseSecondaryIndexSetup.h"
#import "YapDatabaseSecondaryIndex.h"
#import "OTRMessage.h"
#import "OTRConstants.h"

NSString* const AHYYapDatabaseName = @"chatYap.sqlite";
//#define AHYYapDatabaseName @"chatYap.sqlite"

NSString *const AHYYapDatabaseRelationshipName = @"AHYYapDatabaseRelationshipName";
NSString *const AHYYapDatabseMessageIdSecondaryIndex = @"AHYYapDatabseMessageIdSecondaryIndex";
NSString *const AHYYapDatabseMessageIdSecondaryIndexExtension = @"AHYYapDatabseMessageIdSecondaryIndexExtension";
NSString *const ChatRootDirectory = @"Chat";
NSString *const ChatDatabaseDirectory = @"Database";

@interface AHYDatabaseManager()
{
    
}
@property (nonatomic, strong) YapDatabase *database;
@property (nonatomic, strong) YapDatabaseConnection *readOnlyDatabaseConnection;
@property (nonatomic, strong) YapDatabaseConnection *readWriteDatabaseConnection;

@end

@implementation AHYDatabaseManager

#pragma mark - public APIs
- (void)deallocDatabase {
    _readOnlyDatabaseConnection = nil;
    _readWriteDatabaseConnection = nil;
    _database = nil;
}

- (BOOL)setupDatabaseWithName:(NSString*)accountid {
    
    if (!accountid.length)
    {
        return NO;
    }
    
    BOOL success = NO;
    if ([self setupYapDatabaseWithName:accountid] )
    {
        success = YES;
    }
    
    self.databaseIsReady = success;
    
    return success;
}

- (YapDatabaseConnection *)newConnection {
    return [self.database newConnection];
}

+ (BOOL)existsYapDatabase:(NSString *)databaseName {
    
    NSString *path = [[self class] yapDatabasePathWithName:databaseName];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (NSString *)yapDatabasePathWithName:(NSString *)name {
    NSString *databasePath = [NSString stringWithFormat:@"%@/%@",name,ChatDatabaseDirectory];
    return [[self yapDatabaseDirectory] stringByAppendingPathComponent:databasePath];
}

+ (instancetype)sharedInstance {
    static id databaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseManager = [[self alloc] init];
    });
    return databaseManager;
}

#pragma mark - private APIs

- (BOOL)setupYapDatabaseWithName:(NSString *)name {
    YapDatabaseOptions *options = [[YapDatabaseOptions alloc] init];
    options.corruptAction = YapDatabaseCorruptAction_Fail;

    NSString *databaseDirectory = [[self class] yapDatabasePathWithName:name];
    if (![[NSFileManager defaultManager] fileExistsAtPath:databaseDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:databaseDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *databasePath = [databaseDirectory stringByAppendingPathComponent:AHYYapDatabaseName];
    

    self.database = [[YapDatabase alloc] initWithPath:databasePath
                                     objectSerializer:NULL
                                   objectDeserializer:NULL
                                   metadataSerializer:NULL
                                 metadataDeserializer:NULL
                                   objectPreSanitizer:NULL
                                  objectPostSanitizer:NULL
                                 metadataPreSanitizer:NULL
                                metadataPostSanitizer:NULL
                                              options:options];
    
    self.database.defaultObjectPolicy = YapDatabasePolicyShare;
    self.database.defaultObjectCacheLimit = 1000;
    
    self.readOnlyDatabaseConnection = [self.database newConnection];
    self.readOnlyDatabaseConnection.name = @"readOnlyDatabaseConnection";
    
    self.readWriteDatabaseConnection = [self.database newConnection];
    self.readWriteDatabaseConnection.name = @"readWriteDatabaseConnection";
    
    ////// Register standard views////////
    YapDatabaseRelationship *databaseRelationship = [[YapDatabaseRelationship alloc] init];
    BOOL success = [self.database registerExtension:databaseRelationship withName:AHYYapDatabaseRelationshipName];
    
    if (success) success = [AHYDatabaseView registerConversationDatabaseView];
    
    if (success) success = [AHYDatabaseView registerBlockedBuddyDatabaseView];
    
    if (success) success = [AHYDatabaseView registerChatDatabaseView];
    
    if (success) success = [AHYDatabaseView registerUnreadMessagesView];
    
    if (success) success = [AHYDatabaseView registerBuddyNameSearchDatabaseView];
    
    if (success) success = [self setupSecondaryIndexes];
    
    if (self.database) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)setupSecondaryIndexes {
    YapDatabaseSecondaryIndexSetup *setup = [[YapDatabaseSecondaryIndexSetup alloc] init];
    [setup addColumn:AHYYapDatabseMessageIdSecondaryIndex withType:YapDatabaseSecondaryIndexTypeText];
    
    YapDatabaseSecondaryIndexHandler *indexHandler = [YapDatabaseSecondaryIndexHandler withObjectBlock:^(NSMutableDictionary *dict, NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[OTRMessage class]])
        {
            OTRMessage *message = (OTRMessage *)object;
            
            if ([message.messageId length]) {
                [dict setObject:message.messageId forKey:AHYYapDatabseMessageIdSecondaryIndex];
            }
        }
    }];
    
    YapDatabaseSecondaryIndex *secondaryIndex = [[YapDatabaseSecondaryIndex alloc] initWithSetup:setup handler:indexHandler];
    
    return [self.database registerExtension:secondaryIndex withName:AHYYapDatabseMessageIdSecondaryIndexExtension];
    
}


+ (NSString *)yapDatabaseDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *directory = [documentsDirectory stringByAppendingPathComponent:ChatRootDirectory];
    return directory;
}


@end
