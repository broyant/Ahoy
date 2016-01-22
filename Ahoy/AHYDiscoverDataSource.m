//
//  AHYDiscoverDataSource.m
//  Ahoy
//
//  Created by lichuanjun on 16/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import "AHYDiscoverDataSource.h"
#import "AHYHttpUrl.h"
#import "JSONHTTPClient.h"

@implementation AHYDiscoverDataSource

+ (void)downloadTopicCategorys:(void (^)(NSArray *categorys))completeHandler {
    if (!completeHandler) {
        return;
    }
    
    [JSONHTTPClient getJSONFromURLWithString:DISCOVER_TOPIC_CATEGROY_URL completion:^(id json, JSONModelError *err) {
#ifdef MOCK
        NSData *mockJsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ahy_homepage" ofType:nil]];
        NSDictionary *mockJson = [NSJSONSerialization JSONObjectWithData:mockJsonData options:0 error:nil];
        NSArray *results = [mockJson objectForKey:@"results"];
        NSError *error = nil;
        NSArray *topics = [AHYTopicCategory arrayOfModelsFromDictionaries:results error:&error];
        if (!error) {
            completeHandler(topics);
        }else {
            completeHandler(nil);
            NSLog(@"download success, but parse topic category fail.Error:%@",error);
        }
#else
        if (!err) {
            NSArray *results = [(NSDictionary*)json objectForKey:@"results"];
            NSError *error = nil;
            NSArray *topics = [AHYTopicCategory arrayOfModelsFromDictionaries:results error:&error];
            if (!error) {
                completeHandler(topics);
            }else {
                completeHandler(nil);
                NSLog(@"download success, but parse topic category fail.Error:%@",error);
            }
        }else {
            NSLog(@"download topic category fail.Error:%@",err);
        }
#endif
    }];
    
}

+ (void)downloadPopularAdvisors:(void (^)(NSArray *advisors))completeHandler {
    [[self class] downloadAdvisorsWithUrl:DISCOVER_POPULAR_ADVISOR_URL completion:completeHandler];
}

+ (void)downloadRecommendTopics:(void (^)(NSArray *topics))completeHandler {
    if (!completeHandler) {
        return;
    }
    [JSONHTTPClient getJSONFromURLWithString:DISCOVER_RECOMMEND_TOPIC_URL completion:^(id json, JSONModelError *err) {
#ifdef MOCK
        NSData *mockJsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ahy_recommendTopics" ofType:nil]];
        NSDictionary *mockJson = [NSJSONSerialization JSONObjectWithData:mockJsonData options:0 error:nil];
        NSArray *results = [mockJson objectForKey:@"results"];
        NSError *error = nil;
        NSArray *topics = [AHYTopic arrayOfModelsFromDictionaries:results error:&error];
        if (!error) {
            completeHandler(topics);
        }else {
            completeHandler(nil);
            NSLog(@"download success, but parse recommend topic  fail.Error:%@",error);
        }
        
#else
        if (!err) {
            NSArray *results = [(NSDictionary*)json objectForKey:@"results"];
            NSError *error = nil;
            NSArray *topics = [AHYTopic arrayOfModelsFromDictionaries:results error:&error];
            if (!error) {
                completeHandler(topics);
            }else {
                completeHandler(nil);
                NSLog(@"download success, but parse recommend topic  fail.Error:%@",error);
            }
        }else {
            NSLog(@"download topic recommend topics fail.Error:%@",err);
        }
#endif
    }];
}

+ (void)downloadAdvisorsWithTopicID:(NSInteger)tID  completion:(void(^)(NSArray *advisors))completeHandler {
    NSString *url = [NSString stringWithFormat:@"%@?topicID=%@", DISCOVER_ADVISOR_LIST_URL, @(tID)];
    [[self class] downloadAdvisorsWithUrl:url completion:completeHandler];
}

+ (void)downloadAdvisorsWithUrl:(NSString *)url completion:(void (^)(NSArray *))completeHandler {
    if (!completeHandler) {
        return;
    }
    [JSONHTTPClient getJSONFromURLWithString:url completion:^(id json, JSONModelError *err) {
#ifdef MOCK
        NSData *mockJsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ahy_popularAdvisor" ofType:nil]];
        NSDictionary *mockJson = [NSJSONSerialization JSONObjectWithData:mockJsonData options:0 error:nil];
        NSArray *results = [mockJson objectForKey:@"results"];
        NSError *error = nil;
        NSArray *advisors = [AHYAdvisor arrayOfModelsFromDictionaries:results error:&error];
        if (!error) {
            completeHandler(advisors);
        }else {
            completeHandler(nil);
            NSLog(@"download success, but parse popular advisors fail.Error:%@",error);
        }
#else
        if (!err) {
            NSArray *results = [(NSDictionary*)json objectForKey:@"results"];
            NSError *error = nil;
            NSArray *advisors = [AHYAdvisor arrayOfModelsFromDictionaries:results error:&error];
            if (!error) {
                completeHandler(advisors);
            }else {
                completeHandler(nil);
                NSLog(@"download success, but parse popular advisors fail.Error:%@",error);
            }
        }else {
            NSLog(@"download popular advisors fail.Error:%@",err);
        }
#endif
    }];
}

@end
