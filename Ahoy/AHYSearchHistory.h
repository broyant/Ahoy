//
//  AHYSearchHistory.h
//  Ahoy
//
//  Created by lichuanjun on 1/1/2016.
//  Copyright © 2016 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHYSearchHistory : NSObject

+ (instancetype)shareInstance;

- (void)saveRecord:(NSString *)record;

- (NSArray *)readRecords;

@end
