//
//  AHYSearchHistory.m
//  Ahoy
//
//  Created by lichuanjun on 1/1/2016.
//  Copyright © 2016 Ahoy. All rights reserved.
//

NSInteger  const  kMaxRecordsNum = 5;
NSString * const kSearchHistory = @"searchHistory";

#import "AHYSearchHistory.h"

@interface AHYSearchHistory ()

@end

@implementation AHYSearchHistory

+ (instancetype)shareInstance {
    static AHYSearchHistory *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AHYSearchHistory alloc] init];
    });
    return shared;
}

- (void)saveRecord:(NSString *)record {
    NSMutableArray *records = [[self readRecords] mutableCopy];
    if ([records containsObject:record]) {
        [records removeObject:record];
    }
    if (records.count >= kMaxRecordsNum) {
        [records removeLastObject];
    }
    // we should insert at 0 in order to keep the lastest on the first
    [records insertObject:record atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:records forKey:kSearchHistory];
}

-  (NSArray *)readRecords {
    NSArray * records = [[NSUserDefaults standardUserDefaults] arrayForKey:kSearchHistory];
    if (!records) {
        records = [NSArray array];
    }
    return  records;
}

@end
