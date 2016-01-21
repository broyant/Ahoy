//
//  AHYDatabaseManager.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YapDatabase.h"

extern NSString *const AHYYapDatabaseRelationshipName;
extern NSString *const AHYYapDatabseMessageIdSecondaryIndex;
extern NSString *const AHYYapDatabseMessageIdSecondaryIndexExtension;

@interface AHYDatabaseManager : NSObject

@property (nonatomic, readonly) YapDatabase *database;
@property (nonatomic, assign) BOOL databaseIsReady;
@property (nonatomic, readonly) YapDatabaseConnection *readOnlyDatabaseConnection;
@property (nonatomic, readonly) YapDatabaseConnection *readWriteDatabaseConnection;

- (void)deallocDatabase;

- (BOOL)setupDatabaseWithName:(NSString *)databaseName;

- (YapDatabaseConnection *)newConnection;


+ (BOOL)existsYapDatabase:(NSString *)databaseName;

+ (NSString *)yapDatabasePathWithName:(NSString *)name;

+ (instancetype)sharedInstance;

@end
