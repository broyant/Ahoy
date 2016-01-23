//
//  UIUserReviewsView.m
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIUserReviewsView.h"
#import "AVStarsView.h"
#import "Masonry.h"
#import "UIReviewsEvaluateCollectionCell.h"
#import "CustomTableViewCell.h"

#define leftOffset  15

#define starViewHeight  96
#define collectionCellHeight  90

#define reviewBtnHeight  40
#define reviewBtnBGViewHeight  (reviewBtnHeight+65)

static NSString *const CollectionCellIdentifier = @"EvaluateCell";


@interface UIUserReviewsView ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate>
{
    AVStarsView  *_starsView;
    
    UICollectionView    *_collectionView;
    UITableView  *_tableView;
    
    UILabel *_titleLabel;
    UILabel *_countLabel;
}

@end

@implementation UIUserReviewsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, frame.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.pagingEnabled = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        _tableView.bounces = YES;
        _tableView.directionalLockEnabled = YES;
        _tableView.alwaysBounceHorizontal = NO;
        _tableView.alwaysBounceVertical = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        if (true) {
            headerView.frame = CGRectMake(0, 0, DeviceScreenWidth, starViewHeight+collectionCellHeight*3);
        } else {
            headerView.frame = CGRectMake(0, 0, DeviceScreenWidth, starViewHeight+collectionCellHeight*3+reviewBtnBGViewHeight);
        }
        _tableView.tableHeaderView = headerView;
        
        UILabel *starLabel = [[UILabel alloc] init];
        starLabel.numberOfLines = 1;
        starLabel.text = @"OVERALL RATING";
        starLabel.font = TradeGothicLTBoldTwo(14);
        starLabel.textColor = AHYGrey40;
        [headerView addSubview:starLabel];
        [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(leftOffset);
            make.top.mas_equalTo(19);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 19));
        }];
        
        _starsView = [[AVStarsView alloc] initWithFrame:CGRectMake(0, 0, 165, 25)];
        _starsView.count = 5;
        _starsView.rating = 5;
        _starsView.onColor = AHYYellow;
        _starsView.offColor = RGBCOLORA(188, 189, 190, 1);
        [headerView addSubview:_starsView];
        [_starsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(starLabel.mas_leading);
            make.top.equalTo(starLabel.mas_bottom).offset(12);
            make.size.mas_equalTo(CGSizeMake(165, 25));
        }];
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.numberOfLines = 1;
        _countLabel.text = @"50 Reviews";
        _countLabel.font = TradeGothicLT(12);
        _countLabel.textColor = RGBCOLORA(144, 146, 148, 1);
        [headerView addSubview:_countLabel];
        [_countLabel sizeToFit];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.offset(-leftOffset);
            make.top.equalTo(starLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(15);
        }];
        
        UIView *dividerView = [[UIView alloc] init];
        dividerView.backgroundColor = AHYGrey10;
        [headerView addSubview:dividerView];
        [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(leftOffset);
            make.top.equalTo(_starsView.mas_bottom).offset(20);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-leftOffset, 0.5));
        }];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(DeviceScreenWidth, collectionCellHeight);
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UIReviewsEvaluateCollectionCell class] forCellWithReuseIdentifier:CollectionCellIdentifier];
        [headerView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(dividerView.mas_bottom).offset(1);
            make.leading.offset(0);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth, collectionCellHeight*3));
        }];
        
        return self;
    }
    return nil;
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIReviewsEvaluateCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"VALUE";
        [cell.positiveButton setTitle:@"Positive (50)" forState:UIControlStateNormal];
        [cell.neutralButton setTitle:@"Neutral (0)" forState:UIControlStateNormal];
        [cell.negativeButton setTitle:@"Negative (0)" forState:UIControlStateNormal];
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"COMMUNICATION";
        [cell.positiveButton setTitle:@"Positive (45)" forState:UIControlStateNormal];
        [cell.neutralButton setTitle:@"Neutral (3)" forState:UIControlStateNormal];
        [cell.negativeButton setTitle:@"Negative (2)" forState:UIControlStateNormal];
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"FRIENDLINESS";
        [cell.positiveButton setTitle:@"Positive (48)" forState:UIControlStateNormal];
        [cell.neutralButton setTitle:@"Neutral (1)" forState:UIControlStateNormal];
        [cell.negativeButton setTitle:@"Negative (9)" forState:UIControlStateNormal];
    }
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(DeviceScreenWidth, collectionCellHeight);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReviewCell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:ReviewCell];
    }
    
    if (indexPath.row%2 == 0) {
        cell.cellImage.image = [UIImage imageNamed:@"c2Topic2Thumbnail"];
        cell.titleLabel.text = @"Howard Lynch";
        cell.subTitleLabel.text = @"Topic: Cursus Euismod";
        cell.otherLabel.text = @"09/11/2015";
        cell.starsView.rating = 2;
        cell.valueEvaluate.text = @"Positive";
        cell.valueEvaluate.textColor = AHYYellow;
        cell.communicateEvaluate.text = @"Neutral";
        cell.communicateEvaluate.textColor = AHYSteelGrey;
        cell.friendlyEvaluate.text = @"Negative";
        cell.friendlyEvaluate.textColor = AHYRed;
        cell.descLabel.text = @"The session with Yikai was incredible. He taught me so about design. I was totally sold on his saying that every detail worth a shit!";
    } else {
        cell.cellImage.image = [UIImage imageNamed:@"c1Topic2Thumbnail"];
        cell.titleLabel.text = @"Anonymous User";
        cell.subTitleLabel.text = @"Topic: Inceptos Lorem Mattis";
        cell.otherLabel.text = @"09/11/2015";
        cell.starsView.rating = 4.5;
        cell.valueEvaluate.text = @"Positive";
        cell.valueEvaluate.textColor = AHYYellow;
        cell.communicateEvaluate.text = @"Positive";
        cell.communicateEvaluate.textColor = AHYYellow;
        cell.friendlyEvaluate.text = @"Positive";
        cell.friendlyEvaluate.textColor = AHYYellow;
        cell.descLabel.text = @"The session with Yikai was incredible. He taught me so about design. I was totally sold on his saying that every detail worth a shit!";
    }

    [cell.descLabel sizeToFit];
    
    [cell.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.descLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(DeviceScreenWidth-leftOffset);
        make.leading.mas_equalTo(leftOffset);
        make.height.mas_equalTo(0.5);
    }];
    
    return cell;
}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"The session with Yikai was incredible. He taught me so about design. I was totally sold on his saying that every detail worth a shit!";
    NSDictionary *attributes = @{NSFontAttributeName:AvenirNextRegular(16)};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(DeviceScreenWidth-2*leftOffset, MAXFLOAT)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attributes
                                    context:nil];
    return ceil(rect.size.height+203+21);
}


@end
