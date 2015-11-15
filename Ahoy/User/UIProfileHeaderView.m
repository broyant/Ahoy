//
//  UIProfileHeaderView.m
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIProfileHeaderView.h"

#define userImageSize   60

@interface UIProfileHeaderView ()
{
    UILabel *_userName;
    UIImageView *_userImg;
    
    UIView *_jobView;
    UILabel *_jobTitle;
}

@end

@implementation UIProfileHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _userImg = [[UIImageView alloc] initWithFrame:CGRectMake(157.5, 32, userImageSize, userImageSize)];
        _userImg.image = [UIImage imageNamed:@"c2Topic1Thumbnail"];
        [self addSubview:_userImg];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(65, 100, 245, 24)];
        _userName.numberOfLines = 1;
        _userName.textColor = [UIColor whiteColor];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.text = @"HAOYANG LI";
        _userName.font = TradeGothicLTBoldTwo(18);
        [self addSubview:_userName];
        
        _jobView = [[UIView alloc] initWithFrame:CGRectMake(65, 140, 245, 40)];
        _jobView.backgroundColor = [UIColor whiteColor];
        [_jobView.layer setShadowOffset:CGSizeMake(0, 1)];
        [_jobView.layer setShadowColor:RGBCOLORA(0, 0, 0, 1).CGColor];
        [_jobView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_jobView.layer setShadowOpacity:0.1];
        [_jobView.layer setBorderWidth:1];
        [_jobView.layer setCornerRadius:1];
        [self addSubview:_jobView];
        
        _jobTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, 215, 19)];
        _jobTitle.numberOfLines = 1;
        _jobTitle.textColor = AHYGrey40;
        _jobTitle.textAlignment = NSTextAlignmentCenter;
        _jobTitle.text = @"User Experience Designer, Scopely";
        _jobTitle.font = TradeGothicLTBoldTwo(14);
        [_jobView addSubview:_jobTitle];
        
        return self;
    }
    return nil;
}

@end
