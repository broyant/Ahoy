//
//  UIUserScoreView.m
//  Ahoy
//
//  Created by chunlian on 15/12/13.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIUserScoreView.h"
#import "Masonry.h"

#define leftOffset  15

@interface UIUserScoreView ()
{
    UILabel *_pointLabel;
    UILabel *_pointUnit;
    
    UILabel *_hourLabel;
    UILabel *_hourUnit;
}

@end

@implementation UIUserScoreView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.numberOfLines = 1;
        _hourLabel.backgroundColor = [UIColor whiteColor];
        _hourLabel.font = TradeGothicLTBold(54);
        _hourLabel.textColor = RGBCOLORA(193, 194, 195, 1);
        _hourLabel.text = @"$66";//最多显示4位数字，超过$9999，则显示为10k
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_hourLabel];
        [_hourLabel sizeToFit];
        [_hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.width.mas_lessThanOrEqualTo(DeviceScreenWidth/2-2*leftOffset);
            make.height.mas_equalTo(64);
            make.leading.mas_equalTo((DeviceScreenWidth/2-_hourLabel.frame.size.width)/2);
        }];
        
        _hourUnit = [[UILabel alloc] init];
        _hourUnit.numberOfLines = 1;
        _hourUnit.backgroundColor = [UIColor clearColor];
        _hourUnit.font = TradeGothicLTBold(18);
        _hourUnit.textColor = AHYBlue;
        _hourUnit.text = @"/HOUR";
        [self addSubview:_hourUnit];
        [_hourUnit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(_hourLabel.mas_trailing).offset(4);
            make.top.equalTo(_hourLabel.mas_top).offset(40);
            make.size.mas_equalTo(CGSizeMake(48, 21));
        }];
        
        UIImageView *forwadImage = [[UIImageView alloc] init];
        [forwadImage setImage:[UIImage imageNamed:@"forwardArrow"]];
        [self addSubview:forwadImage];
        [forwadImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_hourUnit.mas_trailing).offset(3);
            make.top.equalTo(_hourUnit.mas_top).offset(5);
            make.size.mas_equalTo(CGSizeMake(7, 12));
        }];
        
        _pointLabel = [[UILabel alloc] init];
        _pointLabel.numberOfLines = 1;
        _pointLabel.backgroundColor = [UIColor whiteColor];
        _pointLabel.font = TradeGothicLTBold(54);
        _pointLabel.textColor = RGBCOLORA(193, 194, 195, 1);
        _pointLabel.text = @"268";
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pointLabel];
        [_pointLabel sizeToFit];
        [_pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.trailing.mas_lessThanOrEqualTo(-leftOffset);
            make.width.mas_lessThanOrEqualTo(DeviceScreenWidth/2-2*leftOffset);
            make.height.mas_equalTo(64);
            make.leading.mas_equalTo((DeviceScreenWidth/2-_pointLabel.frame.size.width)/2+DeviceScreenWidth/2);
        }];
        
        _pointUnit = [[UILabel alloc] init];
        _pointUnit.numberOfLines = 1;
        _pointUnit.backgroundColor = [UIColor clearColor];
        _pointUnit.font = TradeGothicLTBoldTwo(18);
        _pointUnit.textColor = AHYBlue;
        _pointUnit.text = @"POINTS";
        [self addSubview:_pointUnit];
        [_pointUnit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(_pointLabel.mas_trailing).offset(3);
            make.top.equalTo(_pointLabel.mas_top).offset(39);
            make.size.mas_equalTo(CGSizeMake(63, 22));
        }];
        
        UIImageView *forwad = [[UIImageView alloc] init];
        [forwad setImage:[UIImage imageNamed:@"forwardArrow"]];
        [self addSubview:forwad];
        [forwad mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_pointUnit.mas_trailing).offset(3);
            make.top.equalTo(_pointUnit.mas_top).offset(5);
            make.size.mas_equalTo(CGSizeMake(7, 12));
        }];
        
        return self;
    }
    return nil;
}


@end
