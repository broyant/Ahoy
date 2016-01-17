//
//  AHYAdvisor.m
//  Ahoy
//
//  Created by lcj on 15/10/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYAdvisor.h"

@implementation AHYAdvisor

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"advisorId": @"aid",
                                                       @"advisorName": @"name",
                                                       @"reviewRating": @"reviewRate",
                                                       @"title": @"title",
                                                       @"price": @"price",
                                                       @"thumbnailUrl": @"portraitUrl"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
