//
//  CustomTagView.m
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "CustomTagView.h"
#import "AHYReviewTag.h"

#define leftOffset  15
#define tagHeight   30

#define topPadding  5
#define leftPadding  9
#define bottomPadding  3
#define rightPadding  9

#define labelMargin 5.0f

#define tagHorizontalMargin 10.0f
#define tagVerticalMargin 15.0f


@implementation CustomTagView

@synthesize tagArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setTags:(NSMutableArray *)array
{
    self.tagArray = array;
    sizeFit = CGSizeZero;
    [self display];
}

- (void)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }

    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    
    for (AHYReviewTag *tag in self.tagArray) {
        if (tag.count > 0) {
            CGSize tagSize = CGSizeZero;
            UIView *tagView = [[UIView alloc] init];
            
            NSDictionary *attributes = @{NSFontAttributeName:AvenirNextRegular(16)};
            CGRect textSize = [tag.tagName boundingRectWithSize:CGSizeMake(MAXFLOAT,tagHeight)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:attributes
                                                        context:nil];
            tagSize.width = textSize.size.width + leftPadding + rightPadding;
            tagSize.height = tagHeight;
            
            CGRect countSize = CGRectZero;
            NSDictionary *countAttribute = @{NSFontAttributeName:TradeGothicLT(12)};
            countSize = [[NSString stringWithFormat:@"(%ld)",tag.count] boundingRectWithSize:CGSizeMake(MAXFLOAT,tagHeight)
                                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                                  attributes:countAttribute
                                                                                     context:nil];
            tagSize.width += countSize.size.width + labelMargin;
            
            if (!gotPreviousFrame) {
                tagView.frame = CGRectMake(leftOffset, 0, tagSize.width, tagSize.height);
                totalHeight = tagSize.height;
            } else {
                CGRect newRect = CGRectZero;
                if (previousFrame.origin.x + previousFrame.size.width + tagSize.width + tagHorizontalMargin > DeviceScreenWidth-leftOffset) {
                    newRect.origin = CGPointMake(leftOffset, previousFrame.origin.y + tagSize.height + tagVerticalMargin);
                    totalHeight += tagSize.height + tagVerticalMargin;
                } else {
                    newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + tagHorizontalMargin, previousFrame.origin.y);
                }
                newRect.size = tagSize;
                tagView.frame = newRect;
            }
            previousFrame = tagView.frame;
            gotPreviousFrame = YES;
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, topPadding, ceil(textSize.size.width), ceil(textSize.size.height))];
            [textLabel setText:tag.tagName];
            [textLabel setFont:AvenirNextRegular(16)];
            [textLabel setBackgroundColor:[UIColor clearColor]];
            if (tag.isHighlight) {
                [textLabel setTextColor:AHYYellow];
            } else {
                [textLabel setTextColor:AHYGrey40];
            }
            [tagView addSubview:textLabel];
            
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+textSize.size.width+labelMargin, 4+topPadding, countSize.size.width, countSize.size.height)];
            [countLabel setText:[NSString stringWithFormat:@"(%ld)",tag.count]];
            [countLabel setFont:TradeGothicLT(12)];
            [countLabel setBackgroundColor:[UIColor clearColor]];
            if (tag.isHighlight) {
                [countLabel setTextColor:AHYYellow];
            } else {
                [countLabel setTextColor:AHYGrey40];
            }
            [tagView addSubview:countLabel];
            
            [tagView.layer setMasksToBounds:YES];
            [tagView.layer setCornerRadius:1];
            [tagView.layer setBorderColor:AHYGrey10.CGColor];
            [tagView.layer setBorderWidth:1];
            
            [self addSubview:tagView];
        }
        sizeFit = CGSizeMake(DeviceScreenWidth, ceil(totalHeight));
    }
}

- (CGSize)fittedSize
{
    return sizeFit;
}



@end
