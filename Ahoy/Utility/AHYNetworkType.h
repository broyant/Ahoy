//
//  AHYNetworkType.h
//  Ahoy
//
//  Created by lichuanjun on 11/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#ifndef AHYNetworkType_h
#define AHYNetworkType_h

typedef NS_ENUM(NSUInteger, AHYHTTPMethod) {
    AHYHTTPMethodGet,
    AHYHTTPMethodPost,
    AHYHTTPMethodPut,
    AHYHTTPMethodDelete
};

typedef NS_ENUM(NSUInteger, AHYNetworkReachabilityLimitType) {
    AHYNetworkReachabilityLimitNone,
    AHYNetworkReachabilityLimitWifi,
};

typedef NS_ENUM(NSInteger, AHYNetworkErrorCode) {
    AHYNetworkErrorCodeAuthFail = -10001,
};

#endif /* AHYNetworkType_h */
