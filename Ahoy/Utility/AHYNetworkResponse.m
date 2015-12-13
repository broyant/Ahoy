//
//  AHYNetworkResponse.m
//  Ahoy
//
//  Created by lichuanjun on 11/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import "AHYNetworkResponse.h"

@implementation AHYNetworkResponse

+ (instancetype)responseWithObject:(id)obj error:(NSError *)error {
    NSInteger errorCode = 0;
    NSString *errorDescription = nil;
    NSDictionary *errorInfo = nil;
    if (error) {
        errorCode = error.code;
        errorInfo = error.userInfo;
        errorDescription = error.domain;
    } else if (obj == nil || ![obj isKindOfClass:[NSDictionary class]]) {
        errorCode = -1;
    } else {
        errorCode = [obj[@"errorCode"] integerValue];
    }
    return [[self alloc] initWithInfo:obj errorCode:errorCode errorInfo:errorInfo errorDescription:errorDescription];
}

+ (instancetype)responseWithInfo:(NSDictionary *)info
                       errorCode:(NSInteger)code
                       errorInfo:(NSDictionary *)errorInfo
                errorDescription:(NSString *)description {
    return [[self alloc] initWithInfo:info errorCode:code errorInfo:errorInfo errorDescription:description];
}

- (instancetype)initWithInfo:(NSDictionary *)info
                   errorCode:(NSInteger)code
                   errorInfo:(NSDictionary *)errorInfo
            errorDescription:(NSString *)description {
    self = [super init];
    if (self) {
        _errorCode = code;
        _errorInfo = errorInfo;
        _responseInfo = info;
        _errorDescription = description;
    }
    return self;
}

@end
