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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return  self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -configure

- (void)configure:(AHYTopic *)topic {
    [_topicImageView sd_setImageWithURL:[NSURL URLWithString:topic.imgUrl]
                       placeholderImage:nil
                                options:SDWebImageContinueInBackground | SDWebImageProgressiveDownload ];
    _topicLabel.text = topic.name;
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
        make.leading.offset(15);
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.top.offset(0);
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
