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
    
    UILabel *_timeLabel;
    UILabel *_timeValueLabel;
    UIView *_timeBottomLine;
    
    UILabel *_dateLabel;
    UILabel *_dateValueLabel;
    UIView *_dateBottomLine;
    
    UILabel *_topicLabel;
    UILabel *_topicValueLabel;
    UIView *_topicBottomLine;
    
    UILabel *_moneyLabel;
    UILabel *_moneyValueLabel;
    UIView *_moneyBottomLine;

    UILabel *_noteLabel;
    JSQMessagesCellTextView *_noteTextView;
}
@end

@implementation AHYReserveView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)configureWithStartTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                            topic:(NSString *)topic
                        moneyPaid:(NSUInteger)moneyPaid
                          rsvNote:(NSString *)rsvNote
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[startTime integerValue]];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[endTime integerValue]];
    
    NSString *startTimeStr = [NSDateFormatter localizedStringFromDate:startDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    NSString *endTimeStr = [NSDateFormatter localizedStringFromDate:endDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEE,ddMMM" options:0 locale:[NSLocale currentLocale]];
    NSString *startDateStr = [dateFormatter stringFromDate:startDate];
    
    _timeValueLabel.text = [NSString stringWithFormat:@"%@ - %@",startTimeStr,endTimeStr];
    _dateValueLabel.text = startDateStr;
    _topicValueLabel.text = topic;
    _moneyValueLabel.text = [NSString stringWithFormat:@"$ %lu",(unsigned long)moneyPaid];
    _noteTextView.text = rsvNote;
}

- (void)setupSubviews
{
    [self setupTitleView];
    [self setupTime];
    [self setupDate];
    [self setupTopic];
    [self setupMoney];
    [self setupNote];
}

- (void)setupTitleView
{
    _titleIcon = [UIImageView new];
    [self addSubview:_titleIcon];
    _titleIcon.backgroundColor = [UIColor yellowColor];
    [_titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(61.f);
        make.top.mas_equalTo(11);
        make.width.and.height.mas_equalTo(15);
    }];
    
    _titleLabel = [UILabel new];
    [self addSubview:_titleLabel];
    _titleLabel.font = TradeGothicLTBold(16);
    _titleLabel.textColor = AHYGrey40;
    _titleLabel.text = @"RESERVATION";
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.leading.equalTo(_titleIcon.mas_trailing).offset(3);
        make.height.mas_equalTo(20);
    }];
    
    _titleBottomLine = [UIView new];
    [self addSubview:_titleBottomLine];
    _titleBottomLine.backgroundColor = [UIColor cyanColor];
    [_titleBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.top.mas_equalTo(34.f);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setupTime
{
    _timeLabel = [UILabel new];
    [self addSubview:_timeLabel];
    _timeLabel.font = TradeGothicLTBold(14);
    _timeLabel.text = @"TIME";
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.textColor = AHYGrey40;
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(46);
        make.height.mas_equalTo(19);
    }];
    
    _timeValueLabel = [UILabel new];
    [self addSubview:_timeValueLabel];
    _timeValueLabel.font = AvenirNextRegular(16);
    _timeValueLabel.textColor = AHYBlack100;
    _timeValueLabel.textAlignment = NSTextAlignmentRight;
    [_timeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    _timeBottomLine = [UIView new];
    [self addSubview:_timeBottomLine];
    _timeBottomLine.backgroundColor = [UIColor cyanColor];
    [_timeBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.equalTo(self);
        make.top.mas_equalTo(74);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setupDate
{
    _dateLabel = [UILabel new];
    [self addSubview:_dateLabel];
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    _dateLabel.font = TradeGothicLTBold(14);
    _dateLabel.textColor = AHYGrey40;
    _dateLabel.text = @"DATE";
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(86);
        make.height.mas_equalTo(19);
    }];
    
    _dateValueLabel = [UILabel new];
    [self addSubview:_dateValueLabel];
    _dateValueLabel.font = AvenirNextRegular(16);
    _dateValueLabel.textColor = AHYBlack100;
    _dateValueLabel.textAlignment = NSTextAlignmentRight;
    [_dateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(84);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    _dateBottomLine = [UIView new];
    [self addSubview:_dateBottomLine];
    _dateBottomLine.backgroundColor = [UIColor cyanColor];
    [_dateBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.equalTo(self);
        make.top.mas_equalTo(114);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setupTopic
{
    _topicLabel = [UILabel new];
    [self addSubview:_topicLabel];
    _topicLabel.textAlignment = NSTextAlignmentLeft;
    _topicLabel.font = TradeGothicLTBold(14);
    _topicLabel.textColor = AHYGrey40;
    _topicLabel.text = @"TOPIC";
    [_topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(126);
        make.height.mas_equalTo(19);
    }];
    
    _topicValueLabel = [UILabel new];
    [self addSubview:_topicValueLabel];
    _topicValueLabel.font = AvenirNextRegular(16);
    _topicValueLabel.textColor = AHYBlack100;
    _topicValueLabel.textAlignment = NSTextAlignmentRight;
    [_topicValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(124);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    _topicBottomLine = [UIView new];
    [self addSubview:_dateBottomLine];
    _topicBottomLine.backgroundColor = [UIColor cyanColor];
    [_topicBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.equalTo(self);
        make.top.mas_equalTo(154);
        make.height.mas_equalTo(0.5);
    }];

    
}

- (void)setupMoney
{
    _moneyLabel = [UILabel new];
    [self addSubview:_moneyLabel];
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.font = TradeGothicLTBold(14);
    _moneyLabel.textColor = AHYGrey40;
    _moneyLabel.text = @"PRICE PAID";
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(166);
        make.height.mas_equalTo(19);
    }];
    
    _moneyValueLabel = [UILabel new];
    [self addSubview:_moneyValueLabel];
    _moneyValueLabel.font = AvenirNextRegular(16);
    _moneyValueLabel.textColor = AHYBlack100;
    _moneyValueLabel.textAlignment = NSTextAlignmentRight;
    [_moneyValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(164);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    _moneyBottomLine = [UIView new];
    [self addSubview:_moneyBottomLine];
    _moneyBottomLine.backgroundColor = [UIColor cyanColor];
    [_moneyBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.equalTo(self);
        make.top.mas_equalTo(194);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setupNote
{
    _noteLabel = [UILabel new];
    [self addSubview:_noteLabel];
    _noteLabel.textAlignment = NSTextAlignmentLeft;
    _noteLabel.font = TradeGothicLTBold(14);
    _noteLabel.textColor = AHYGrey40;
    _noteLabel.text = @"RESERVATION NOTE";
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(_moneyBottomLine.mas_bottom).offset(10);
        make.height.mas_equalTo(19);
    }];
    
    _noteTextView = [JSQMessagesCellTextView new];
    [self addSubview:_noteTextView];
    _noteTextView.font = AvenirNextRegular(16);
    _noteTextView.textColor = AHYBlack100;
    
    [_noteTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(_noteLabel.mas_bottom).offset(4);
        make.trailing.mas_equalTo(self).offset(-10);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
