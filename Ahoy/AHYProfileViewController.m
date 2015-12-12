//
//  AHYProfileViewController.m
//  Ahoy
//
//  Created by chunlian on 15/11/9.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYProfileViewController.h"
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


@interface AHYProfileViewController ()
{
    UIProfileHeaderView *_headerView;
    UIUserScoreView *_scoreView;
    UIAdvisePageScrollView  *_imageScollView;
    UIUserReviewsView   *_reviewsView;
    
    UIUserIntroductionView *_introductionTable;
    UIAdvisePageScrollView  *_recommandAdvisorView;
    
    UIButton    *_settingBtn;
    UIButton    *_editBtn;
}

@end

static AHYProfileViewController *instance = nil;

@implementation AHYProfileViewController


+ (AHYProfileViewController *)getInstance
{
    @synchronized (self) {
        if (instance == nil) {
            instance = [[AHYProfileViewController alloc]init];
        }
    }
    return instance;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headerView = [[UIProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, headerViewHeight)];
    _headerView.backgroundColor = AHYBlue;
    [self.view addSubview:_headerView];
    
    _introductionTable = [[UIUserIntroductionView alloc] initWithFrame:CGRectMake(0, headerViewHeight+30, DeviceScreenWidth, DeviceScreenHeight-headerViewHeight-kTabBarHeight-30)];
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
    
    _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, kStatusBarHeight, 38, kNavBarHeight)];
    [_editBtn setImage:[UIImage imageNamed:@"editButton"] forState:UIControlStateNormal];
    [_editBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 10, 13, 10)];
    [_editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editBtn];
    
    _settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(DeviceScreenWidth-43, kStatusBarHeight, 38, kNavBarHeight)];
    [_settingBtn setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [_settingBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 10, 13, 10)];
    [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editAction {
    
}

- (void)settingAction {
    
}

/*
#pragma mark - Navigation-kTabBarHeight

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
