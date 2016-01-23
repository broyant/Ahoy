//
//  AHYSearchResultsViewController.m
//  Ahoy
//
//  Created by lichuanjun on 2/12/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

static CGFloat const kTopicsViewHeight = 192.f;
static CGFloat const kAdvisorListHeaderHeight = 19.f;
static NSString * const kCellIdentifier = @"advisorListCell";
static NSString * const kNoResultsTips = @"You can search topics, or search advisors by their names, companies, positions and their offerings for different topics.";

#import "AHYSearchResultsViewController.h"
#import "AHYCategoryView.h"
#import "AHYAdvisorListCell.h"
#import "AHYDiscoverDataSource.h"
#import <Masonry.h>

@interface AHYSearchResultsViewController ()<AHYCategoryViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *advisors;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) UILabel *noResultView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AHYSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNoResultsView];
    [self configureTableView];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    NSLog(@"%s:%@",__func__,self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _advisors.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AHYAdvisorListCell *cell = (AHYAdvisorListCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    //todo
    return cell;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
   [AHYDiscoverDataSource downloadPopularAdvisors:^(NSArray *advisors) {
       _advisors = advisors;
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
       });
   }];
}

#pragma mark --AHYRecommendViewDelegate

- (void)topicDidSelected:(AHYTopic *)topic {
    //
}

#pragma mark --subViews

- (UIView *)headerView {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIView *headerView = [[UIView alloc] init];
    //topics view
    CGFloat ty = 0;
    AHYCategoryView *topicsView = [[AHYCategoryView alloc] initWithFrame:CGRectMake(0, ty, screenSize.width, kTopicsViewHeight) title:@"Topics" topics:nil];
    topicsView.delegate = self;
    ty += kTopicsViewHeight;
    [headerView addSubview:topicsView];
    //advisor label
    ty += 18.f;
    UILabel *advisorHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, ty, screenSize.width, kAdvisorListHeaderHeight)];
    advisorHeader.text = @"Advisors";
    advisorHeader.font = TradeGothicLTBold(14);
    advisorHeader.textColor = AHYGrey40;
    [headerView addSubview:advisorHeader];
    ty += kAdvisorListHeaderHeight;
    //adjust header view frame
    headerView.frame = CGRectMake(0, 0, screenSize.width, ty);
    return headerView;
}

- (void)configureNoResultsView {
    _noResultView = [[UILabel alloc] init];
    _noResultView.textColor = AHYGrey40;
    _noResultView.font = TradeGothicLT(16);
    _noResultView.numberOfLines = 0;
    _noResultView.text = kNoResultsTips;
    _noResultView.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_noResultView];
    [_noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_greaterThanOrEqualTo(20);
        make.center.equalTo(self.view);
    }];
}

- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
