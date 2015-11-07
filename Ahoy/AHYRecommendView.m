//
//  AHYRecommendView.m
//  Ahoy
//
//  Created by lcj on 15/10/22.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYRecommendView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface AHYRecommendView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *topicNameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) AHYTopic *topic;

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

- (void)topicDidSelected {
    if (self.delegate && [self.delegate respondsToSelector:@selector(recommendTopicDidSelected:)]) {
        [self.delegate recommendTopicDidSelected:_topic];
    }
}

#pragma mark -configure

- (void)configure:(AHYTopic *)topic {
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.imgUrl]
//                  placeholderImage:nil
//                           options:SDWebImageContinueInBackground | SDWebImageProgressiveDownload ];
    _topic = topic;
    _imageView.image = [UIImage imageNamed:topic.imgUrl];
    _topicNameLabel.text = topic.name;
    //TODO separate number with ","
    _descriptionLabel.text = [NSString stringWithFormat:@"%@Advisors|%@Sessions", @(topic.totalAdvisors), @(topic.totalSessions)];
    
}

#pragma mark -subviews

- (void)setupSubviews {
    [self addImageView];
    [self addTopicNameLabel];
    [self addDescriptionLabel];
    [self addTapGesture];
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
    _topicNameLabel.font = TradeGothicLTBoldTwo(20);
    _topicNameLabel.textColor = AHYWhite;
    [self addSubview:_topicNameLabel];
    [_topicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.offset(111);
        make.height.mas_equalTo(25);
    }];
}

- (void)addDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = AvenirNextRegular(12);
    _descriptionLabel.textColor = AHYWhite;
    [self addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.equalTo(_topicNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
    }];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topicDidSelected)];
    [self addGestureRecognizer:tapGesture];
}

@end
