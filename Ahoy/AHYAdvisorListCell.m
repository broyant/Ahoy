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

@interface AHYAdvisorListCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) AVStarsView *starsView;
@property (nonatomic, strong) UILabel *experienceLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
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

#pragma mark -subviews

- (void)setupSubviews {
    [self addPortraitImageView];
    [self addNameLabel];
    [self addPriceLabel];
    [self addStarsView];
    [self addExperienceLabel];
    [self addDescriptionLabel];
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
    _nameLabel.font = TradeGothicLT18;
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
    _priceLabel.font = TradeGothicLT14;
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
    _starsView = [[AVStarsView alloc] init];
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

- (void)addExperienceLabel {
    _experienceLabel = [[UILabel alloc] init];
    _experienceLabel.font = AvenirNextRegular14;
    _experienceLabel.textColor = AHYGrey56;
    [self.contentView addSubview:_experienceLabel];
    [_experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_starsView.mas_bottom).offset(4);
        make.height.mas_equalTo(19);
    }];
}

- (void)addDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = AvenirNextRegular16;
    _descriptionLabel.textColor = AHYBlack100;
    _descriptionLabel.numberOfLines = 2;
    [self.contentView addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_experienceLabel.mas_bottom).offset(4);
        make.trailing.offset(-14);
    }];
}

@end
