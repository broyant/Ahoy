//
//  AHYHorizontalTopicCell.m
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

static NSString * const topicCellIdentifier = @"singleCell";

#import "AHYHorizontalTopicCell.h"
#import "AHYSingleTopicCell.h"
#import "PTEHorizontalTableView.h"
#import "Masonry.h"

@interface AHYHorizontalTopicCell () <PTETableViewDelegate>

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) PTEHorizontalTableView *horizontalScrollView;

@end

@implementation AHYHorizontalTopicCell

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

#pragma mark -PTEHorizontalTableView Delegate

- (NSInteger)tableView:(PTEHorizontalTableView *)horizontalTableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(PTEHorizontalTableView *)horizontalTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AHYSingleTopicCell *topicCell = (AHYSingleTopicCell *)[horizontalTableView.tableView dequeueReusableCellWithIdentifier:topicCellIdentifier];
   //TODO
//    topicCell.topicImageView = nil;
//    topicCell.topicLabel.text = nil;
    return topicCell;
}

- (CGFloat)tableView:(PTEHorizontalTableView *)horizontalTableView widthForCellAtIndexPath:(NSIndexPath *)indexPath {
    return 115.f;
}

- (void)tableView:(PTEHorizontalTableView *)horizontalTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//TODO
    //implement delegate to pass out the touch event
}

#pragma mark -subviews

- (void)setupSubviews {
    [self addHeaderLabel];
    [self addHorizontalScrollView];
    [self addSeparateLine];
}

- (void)addHeaderLabel {
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = TradeGothicLTBoldTwo(14);
    _headerLabel.textColor = AHYGrey40;
    [self.contentView addSubview:_headerLabel];
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.offset(19);
        make.height.mas_equalTo(19);
    }];
}

- (void)addHorizontalScrollView {
    _horizontalScrollView = [[PTEHorizontalTableView alloc] init];
    _horizontalScrollView.tableView = [[UITableView alloc] init];
    _horizontalScrollView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_horizontalScrollView.tableView registerClass:[AHYSingleTopicCell class] forCellReuseIdentifier:topicCellIdentifier];
    
    [self.contentView addSubview:_horizontalScrollView];
    [_horizontalScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerLabel.mas_bottom).offset(17);
        make.leading.trailing.offset(0);
        make.height.mas_equalTo(105);
    }];
}

- (void)addSeparateLine {
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = AHYGrey10;
    [self.contentView addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.equalTo(_horizontalScrollView.mas_bottom).offset(15);
        make.height.mas_equalTo(0.5);
    }];
}

@end
