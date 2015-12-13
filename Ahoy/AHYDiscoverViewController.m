//
//  AHYDiscoverViewController.m
//  Ahoy
//
//  Created by lichuanjun on 13/10/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

static CGFloat const kHeaderViewHeight = 166.f;
static CGFloat const kCategoryViewHeight = 192.f;
static CGFloat const kAdvisorListHeaderHeight = 19.f;
static NSString * const kAdvisorListCellIdentifier = @"advisorListCell";
static NSString * const kAdvisorListTitle = @"Our Most Popular Advisors";

#import "AHYDiscoverViewController.h"
#import "AHYTopicViewController.h"
#import "AHYAdvisorListCell.h"
#import "AHYCategoryView.h"
#import "AHYRecommendView.h"
#import "AHYAdvisor.h"
#import "AHYTopic.h"

@interface AHYDiscoverViewController ()<AHYCategoryViewDelegate, AHYRecommendViewDelegate>

@property(nonatomic, strong) NSArray *recommendTopics;
@property(nonatomic, strong) NSArray *topicCategorys;
@property(nonatomic, strong) NSArray *recommendAdvisors;

@end

@implementation AHYDiscoverViewController

- (NSArray *)recommendTopics {
    if (!_recommendTopics) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            AHYTopic *topic = [[AHYTopic alloc] init];
            topic.imgUrl = [NSString stringWithFormat:@"c1Topic%dThumbnail",i];
            topic.name = [[NSAttributedString alloc] initWithString:@"Tellus Amet"];
            topic.totalAdvisors = 107 + i * 21;
            topic.totalSessions = 2345 + i * 32;
            topic.category = i + 1;
            topic.isRecommended = YES;
            topic.advisors = self.recommendAdvisors;
            [array addObject:topic];
        }
        _recommendTopics = [array copy];
    }
    return _recommendTopics;
}

- (NSArray *)topicCategorys {
    if (!_topicCategorys) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 5; i++) {
            AHYTopic *topic = [[AHYTopic alloc] init];
            topic.imgUrl = [NSString stringWithFormat:@"c2Topic%dThumbnail",i % 3 + 1];
            topic.name = [[NSAttributedString alloc] initWithString:@"Tellus Amet"];
            topic.totalAdvisors = 107 + i * 21;
            topic.totalSessions = 2345 + i * 32;
            topic.isRecommended = NO;
            topic.advisors = self.recommendAdvisors;
            [array addObject:topic];
        }
        _topicCategorys = @[@{@"Programming": array}, @{@"Design": array}, @{@"Management": array}];
    }
    return _topicCategorys;
}

- (NSArray *)recommendAdvisors {
    if (!_recommendAdvisors) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            AHYAdvisor *advisor = [[AHYAdvisor alloc] init];
            advisor.portraitUrl = [NSString stringWithFormat:@"c1Topic%dThumbnail",i % 3+1];
            advisor.name = @"Howard Wolowitz";
            advisor.title = @"User Experience Designer, Storehouse";
            advisor.experience = @"Nullam quis risus eget urna mollis slie ornare vel eu leo. Vestibulum idlse Nullam quis risus eget urna mollis slie ornare vel eu leo. Vestibulum idlse ";
            advisor.price = 32 + i * 4;
            advisor.rate = 5;
            [array addObject:advisor];
        }
        _recommendAdvisors = [array copy];
    }
    return _recommendAdvisors;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Discover";
    [self.tableView registerClass:[AHYAdvisorListCell class] forCellReuseIdentifier:kAdvisorListCellIdentifier];
    self.tableView.tableHeaderView = [self headerView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
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
    AHYTopicViewController *topicVC = [[AHYTopicViewController alloc] initWithTopic:topic];
    topicVC.hidesBottomBarWhenPushed = YES;
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
    for (NSDictionary *category in self.topicCategorys) {
        NSString *title = category.allKeys[0];
        NSArray *topics = category.allValues[0];
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
