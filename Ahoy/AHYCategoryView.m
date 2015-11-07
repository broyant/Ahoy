//
//  AHYCategoryView.m
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

static NSString *const kTopicCellIdentifier = @"topicCell";

#import "AHYCategoryView.h"
#import "AHYSingleTopicCell.h"
#import "Masonry.h"

@interface AHYCategoryView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AHYCategoryView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)category topics:(NSArray *)topicArray {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self configure:category topics:topicArray];
    }
    return self;
}

- (void)configure:(NSString *)category  topics:(NSArray *)topicArray {
    _headerLabel.text = category;
    _topics = topicArray;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark -UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _topics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AHYSingleTopicCell *cell = (AHYSingleTopicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTopicCellIdentifier forIndexPath:indexPath];
    [cell configure:_topics[indexPath.item]];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor yellowColor].CGColor;
    return cell;
}

#pragma mark -subviews

- (void)setupSubviews {
    [self addHeaderLabel];
    [self addCollectionView];
    [self addSeparateLine];
}

- (void)addHeaderLabel {
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = TradeGothicLTBoldTwo(14);
    _headerLabel.textColor = AHYGrey40;
    [self addSubview:_headerLabel];
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.top.offset(19);
        make.height.mas_equalTo(19);
    }];
}

- (void)addCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(90, 122);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 20;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[AHYSingleTopicCell class] forCellWithReuseIdentifier:kTopicCellIdentifier];
    
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerLabel.mas_bottom).offset(17);
        make.trailing.offset(0);
        make.leading.offset(15);
        make.height.mas_equalTo(122);
    }];
}

- (void)addSeparateLine {
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = AHYGrey10;
    [self addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.trailing.offset(0);
        make.top.equalTo(_collectionView.mas_bottom).offset(15);
        make.height.mas_equalTo(0.5);
    }];
}

@end
