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

#define kFixPartHeightInBubble 225.f

@implementation AHYReservationItem

- (CGSize)mediaViewDisplaySize
{
    return CGSizeMake(0.f, kFixPartHeightInBubble);
}

- (UIView *)mediaView
{
//    AHYReserveView *reserveView = [[AHYReserveView alloc] initWithDate:_rsvDate time:_rsvTime note:_rsvNote];
//    [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:reserveView isOutgoing:!self.isIncoming];
//    return reserveView;
    return nil;
    
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

- (NSUInteger)hash
{
    return super.hash ^ self.startTime.hash ^self.endTime.hash ^self.rsvNote.hash ^self.topic.hash;
}

+ (NSString *)collection
{
    return [OTRMediaItem collection];
}
@end
