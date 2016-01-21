//
//  JSQReserveView.m
//  JSQMessages
//
//  Created by broyant on 16/1/13.
//  Copyright © 2016年 Hexed Bits. All rights reserved.
//

#import "AHYReserveView.h"
#import "Masonry.h"
#import "JSQMessagesCellTextView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

@interface AHYReserveView()
{
    UIImageView *_titleIcon;
    UILabel *_titleLabel;
    UIView *_titleBottomLine;
    UILabel *_dateLabel;
    UIView *_dateBottomLine;
    UILabel *_timeLabel;
    UIView *_timeBottomLine;
    JSQMessagesCellTextView *_contentTextView;
}
@end

@implementation AHYReserveView



- (instancetype)initWithDate:(NSString *)date time:(NSString *)time note:(NSString *)note
{
    self = [super init];
    if (self) {
        _date = date;
        _time = time;
        _note = note;
        
        [self setupUIViews];
        
        [self addViewContrains];
        
    }
    return self;
}

- (void)setupUIViews
{
    self.backgroundColor = [UIColor cyanColor];
    
    _titleIcon = [UIImageView new];
    [self addSubview:_titleIcon];
    _titleIcon.backgroundColor = [UIColor yellowColor];

    _titleLabel = [UILabel new];
    [self addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:15.f];
    _titleLabel.text = @"RESERVE";
    
    _titleBottomLine = [UIView new];
    [self addSubview:_titleBottomLine];
    _titleBottomLine.backgroundColor = [UIColor redColor];
    
    _dateLabel = [UILabel new];
    [self addSubview:_dateLabel];
    _dateLabel.font = [UIFont systemFontOfSize:15.f];
    _dateLabel.text = @"Date: Jan 4th";
    
    _dateBottomLine = [UIView new];
    [self addSubview:_dateBottomLine];
    _dateBottomLine.backgroundColor = [UIColor redColor];
    
    _timeLabel = [UILabel new];
    [self addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:15.f];
    _timeLabel.text = @"Time: 4:00 PM";
    
    _timeBottomLine = [UIView new];
    [self addSubview:_timeBottomLine];
    _timeBottomLine.backgroundColor = [UIColor redColor];
    
    _contentTextView = [JSQMessagesCellTextView new];
    [self addSubview:_contentTextView];
    _contentTextView.text = _note;
    _contentTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _contentTextView.backgroundColor = [UIColor clearColor];
}

- (void)addViewContrains
{
    [_titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(12.f);
        make.top.mas_equalTo(4.f);
        make.right.equalTo(self.mas_centerX).offset(-15.f);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleIcon.mas_right).offset(5.f);
        make.centerY.equalTo(_titleIcon);
        make.trailing.equalTo(self);
    }];
    
    [_titleBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.height.mas_equalTo(1.f);
        make.top.mas_equalTo(19.f);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.top.mas_equalTo(20.f);
        make.height.mas_equalTo(19.f);
    }];
    
    [_dateBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.height.mas_equalTo(1.f);
        make.top.mas_equalTo(39.f);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.top.mas_equalTo(40.f);
        make.height.mas_equalTo(19.f);
    }];
    
    [_timeBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.height.mas_equalTo(1.f);
        make.top.mas_equalTo(59.f);
    }];
    
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.top.mas_equalTo(60.f);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contentTextView);
    }];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateConstraintsIfNeeded];

    [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:self isOutgoing:YES];
    
//    [_contentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.leading.and.trailing.equalTo(self);
//        make.top.mas_equalTo(60.f);
//        make.bottom.equalTo(self.mas_bottom);
//    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
