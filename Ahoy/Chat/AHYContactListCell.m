//
//  AHYContactListCell.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/21.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYContactListCell.h"
#import "TTTAttributedLabel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface  AHYContactListCell()
{
    UIImageView *_avatarImageView;
    TTTAttributedLabel *_nameLabel;
    UILabel *_companyLabel;
    TTTAttributedLabel *_topicLabel;
    TTTAttributedLabel *_timeLabel;
    UIView *_bottomLine;
}

@property (nonatomic,strong) OTRBuddy *buddy;

@property (nonatomic,strong) NSString *keyword;

@end

@implementation AHYContactListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = AHYWhite;
        UIView * selectedBackgroundView = [[UIView alloc] init];
        [selectedBackgroundView setBackgroundColor:AHYGrey5]; // set color here
        [self setSelectedBackgroundView:selectedBackgroundView];
        [self setupSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - SubViews

- (void)setupSubViews
{
    [self setupAvatarImageView];
    [self setupNameLabel];
    [self setupCompanyLabel];
    [self setupTopicLabel];
    [self setupTimeLabel];
    [self setupBottomLine];
}

- (void)setupAvatarImageView
{
    _avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_avatarImageView];
    _avatarImageView.backgroundColor = [UIColor yellowColor];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.width.height.mas_equalTo(60);
        make.top.mas_equalTo(15);
    }];
}

- (void)setupNameLabel
{
    _nameLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = TradeGothicLTBoldTwo(18);
    _nameLabel.textColor = AHYBlack100;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_avatarImageView.mas_trailing).offset(10);
        make.top.equalTo(_avatarImageView.mas_top);
        make.height.mas_equalTo(24);
        make.width.mas_lessThanOrEqualTo(kScreenWidth/2);
    }];
}

- (void)setupCompanyLabel
{
    _companyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _companyLabel.font = AvenirNextRegular(14);
    _companyLabel.textColor = AHYSteelGrey;
    _companyLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_companyLabel];
    [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_trailing).offset(4);
        make.bottom.equalTo(_nameLabel.mas_bottom);
        make.height.mas_equalTo(19);
    }];
}

- (void)setupTimeLabel
{
    _timeLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _timeLabel.font = TradeGothicLTBold(14);
    _timeLabel.textColor = AHYSteelGrey;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-14);
        make.bottom.equalTo(_nameLabel);
        make.height.mas_equalTo(16);
    }];
}


- (void)setupTopicLabel
{
    _topicLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _topicLabel.font = AvenirNextRegular(16);
    _topicLabel.textColor = AHYBlack100;
    _topicLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_topicLabel];
    [_topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(22);
    }];
}


- (void)setupBottomLine
{
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = AHYGrey10;
    [self.contentView addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.and.bottom.equalTo(self);
        make.height.mas_equalTo(2);
    }];
}



- (void)configureWithOTRBuddy:(OTRBuddy *)buddy keyword:(NSString *)keyword
{
    _buddy = buddy;
    _keyword = keyword;
    
    if(_buddy.avatarData) {
        _avatarImageView.image = [UIImage imageWithData:_buddy.avatarData];
    }
    else if(_buddy.avatarURL.length)
    {
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_buddy.avatarURL] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image)
            {
                _buddy.avatarData = UIImageJPEGRepresentation(image, 1.0);
            }
        }];
    }
    else
    {
        _avatarImageView.image = [UIImage imageNamed:@"avatar_default.png"];
    }
    
    _nameLabel.text = _buddy.displayName;
    
    NSString *company = [_buddy.extraInfoAttr valueForKey:@"ahy_company"];
    _companyLabel.text = [NSString stringWithFormat:@" -%@",company];
    
    NSString *topic = [_buddy.extraInfoAttr valueForKey:@"ahy_topic"];
    _topicLabel.text = [NSString stringWithFormat:@"Topic: %@",topic];
    
    _timeLabel.text = [self dateString:_buddy.lastMessageDate];

}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}


#pragma private - APIs
- (NSString *)dateString:(NSDate *)messageDate
{
    NSTimeInterval timeInterval = fabs([messageDate timeIntervalSinceNow]);
    NSString * dateString = nil;
    if (timeInterval < 60){
        dateString = @"刚刚";
    }
    else if (timeInterval < 60*60) {
        int minsInt = timeInterval/60;
        NSString * minString = @"分钟前";
        if (minsInt == 1) {
            minString = @"分钟前";
        }
        dateString = [NSString stringWithFormat:@"%d %@",minsInt,minString];
    }
    else if (timeInterval < 60*60*24){
        // show time in format 11:00 PM
        dateString = [NSDateFormatter localizedStringFromDate:messageDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    }
    else if (timeInterval < 60*60*24*7) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEE" options:0 locale:[NSLocale currentLocale]];
        dateString = [dateFormatter stringFromDate:messageDate];
        
    }
    else if (timeInterval < 60*60*25*365) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"dMMM" options:0
                                                                    locale:[NSLocale currentLocale]];
        dateString = [dateFormatter stringFromDate:messageDate];
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"dMMMYYYY" options:0
                                                                    locale:[NSLocale currentLocale]];
        dateString = [dateFormatter stringFromDate:messageDate];
    }
    return dateString;
}


@end
