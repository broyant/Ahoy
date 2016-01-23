//
//  UIProfileHeaderView.m
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIProfileHeaderView.h"
#import "Utility.h"

#define userImageSize   60
#define leftOffset      20
#define buttonHeight    41

@interface UIProfileHeaderView ()
{
    UILabel *_userName;
    UIImageView *_userImg;
    UILabel *_jobTitle;
    UIButton    *_aboutMe;
    UIButton    *_topics;
    UIButton    *_reviews;
    UIView      *_selectedView;
    
    __weak id   _delegate;
}

@end

@implementation UIProfileHeaderView

- (id)initWithFrame:(CGRect)frame delegat:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        
        _delegate = delegate;
        
        _userImg = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceScreenWidth-userImageSize)/2, 32, userImageSize, userImageSize)];
        _userImg.image = [UIImage imageNamed:@"c2Topic1Thumbnail"];
        [self addSubview:_userImg];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, _userImg.frame.origin.y+_userImg.frame.size.height+8, DeviceScreenWidth-2*leftOffset, 24)];
        _userName.numberOfLines = 1;
        _userName.textColor = AHYWhite;
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.text = @"HAOYANG LI";
        _userName.font = TradeGothicLTBoldTwo(18);
        [self addSubview:_userName];
        
        _jobTitle = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, _userName.frame.origin.y+_userName.frame.size.height+2, DeviceScreenWidth-2*leftOffset, 19)];
        _jobTitle.numberOfLines = 1;
        _jobTitle.textColor = AHYWhite;
        _jobTitle.textAlignment = NSTextAlignmentCenter;
        _jobTitle.text = @"User Experience Designer, Scopely";
        _jobTitle.font = TradeGothicLTBoldTwo(14);
        [self addSubview:_jobTitle];
        
        _aboutMe = [[UIButton alloc] initWithFrame:CGRectMake(0, _jobTitle.frame.origin.y+_jobTitle.frame.size.height+14, DeviceScreenWidth/3, buttonHeight)];
        [_aboutMe setTitleColor:AHYWhite forState:UIControlStateNormal];
        _aboutMe.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _aboutMe.titleLabel.font = TradeGothicLT(16);
        [_aboutMe setTitle:@"About Me" forState:UIControlStateNormal];
        [_aboutMe addTarget:self action:@selector(aboutBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_aboutMe];
        
        _topics = [[UIButton alloc] initWithFrame:CGRectMake(DeviceScreenWidth/3, _aboutMe.frame.origin.y, DeviceScreenWidth/3, buttonHeight)];
        [_topics setTitleColor:AHYWhite forState:UIControlStateNormal];
        _topics.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _topics.titleLabel.font = TradeGothicLT(16);
        [_topics setTitle:@"Topics" forState:UIControlStateNormal];
        [_topics addTarget:self action:@selector(topicsBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_topics];
        _topics.alpha = 0.4;
        
        _reviews = [[UIButton alloc] initWithFrame:CGRectMake(DeviceScreenWidth/3*2, _aboutMe.frame.origin.y, DeviceScreenWidth/3, buttonHeight)];
        [_reviews setTitleColor:AHYWhite forState:UIControlStateNormal];
        _reviews.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _reviews.titleLabel.font = TradeGothicLT(16);
        [_reviews setTitle:@"Reviews" forState:UIControlStateNormal];
        [_reviews addTarget:self action:@selector(reviewsBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reviews];
        _reviews.alpha = 0.4;
        
        _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-2, DeviceScreenWidth/3, 2)];
        _selectedView.backgroundColor = AHYYellow;
        [self addSubview:_selectedView];
        
        return self;
    }
    return nil;
}


- (void)aboutBtnTouched
{
    [Utility changeX:_selectedView x:0];
    _aboutMe.alpha = 1;
    _topics.alpha = 0.4;
    _reviews.alpha = 0.4;

    if ([_delegate respondsToSelector:@selector(aboutBtnTouched)]) {
        [_delegate aboutBtnTouched];
    }
}

- (void)topicsBtnTouched
{
    [Utility changeX:_selectedView x:DeviceScreenWidth/3];
    _aboutMe.alpha = 0.4;
    _topics.alpha = 1;
    _reviews.alpha = 0.4;
    
    if ([_delegate respondsToSelector:@selector(topicsBtnTouched)]) {
        [_delegate topicsBtnTouched];
    }
}

- (void)reviewsBtnTouched
{
    [Utility changeX:_selectedView x:DeviceScreenWidth/3*2];
    _aboutMe.alpha = 0.4;
    _topics.alpha = 0.4;
    _reviews.alpha = 1;
    
    if ([_delegate respondsToSelector:@selector(reviewsBtnTouched)]) {
        [_delegate reviewsBtnTouched];
    }
}

@end
