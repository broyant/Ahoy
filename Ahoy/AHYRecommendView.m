//
//  AHYRecommendView.m
//  Ahoy
//
//  Created by lcj on 15/10/22.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYRecommendView.h"
#import "Masonry.h"

@interface AHYRecommendView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *topicNameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation AHYRecommendView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return  self;
}

#pragma mark -subviews

- (void)setupSubviews {
    [self addImageView];
    [self addTopicNameLabel];
    [self addDescriptionLabel];
}

- (void)addImageView {
    _imageView = [[UIImageView alloc] init];
    [self insertSubview:_imageView atIndex:0];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)addTopicNameLabel {
    _topicNameLabel = [[UILabel alloc] init];
    _topicNameLabel.font = TradeGothicLTBoldTwo20;
    _topicNameLabel.textColor = AHYWhite;
    [self addSubview:_topicNameLabel];
    [_topicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.offset(175);
        make.height.mas_equalTo(25);
    }];
}

- (void)addDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = AvenirNextRegular12;
    _descriptionLabel.textColor = [UIColor whiteColor];
    [self addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.equalTo(_topicNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
    }];
}

@end
