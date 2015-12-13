//
//  AHYNetworkEngine.m
//  Ahoy
//
//  Created by lichuanjun on 11/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import "AHYNetworkEngine.h"
#import <AFNetworking.h>

@interface AHYNetworkEngine ()

@property (strong, nonatomic) AFURLSessionManager *sessionManager;
@property (strong, nonatomic) NSDictionary *methodStrings;

@end

@implementation AHYNetworkEngine

+ (instancetype)sharedInstance {
    static AHYNetworkEngine *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AHYNetworkEngine alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.allowsCellularAccess = YES;
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _methodStrings = @{ @(AHYHTTPMethodGet) : @"GET",
                            @(AHYHTTPMethodPost) : @"POST",
                            @(AHYHTTPMethodPut) : @"PUT",
                            @(AHYHTTPMethodDelete) : @"DELETE" };
    }
    return self;
}

- (void)sendRequestWithMethod:(AHYHTTPMethod)method
                    URLString:(NSString *)url
                   parameters:(NSDictionary *)params
                      success:(void (^)(AHYNetworkResponse *response))success
                      failure:(void (^)(AHYNetworkResponse *response))failure {
    
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, CFSTR(""), kCFStringEncodingUTF8));
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:_methodStrings[@(method)]
                                                                                 URLString:url
                                                                                parameters:params
                                                                                     error:nil];
    
    NSURLSessionDataTask *dataTask = [_sessionManager dataTaskWithRequest:request
                                                        completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                            if (error) {
                                                                NSLog(@"http request error: %@", error);
                                                                if (failure) {
                                                                    failure([AHYNetworkResponse responseWithObject:responseObject error:error]);
                                                                }
                                                            } else {
                                                                NSError *jsonError;
                                                                id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                                                options:0
                                                                                                                  error:&jsonError];
                                                                AHYNetworkResponse *resp = [AHYNetworkResponse responseWithObject:jsonObject error:jsonError];
                                                                if (jsonError || resp.errorCode != 0) {
                                                                    if (failure) {
                                                                        failure(resp);
                                                                    }
                                                                } else {
                                                                    if (success) {
                                                                        success(resp);
                                                                    }
                                                                }
                                                            }
                                                        }];
    [dataTask resume];
}


@end
