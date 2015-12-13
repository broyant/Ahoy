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

#import "AHYSearchResultsViewController.h"
#import "AHYCategoryView.h"
#import "AHYAdvisorListCell.h"

@interface AHYSearchResultsViewController ()<AHYCategoryViewDelegate>

@property (nonatomic, strong) NSArray *advisors;
@property (nonatomic, strong) NSArray *topics;

@end

@implementation AHYSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[AHYAdvisorListCell class] forCellReuseIdentifier:kCellIdentifier];
    if (_topics.count) {
        self.tableView.tableHeaderView = [self headerView];
    }
    self.edgesForExtendedLayout = UIRectEdgeBottom;
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

#pragma mark - UISearchBar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

}

#pragma mark --AHYRecommendViewDelegate

- (void)topicDidSelected:(AHYTopic *)topic {
    //
}

#pragma mark --headerView

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

@end
