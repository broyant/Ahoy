//
//  AHYTopic.m
//  Ahoy
//
//  Created by lcj on 15/10/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYTopic.h"

@implementation AHYTopic

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"topicId": @"tid",
                                                       @"topicName": @"tName",
                                                       @"thumbnailUrl": @"thumbnailUrl"}];
}

@end
