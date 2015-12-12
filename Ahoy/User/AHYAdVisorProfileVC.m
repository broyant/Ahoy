//
//  AHYAdVisorProfileVC.m
//  Ahoy
//
//  Created by chunlian on 15/12/4.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYAdVisorProfileVC.h"
#import "UIProfileHeaderView.h"
#import "UIUserIntroductionView.h"
#import "UIUserScoreView.h"
#import "UIAdvisePageScrollView.h"
#import "UIUserReviewsView.h"
#import "Masonry.h"

#define headerViewHeight    160
#define scoreViewHeight     90
#define imageScrollViewHeight     250
#define recommandAdvisorViewHeight     224
#define bottomButtonHeight      50

@interface AHYAdVisorProfileVC ()
{
    UIProfileHeaderView *_headerView;
    UIUserScoreView *_scoreView;
    UIAdvisePageScrollView  *_imageScollView;
    UIUserReviewsView   *_reviewsView;
    UIAdvisePageScrollView  *_recommandAdvisorView;

    UIUserIntroductionView *_introductionTable;
    
    UIButton    *_backBtn;
    UIButton    *_shareBtn;
    UIButton    *_reserveBtn;
    UIButton    *_chatBtn;
}

@end

@implementation AHYAdVisorProfileVC

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    _headerView = [[UIProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, headerViewHeight)];
    _headerView.backgroundColor = AHYBlue;
    [self.view addSubview:_headerView];
    
    _introductionTable = [[UIUserIntroductionView alloc] initWithFrame:CGRectMake(0, headerViewHeight+30, DeviceScreenWidth, DeviceScreenHeight-headerViewHeight-bottomButtonHeight-30)];
    _introductionTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_introductionTable];
    
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    
    _scoreView = [[UIUserScoreView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, scoreViewHeight)];
    _scoreView.backgroundColor = [UIColor whiteColor];
    [header addSubview:_scoreView];
    
    _imageScollView = [[UIAdvisePageScrollView alloc] initWithFrame:CGRectMake(0, scoreViewHeight, DeviceScreenWidth, imageScrollViewHeight) scrollType:CollectionPageScroll];
    _imageScollView.backgroundColor = [UIColor whiteColor];
    [header addSubview:_imageScollView];
    
    _reviewsView = [[UIUserReviewsView alloc] init];
    _reviewsView.backgroundColor = [UIColor whiteColor];
    [header addSubview:_reviewsView];
    CGFloat height = [_reviewsView getheight];
    _reviewsView.frame = CGRectMake(0, scoreViewHeight+imageScrollViewHeight, DeviceScreenWidth, height);
    
    header.frame = CGRectMake(0, 0, DeviceScreenWidth, scoreViewHeight+imageScrollViewHeight+_reviewsView.frame.size.height);
    [_introductionTable setTableViewHeader:header];
    
    _recommandAdvisorView = [[UIAdvisePageScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, recommandAdvisorViewHeight) scrollType:CollectionNomalScroll];
    _recommandAdvisorView.backgroundColor = [UIColor whiteColor];
    [_introductionTable setTableViewFooter:_recommandAdvisorView];
    
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 39, kNavBarHeight)];
    [_backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 15, 15, 15)];
    [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(DeviceScreenWidth-41, kStatusBarHeight, 36, kNavBarHeight)];
    [_shareBtn setImage:[UIImage imageNamed:@"shareButton"] forState:UIControlStateNormal];
    [_shareBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 10, 15, 10)];
    [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareBtn];
    
    _reserveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, DeviceScreenHeight-bottomButtonHeight, DeviceScreenWidth/2, bottomButtonHeight)];
    _reserveBtn.backgroundColor = AHYBlue;
    _reserveBtn.titleLabel.font = TradeGothicLTBoldTwo(18);
    [_reserveBtn setTitle:@"Reserve" forState:UIControlStateNormal];
    [_reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_reserveBtn];
    
    _chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(DeviceScreenWidth/2, DeviceScreenHeight-bottomButtonHeight, DeviceScreenWidth/2, bottomButtonHeight)];
    _chatBtn.backgroundColor = AHYYellow;
    _chatBtn.titleLabel.font = TradeGothicLTBoldTwo(18);
    [_chatBtn setTitle:@"Chat" forState:UIControlStateNormal];
    [_chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_chatBtn];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)shareAction {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
