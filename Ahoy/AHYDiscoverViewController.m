//
//  AHYDiscoverViewController.m
//  Ahoy
//
//  Created by lichuanjun on 13/10/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

CGFloat const kHeaderViewHeight = 166.f;
CGFloat const kCategoryViewHeight = 192.f;
CGFloat const kAdvisorListHeaderHeight = 19.f;
NSString * const kAdvisorListCellIdentifier = @"advisorListCell";
NSString * const kAdvisorListTitle = @"Our Most Popular Advisors";

#import "AHYDiscoverViewController.h"
#import "AHYTopicViewController.h"
#import "AHYAdvisorListCell.h"
#import "AHYCategoryView.h"
#import "AHYRecommendView.h"
#import "AHYDiscoverDataSource.h"
#import "AHYAdvisor.h"
#import "AHYTopic.h"

@interface AHYDiscoverViewController ()<AHYCategoryViewDelegate, AHYRecommendViewDelegate>

@property(nonatomic, strong) NSArray *recommendTopics;
@property(nonatomic, strong) NSArray *topicCategorys;
@property(nonatomic, strong) NSArray *recommendAdvisors;

@end

@implementation AHYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Discover";
    [self.tableView registerClass:[AHYAdvisorListCell class] forCellReuseIdentifier:kAdvisorListCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self configureHeaderView];
    [AHYDiscoverDataSource downloadPopularAdvisors:^(NSArray *advisors) {
        self.recommendAdvisors = advisors;
        [self.tableView reloadData];
    }];
}

- (void)configureHeaderView {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [AHYDiscoverDataSource downloadTopicCategorys:^(NSArray *categorys) {
        self.topicCategorys = categorys;
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [AHYDiscoverDataSource downloadRecommendTopics:^(NSArray *topics) {
        self.recommendTopics = topics;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (self.topicCategorys == nil || self.recommendTopics == nil) {
            NSLog(@"no header datasource");
        }
        self.tableView.tableHeaderView = [self headerView];
    });
}

#pragma mark --UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendAdvisors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AHYAdvisorListCell *advisorCell = (AHYAdvisorListCell *)[tableView dequeueReusableCellWithIdentifier:kAdvisorListCellIdentifier];
    AHYAdvisor *advisor = self.recommendAdvisors[indexPath.row];
    [advisorCell configure:advisor];
    return advisorCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 138.f;
}

#pragma mark --UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   //select item;
    NSLog(@"%s:%@",__func__,self);
}

#pragma mark --AHYCategoryViewDelegate

- (void)topicDidSelected:(AHYTopic *)topic {
    AHYTopicViewController *topicVC = [[AHYTopicViewController alloc] initWithTopicID:topic.tid];
    topicVC.hidesBottomBarWhenPushed = YES;
    topicVC.navigationItem.title = topic.tName;
    [self.navigationController pushViewController:topicVC animated:YES];
}

#pragma mark --AHYRecommendViewDelegate

- (void)recommendTopicDidSelected:(AHYTopic *)topic {
    [self topicDidSelected:topic];
}

#pragma mark --headerView

- (UIView *)headerView {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIView *headerView = [[UIView alloc] init];
    //recommend topic view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, kHeaderViewHeight)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(screenSize.width * self.recommendTopics.count, kHeaderViewHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    CGRect frame = scrollView.bounds;
    for (AHYTopic *recommendTopic in self.recommendTopics) {
        AHYRecommendView *view = [[AHYRecommendView alloc] initWithFrame:frame];
        view.delegate = self;
        [view configure:recommendTopic];
        [scrollView addSubview:view];
        frame.origin.x += screenSize.width;
    }
    [headerView addSubview:scrollView];
    //category view
    CGFloat ty = CGRectGetMaxY(scrollView.frame);
    for (AHYTopicCategory *category in self.topicCategorys) {
        NSString *title = category.cName;
        NSArray *topics = category.topics;
        AHYCategoryView *categoryView = [[AHYCategoryView alloc] initWithFrame:CGRectMake(0, ty, screenSize.width, kCategoryViewHeight) title:title topics:topics];
        categoryView.delegate = self;
        ty += kCategoryViewHeight;
        [headerView addSubview:categoryView];
    }
    //most popular advisor
    ty += 18.f;
    UILabel *advisorHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, ty, screenSize.width, kAdvisorListHeaderHeight)];
    advisorHeader.text = kAdvisorListTitle;
    advisorHeader.font = TradeGothicLTBold(14);
    advisorHeader.textColor = AHYGrey40;
    [headerView addSubview:advisorHeader];
    ty += kAdvisorListHeaderHeight;
    //adjust header view frame
    headerView.frame = CGRectMake(0, 0, screenSize.width, ty);
    return headerView;
}

@end
