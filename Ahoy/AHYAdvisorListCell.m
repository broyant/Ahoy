//
//  AHYAdvisorListCell.m
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYAdvisorListCell.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "AVStarsView.h"
#import "AHYAdvisor.h"
#import "UIImageView+WebCache.h"

@interface AHYAdvisorListCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) AVStarsView *starsView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *experienceLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation AHYAdvisorListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark -configure

- (void)configure:(AHYAdvisor *)advisor {
//   [_portraitImageView sd_setImageWithURL:[NSURL URLWithString:advisor.portraitUrl]
//                         placeholderImage:nil
//                                  options:SDWebImageContinueInBackground | SDWebImageProgressiveDownload];
    _portraitImageView.image = [UIImage imageNamed:advisor.portraitUrl];
    _nameLabel.text = advisor.name;
    _titleLabel.text = advisor.title;
    _experienceLabel.text = advisor.experience;
    _starsView.rating = advisor.rate;
    _priceLabel.text = [NSString stringWithFormat:@"$%@HR", @(advisor.price)];
}

#pragma mark -subviews

- (void)setupSubviews {
    [self addPortraitImageView];
    [self addNameLabel];
    [self addPriceLabel];
    [self addStarsView];
    [self addTitleLabel];
    [self addExperienceLabel];
    [self addSeparateLine];
}

- (void)addPortraitImageView {
    _portraitImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_portraitImageView];
    [_portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.width.height.mas_equalTo(50);
        make.top.offset(19);
    }];
}

- (void)addNameLabel {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = TradeGothicLT(18);
    _nameLabel.textColor = AHYBlack100;
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_portraitImageView.mas_trailing).offset(10);
        make.top.equalTo(_portraitImageView.mas_top);
        make.height.mas_equalTo(24);
    }];
}

- (void)addPriceLabel {
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = TradeGothicLT(14);
    _priceLabel.backgroundColor = AHYGrey28;
    _priceLabel.textColor = AHYWhite;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.offset(0);
        make.top.equalTo(_nameLabel.mas_top);
        make.height.mas_equalTo(25);
    }];
}

- (void)addStarsView {
    _starsView = [[AVStarsView alloc] initWithFrame:CGRectMake(0, 0, 80, 10)];
    _starsView.count = 5;
    _starsView.rating = 5;
    _starsView.onColor = AHYYellow;
    _starsView.offColor = AHYGrey28;
    [self.contentView addSubview:_starsView];
    [_starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_nameLabel.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(80, 10));
    }];
}

- (void)addTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = AvenirNextRegular(14);
    _titleLabel.textColor = AHYSteelGrey;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_starsView.mas_bottom).offset(4);
        make.height.mas_equalTo(19);
    }];
}

- (void)addExperienceLabel {
    _experienceLabel = [[UILabel alloc] init];
    _experienceLabel.font = AvenirNextRegular(16);
    _experienceLabel.textColor = AHYBlack100;
    _experienceLabel.numberOfLines = 2;
    [self.contentView addSubview:_experienceLabel];
    [_experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_titleLabel.mas_bottom).offset(4);
        make.trailing.offset(-14);
    }];
}

- (void)addSeparateLine {
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = AHYGrey10;
    [self.contentView addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_portraitImageView.mas_leading);
        make.trailing.offset(0);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_experienceLabel.mas_bottom).offset(10);
    }];
}

@end
