//
//  AHYDiscoverDataSource.h
//  Ahoy
//
//  Created by lichuanjun on 16/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//
#import "AHYTopicCategory.h"
#import "AHYAdvisor.h"
#import "AHYTopic.h"

@interface AHYDiscoverDataSource : NSObject

+ (void)downloadTopicCategorys:(void (^)(NSArray *categorys))completeHandler;

+ (void)downloadPopularAdvisors:(void (^)(NSArray *advisors))completeHandler;

+ (void)downloadRecommendTopics:(void (^)(NSArray *topics))completeHandler;

+ (void)downloadAdvisorsWithTopicID:(NSInteger)tID  completion:(void(^)(NSArray *advisors))completeHandler;

@end
