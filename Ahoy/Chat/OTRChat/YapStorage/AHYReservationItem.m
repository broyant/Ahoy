//
//  AHYReservationItem.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYReservationItem.h"
#import "AHYReserveView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

NSString * const reservationType = @"AHYReservetion";

#define kFixHeightInBubble 60.f

@implementation AHYReservationItem

- (CGSize)mediaViewDisplaySize
{
    return CGSizeMake(0.f, kFixHeightInBubble);
}

- (UIView *)mediaView
{
    AHYReserveView *reserveView = [[AHYReserveView alloc] initWithDate:_rsvDate time:_rsvTime note:_rsvNote];
    [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:reserveView isOutgoing:!self.isIncoming];
    return reserveView;
    
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

- (NSUInteger)hash
{
    return super.hash  ^ self.rsvDate.hash ^self.rsvTime.hash ^self.rsvNote.hash;
}

+ (NSString *)collection
{
    return [OTRMediaItem collection];
}
@end
