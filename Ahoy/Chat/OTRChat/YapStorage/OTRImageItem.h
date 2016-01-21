//
//  OTRImageItem.h
//  ChatSecure
//
//  Created by David Chiles on 1/26/15.
//  Copyright (c) 2015 Chris Ballinger. All rights reserved.
//

#import "OTRMediaItem.h"

@interface OTRImageItem : OTRMediaItem

@property (nonatomic) float width;
@property (nonatomic) float height;

@property (nonatomic, strong)  NSString *url;
@property (nonatomic, strong)  NSString *thumbnailUrl;
@property (nonatomic, assign)  BOOL isOriginal;
@end
