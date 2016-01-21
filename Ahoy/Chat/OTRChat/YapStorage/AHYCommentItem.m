//
//  AHYCommentItem.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYCommentItem.h"
#import "AHYCommentView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"


NSString *const AHYCommentType = @"AHYComment";
#define kFixHeightInBubble 100.f

@implementation AHYCommentItem

- (CGSize)mediaViewDisplaySize
{
    return CGSizeMake(0.f, kFixHeightInBubble);
}

- (UIView *)mediaView
{
    AHYCommentView *commentView = [[AHYCommentView alloc] init];
    [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:commentView isOutgoing:!self.isIncoming];
    return commentView;
    
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

- (NSUInteger)hash
{
    return super.hash ^ self.rate ^ self.comment.hash;
}

+ (NSString *)collection
{
    return [OTRMediaItem collection];
}


@end
