//
//  UIUserReviewsView.m
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIUserReviewsView.h"
#import "CustomTagView.h"
#import "AHYReviewTag.h"
#import "AVStarsView.h"
#import "Masonry.h"

#define leftOffset  15
#define topOffset  18
#define bottomOffset  25

@interface UIUserReviewsView ()
{
    AVStarsView  *_starsView;
    CustomTagView *_tagView;
    
    UILabel *_titleLabel;
    UILabel *_countLabel;
    UIView *_reviewCell;
    UIButton  *_reviewBtn;
    UIButton  *_moreBtn;
    
    CGFloat _totalHeight;
}

@end

@implementation UIUserReviewsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _totalHeight = 0;
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, _totalHeight, DeviceScreenWidth-2*leftOffset, 0.5)];
        dividerView.backgroundColor = AHYGrey10;
        [self addSubview:dividerView];
        _totalHeight += topOffset;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, _totalHeight, DeviceScreenWidth-2*leftOffset, 19)];
        _titleLabel.numberOfLines = 1;
        _titleLabel.text = @"YIKAI’S REVIEWS";
        _titleLabel.font = TradeGothicLTBoldTwo(14);
        _titleLabel.textColor = AHYGrey40;
        [self addSubview:_titleLabel];
        _totalHeight += 19;
        
        [self addStarsView];
        
        [self addReviewCountView];
        
        [self addTagView];
        
        [self addReviewContentView];
        
        [self addViewButton];
        
        return self;
    }
    return nil;
}

- (void)addStarsView
{
    _starsView = [[AVStarsView alloc] initWithFrame:CGRectMake(0, 0, 95, 15)];
    _starsView.count = 5;
    _starsView.rating = 5;
    _starsView.onColor = AHYYellow;
    _starsView.offColor = AHYGrey28;
    [self addSubview:_starsView];
    [_starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleLabel.mas_leading);
        make.top.equalTo(_titleLabel.mas_bottom).offset(7);
        make.size.mas_equalTo(CGSizeMake(95, 15));
    }];
    _totalHeight += 7 + 15;
}

- (void)addReviewCountView
{
    _countLabel = [[UILabel alloc] init];
    _countLabel.numberOfLines = 1;
    _countLabel.text = @"50 Reviews";
    _countLabel.font = TradeGothicLT(12);
    _countLabel.textColor = RGBCOLORA(144, 146, 148, 1);
    [self addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.offset(-leftOffset);
        make.top.equalTo(_starsView.mas_top);
        make.height.mas_equalTo(15);
    }];
}

- (void)addTagView
{
    _tagView = [[CustomTagView alloc] init];
    _tagView.backgroundColor = [UIColor clearColor];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<10; i++) {
        NSDictionary *dict = nil;
        if (i<5) {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"tagId",@"Patients",@"tagName",@"1",@"isHighlight",[NSString stringWithFormat:@"%d",i*i],@"numberOfReviews", nil];
        } else {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"tagId",@"Knowledgeable",@"tagName",@"0",@"isHighlight",[NSString stringWithFormat:@"%d",i*i],@"numberOfReviews", nil];
        }
        
        AHYReviewTag *tag = [[AHYReviewTag alloc] init];
        [tag parse:dict];
        [array addObject:tag];
    }
    [_tagView setTags:array];
    CGSize size = [_tagView fittedSize];
    [self addSubview:_tagView];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starsView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(size.width, size.height));
    }];
    _totalHeight += 15 + size.height;
}

- (void)addReviewContentView
{
    _reviewCell = [[UIView alloc] init];
    _reviewCell.backgroundColor = [UIColor clearColor];
    [self addSubview:_reviewCell];
    [_reviewCell mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_tagView) {
            make.top.equalTo(_tagView.mas_bottom).offset(25);
        } else {
            make.top.equalTo(_starsView.mas_bottom).offset(25);
        }
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth, 112));
    }];
    
    _totalHeight += 25 + 112;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [_reviewCell addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = TradeGothicLT(16);
    titleLabel.textColor = AHYBlack100;
    titleLabel.numberOfLines = 1;
    titleLabel.backgroundColor = [UIColor clearColor];
    [_reviewCell addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.leading.equalTo(imageView.mas_trailing).offset(9);
        make.height.mas_equalTo(19);
        make.right.mas_lessThanOrEqualTo(-(66+70+leftOffset+8+9));
    }];
    
    AVStarsView *starsView = [[AVStarsView alloc] initWithFrame:CGRectMake(0, 0, 70, 10)];
    starsView.count = 5;
    starsView.rating = 5;
    starsView.onColor = AHYYellow;
    starsView.offColor = AHYGrey28;
    [_reviewCell addSubview:starsView];
    [starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.leading.equalTo(titleLabel.mas_trailing).offset(8);
        make.size.mas_equalTo(CGSizeMake(70, 10));
    }];
    
    // 日期
    UILabel *otherLabel = [[UILabel alloc] init];
    otherLabel.font = TradeGothicLT(12);
    otherLabel.textColor = AHYSteelGrey;
    otherLabel.numberOfLines = 1;
    otherLabel.backgroundColor = [UIColor clearColor];
    [_reviewCell addSubview:otherLabel];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(2);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = AvenirNextRegular(14);
    subTitleLabel.textColor = AHYSteelGrey;
    subTitleLabel.numberOfLines = 1;
    subTitleLabel.backgroundColor = [UIColor clearColor];
    [_reviewCell addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(3);
        make.leading.equalTo(titleLabel.mas_leading);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(19);
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = AvenirNextRegular(16);
    descLabel.textColor = AHYBlack100;
    descLabel.numberOfLines = 0;
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [_reviewCell addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.leading.equalTo(imageView.mas_leading);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(66);
    }];

    titleLabel.text = @"Howard Lynch";
    subTitleLabel.text = @"Topic: Cursus Euismod";
    starsView.rating = 5;
    otherLabel.text = @"09/12/2015";
    descLabel.text = @"The session with Yikai was incredible. He taught me so about design. I was totally sold on his saying that every detail worth a shit!";
    imageView.image = [UIImage imageNamed:@"c2Topic1Thumbnail"];
}

- (void)addViewButton
{
    if (true) {//可以review
        [self initReviewButton];
        [_reviewBtn setTitle:@"Review Yikai" forState:UIControlStateNormal];
        [_reviewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_reviewCell.mas_bottom).offset(19);
            make.leading.offset(leftOffset);
            if (true) { //有更多
                [self initMoreReviewsButton];
                make.size.mas_equalTo(CGSizeMake((DeviceScreenWidth-2*leftOffset-25)/2, 40));
                [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(_reviewBtn.mas_trailing).offset(25);
                    make.top.equalTo(_reviewCell.mas_bottom).offset(19);
                    make.size.mas_equalTo(CGSizeMake((DeviceScreenWidth-2*leftOffset-25)/2, 40));
                }];
            } else {
                make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 40));
            }
        }];
        _totalHeight += 19 + 40;
    } else if (true) { //有更多
        [self initMoreReviewsButton];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(leftOffset);
            make.top.equalTo(_reviewCell.mas_bottom).offset(19);
            make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 40));
        }];
        _totalHeight += 19 + 40;
    }
}

- (void)initReviewButton
{
    _reviewBtn = [[UIButton alloc] init];
    _reviewBtn.backgroundColor = [UIColor whiteColor];
    _reviewBtn.titleLabel.font = TradeGothicLT(18);
    [_reviewBtn setTitleColor:AHYOrange forState:UIControlStateNormal];
    [_reviewBtn.layer setBorderWidth:1];
    [_reviewBtn.layer setBorderColor:AHYOrange.CGColor];
    [self addSubview:_reviewBtn];
}

- (void)initMoreReviewsButton
{
    _moreBtn = [[UIButton alloc] init];
    _moreBtn.backgroundColor = [UIColor whiteColor];
    _moreBtn.titleLabel.font = TradeGothicLT(18);
    [_moreBtn setTitleColor:AHYBlue forState:UIControlStateNormal];
    [_moreBtn setTitle:@"More Reviews" forState:UIControlStateNormal];
    [_moreBtn.layer setBorderWidth:1];
    [_moreBtn.layer setBorderColor:AHYBlue.CGColor];
    [self addSubview:_moreBtn];
}

- (CGFloat)getheight
{
    return _totalHeight + bottomOffset;
}

@end
