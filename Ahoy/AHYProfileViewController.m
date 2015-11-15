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

#define headerViewHeight    160
#define scoreViewHeight     90

@interface AHYProfileViewController ()
{
    UIProfileHeaderView *_headerView;
    UIUserIntroductionView *_introductionTable;
    
    UIUserScoreView *_scoreView;
    
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
    
    _scoreView = [[UIUserScoreView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, scoreViewHeight)];
    _scoreView.backgroundColor = [UIColor whiteColor];
    [_introductionTable setTableViewHeader:_scoreView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
