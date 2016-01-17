//
//  AHYTopicCategory.m
//  Ahoy
//
//  Created by lichuanjun on 17/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import "AHYTopicCategory.h"

@implementation AHYTopicCategory  

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"categoryId": @"cid",
                                                       @"categoryName": @"cName",
                                                       @"topics": @"topics"
                                                       }];
}

@end
