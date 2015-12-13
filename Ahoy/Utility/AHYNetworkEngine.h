//
//  AHYNetworkEngine.h
//  Ahoy
//
//  Created by lichuanjun on 11/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHYNetworkResponse.h"
#import "AHYNetworkType.h"

@interface AHYNetworkEngine : NSObject

+ (instancetype)sharedInstance;

- (void)sendRequestWithMethod:(AHYHTTPMethod)method
                    URLString:(NSString *)url
                   parameters:(NSDictionary *)params
                      success:(void (^)(AHYNetworkResponse *response))success
                      failure:(void (^)(AHYNetworkResponse *response))failure;

@end

