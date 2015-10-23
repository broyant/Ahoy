//
//  AHYSingleTopicCell.m
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYSingleTopicCell.h"
#import "Masonry.h"

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
