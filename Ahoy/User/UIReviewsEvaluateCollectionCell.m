//
//  UIReviewsEvaluateCollectionCell.m
//  Ahoy
//
//  Created by chunlian on 16/1/18.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "UIReviewsEvaluateCollectionCell.h"
#import "Masonry.h"

#define leftOffset  15

@implementation UIReviewsEvaluateCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = AHYGrey40;
        self.titleLabel.font = TradeGothicLTBoldTwo(14);
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(18);
            make.leading.offset(leftOffset);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 19));
        }];
        
        self.positiveButton = [[UIButton alloc] init];
        self.positiveButton.backgroundColor = [UIColor clearColor];
        [self.positiveButton setTitleColor:AHYYellow forState:UIControlStateNormal];
        self.positiveButton.titleLabel.font = AvenirNextRegular(16);
        [self.positiveButton addTarget:self action:@selector(positiveButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.positiveButton];
        [self.positiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
            make.leading.offset(8);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth/3-16, 30));
        }];
        
        UIView  *dividerVertical = [[UIView alloc] init];
        dividerVertical.backgroundColor = AHYGrey10;
        [self addSubview:dividerVertical];
        [dividerVertical mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.positiveButton.mas_top).offset(5);
            make.leading.equalTo(self.positiveButton.mas_trailing).offset(7.5);
            make.size.mas_equalTo(CGSizeMake(0.5, 16));
        }];
        
        self.neutralButton = [[UIButton alloc] init];
        self.neutralButton.backgroundColor = [UIColor clearColor];
        [self.neutralButton setTitleColor:AHYSteelGrey forState:UIControlStateNormal];
        self.neutralButton.titleLabel.font = AvenirNextRegular(16);
        [self.neutralButton addTarget:self action:@selector(neutralButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.neutralButton];
        [self.neutralButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.positiveButton.mas_top);
            make.leading.equalTo(dividerVertical.mas_trailing).offset(8);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth/3-16, 30));
        }];
        
        UIView  *dividerVertical1 = [[UIView alloc] init];
        dividerVertical1.backgroundColor = AHYGrey10;
        [self addSubview:dividerVertical1];
        [dividerVertical1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.positiveButton.mas_top).offset(5);
            make.leading.equalTo(self.neutralButton.mas_trailing).offset(7.5);
            make.size.mas_equalTo(CGSizeMake(0.5, 16));
        }];
        
        self.negativeButton = [[UIButton alloc] init];
        self.negativeButton.backgroundColor = [UIColor clearColor];
        [self.negativeButton setTitleColor:AHYRed forState:UIControlStateNormal];
        self.negativeButton.titleLabel.font = AvenirNextRegular(16);
        [self.negativeButton addTarget:self action:@selector(negativeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.negativeButton];
        [self.negativeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.positiveButton.mas_top);
            make.leading.equalTo(dividerVertical1.mas_trailing).offset(8);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth/3-16, 30));
        }];
        
        UIView  *dividerView = [[UIView alloc] init];
        dividerView.backgroundColor = AHYGrey10;
        [self addSubview:dividerView];
        [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.positiveButton.mas_bottom).offset(15);
            make.leading.offset(leftOffset);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-leftOffset, 0.5));
        }];
    }
    return self;
}

- (void)positiveButtonAction
{
    if (self.positiveButton.backgroundColor == [UIColor clearColor]) {
        self.positiveButton.backgroundColor = AHYYellow;
        [self.positiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.positiveButton.backgroundColor = [UIColor clearColor];
        [self.positiveButton setTitleColor:AHYYellow forState:UIControlStateNormal];
    }
}

- (void)neutralButtonAction
{
    if (self.neutralButton.backgroundColor == [UIColor clearColor]) {
        self.neutralButton.backgroundColor = AHYSteelGrey;
        [self.neutralButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.neutralButton.backgroundColor = [UIColor clearColor];
        [self.neutralButton setTitleColor:AHYSteelGrey forState:UIControlStateNormal];
    }
}

- (void)negativeButtonAction
{
    if (self.negativeButton.backgroundColor == [UIColor clearColor]) {
        self.negativeButton.backgroundColor = AHYRed;
        [self.negativeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.negativeButton.backgroundColor = [UIColor clearColor];
        [self.negativeButton setTitleColor:AHYRed forState:UIControlStateNormal];
    }
}


@end
