//
//  AHYSingleTopicCell.m
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYSingleTopicCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "AHYTopic.h"

@interface AHYSingleTopicCell ()

@property (nonatomic, strong) UIImageView *topicImageView;
@property (nonatomic, strong) UILabel *topicLabel;

@end

@implementation AHYSingleTopicCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark -configure

- (void)configure:(AHYTopic *)topic {
//    [_topicImageView sd_setImageWithURL:[NSURL URLWithString:topic.imgUrl]
//                       placeholderImage:nil
//                                options:SDWebImageContinueInBackground | SDWebImageProgressiveDownload ];
    _topicImageView.image = [UIImage imageNamed:topic.imgUrl];
    _topicLabel.attributedText = topic.name;
}

#pragma mark -subviews

- (void)setupSubviews {
    [self addTopicImageView];
    [self addTopicLabel];
}

- (void)addTopicImageView {
    _topicImageView = [[UIImageView alloc] init];
    _topicImageView.layer.cornerRadius = 1.f;
    [self.contentView addSubview:_topicImageView];
    [_topicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.offset(0);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
}

- (void)addTopicLabel {
    _topicLabel = [[UILabel alloc] init];
    _topicLabel.font = TradeGothicLT(16);
    _topicLabel.textColor = AHYBlack100;
    _topicLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_topicLabel];
    [_topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_topicImageView.mas_leading);
        make.top.equalTo(_topicImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(22);
    }];
}

@end
