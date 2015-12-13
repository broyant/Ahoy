//
//  AHYNetworkResponse.h
//  Ahoy
//
//  Created by lichuanjun on 11/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHYNetworkResponse : NSObject

@property (strong, nonatomic) NSDictionary *responseInfo;
@property (strong, nonatomic) NSDictionary *errorInfo;
@property (assign, nonatomic) NSInteger errorCode; // 0: no error
@property (strong, nonatomic) NSString *errorDescription;

+ (instancetype)responseWithObject:(id)obj error:(NSError *)error;
+ (instancetype)responseWithInfo:(NSDictionary *)info
                       errorCode:(NSInteger)code
                       errorInfo:(NSDictionary *)errorInfo
                errorDescription:(NSString *)description;

@end
