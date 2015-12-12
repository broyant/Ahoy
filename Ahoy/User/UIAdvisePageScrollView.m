//
//  UIAdvisePageScrollView.m
//  Ahoy
//
//  Created by chunlian on 15/11/13.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIAdvisePageScrollView.h"
#import "Masonry.h"
#import "UIAdvisorPageCollectionCell.h"
#import "UIAdvisorNormalCollectionCell.h"

#define collectionCellWidth      105
#define collectionNormalCellHeight     141
#define collectionPageCellHeight     126

#define defaultCount    10

#define leftOffset  15

@interface UIAdvisePageScrollView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    UILabel *_descLabel;
    UILabel *_titleLabel;
    
    NSInteger   _pageNumber;
    NSInteger   _pageIndex;
    NSUInteger   _collectionType;
}

@end

@implementation UIAdvisePageScrollView

- (id)initWithFrame:(CGRect)frame scrollType:(NSUInteger)type
{
    if (self = [super initWithFrame:frame]) {
        
        _collectionType = type;
        
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-2*leftOffset, 0.5)];
        dividerView.backgroundColor = AHYGrey10;
        [self addSubview:dividerView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = TradeGothicLTBoldTwo(14);
        _titleLabel.textColor = AHYBlack100;
        _titleLabel.numberOfLines = 1;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(19);
            make.leading.mas_equalTo(leftOffset);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 19));
        }];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 55, DeviceScreenWidth, collectionNormalCellHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_collectionView];
        
        if (_collectionType == CollectionPageScroll) {
            _titleLabel.text = @"TOPICS THAT PAUL CAN ADVISE";
            
            _collectionView.frame = CGRectMake(0, 55, DeviceScreenWidth, collectionPageCellHeight);
            [_collectionView registerClass:[UIAdvisorPageCollectionCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
            
            UIView *coverView = [[UIView alloc] initWithFrame:_collectionView.frame];
            coverView.backgroundColor = [UIColor clearColor];
            [self addSubview:coverView];
            
            UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionForSwipeGestureRecognizer:)];
            gesture.direction = UISwipeGestureRecognizerDirectionLeft;
            [coverView addGestureRecognizer:gesture];
            
            UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionForSwipeGestureRecognizer:)];
            rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
            [coverView addGestureRecognizer:rightGesture];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForTapGestureRecognizerForSelectedIndex:)];
            [coverView addGestureRecognizer:tapGesture];
            
            _descLabel = [[UILabel alloc] init];
            _descLabel.font = AvenirNextRegular(16);
            _descLabel.textColor = AHYBlack100;
            _descLabel.numberOfLines = 2;
            _descLabel.backgroundColor = [UIColor clearColor];
            _descLabel.text = @"0 Here is what I think I can advise on the topic of Tellus Amet, and why I am worth the price or not";
            [self addSubview:_descLabel];
            [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_collectionView.mas_bottom).offset(8);
                make.leading.mas_equalTo(leftOffset);
                make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 44));
            }];
        } else if (_collectionType == CollectionNomalScroll) {
            _titleLabel.text = @"OTHER ADVISORS YOU MAY LIKE";

            [_collectionView registerClass:[UIAdvisorNormalCollectionCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
            _collectionView.showsHorizontalScrollIndicator = NO;
        }
        
        _pageNumber = defaultCount;
        _pageIndex = 0;
        
        return self;
    }
    return nil;
}

- (NSInteger)indexForRowAtPoint:(CGPoint)point
{
    NSInteger index = -1;
    
    for (NSInteger i = 0; i < _pageNumber; i++) {
        UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if (CGRectContainsPoint(cell.frame, point)) {
            index = i;
        }
    }

    return index;
}

- (void)actionForSwipeGestureRecognizer:(UISwipeGestureRecognizer *)swipeGestureRecognizer
{
    NSInteger firstVisibleRowIndex = _pageIndex;
    UIAdvisorPageCollectionCell *otherCell = (UIAdvisorPageCollectionCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:firstVisibleRowIndex inSection:0]];
    [otherCell setHighlighted:NO];

    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (![self didScrolledToTheEndOfScrollView]) {
            firstVisibleRowIndex++;
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:firstVisibleRowIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }
    } else {
        if (firstVisibleRowIndex > 0) {
            firstVisibleRowIndex--;
        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:firstVisibleRowIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
    _pageIndex = firstVisibleRowIndex;
    UIAdvisorPageCollectionCell * cell = (UIAdvisorPageCollectionCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_pageIndex inSection:0]];
    [cell setHighlighted:YES];
    _descLabel.text = [NSString stringWithFormat:@"%ld Here is what I think I can advise on the topic of Tellus Amet, and why I am worth the price or not",_pageIndex];
}

- (void)actionForTapGestureRecognizerForSelectedIndex:(UITapGestureRecognizer *)tapGestureRecognizer
{
    UIAdvisorPageCollectionCell *otherCell = (UIAdvisorPageCollectionCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_pageIndex inSection:0]];
    [otherCell setHighlighted:NO];
    
    UIView *touchView = tapGestureRecognizer.view;
    CGPoint touchPoint = [tapGestureRecognizer locationInView:touchView];
    CGPoint realTouchPoint = CGPointMake(_collectionView.contentOffset.x + touchPoint.x, _collectionView.contentOffset.y + touchPoint.y);
    
    _pageIndex = [self indexForRowAtPoint:realTouchPoint];
    UIAdvisorPageCollectionCell * cell = (UIAdvisorPageCollectionCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_pageIndex inSection:0]];
    [cell setHighlighted:YES];
    _descLabel.text = [NSString stringWithFormat:@"%ld Here is what I think I can advise on the topic of Tellus Amet, and why I am worth the price or not",_pageIndex];

    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_pageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


- (BOOL)didScrolledToTheEndOfScrollView
{
    CGFloat contentWidth = _collectionView.contentSize.width;
    CGFloat offsetX = _collectionView.contentOffset.x;
    CGFloat scrollViewWidth = _collectionView.frame.size.width;
    if (contentWidth <= offsetX + scrollViewWidth) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    
    if (_collectionType == CollectionPageScroll) {
        UIAdvisorPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.cellImage.image = [UIImage imageNamed:@"c2Topic1Thumbnail"];
        cell.titleLabel.text = @"Tellus Amet";
        
        if (indexPath.row == _pageIndex) {
            [cell setHighlighted:YES];
        }
        return cell;
    } else if (_collectionType == CollectionNomalScroll) {
        UIAdvisorNormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (indexPath.row%2) {
            cell.titleLabel.text = @"Peter Johnson";
        } else {
            cell.titleLabel.text = @"Sharon";
        }
        cell.cellImage.image = [UIImage imageNamed:@"c2Topic1Thumbnail"];
        return cell;
    }
    
    return nil;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_collectionType == CollectionPageScroll) {
        return CGSizeMake(collectionCellWidth, collectionPageCellHeight);
    }
    return CGSizeMake(collectionCellWidth, collectionNormalCellHeight);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _pageIndex = indexPath.row;
//    UIAdvisorPageCollectionCell * cell = (UIAdvisorPageCollectionCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//    [cell setHighlighted:NO];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
