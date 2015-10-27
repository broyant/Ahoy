//
//  AHYDiscoverViewController.m
//  Ahoy
//
//  Created by lichuanjun on 13/10/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

static NSString * const kAdvisorListCellIdentifier = @"advisorListCell";
static NSString * const kHorizontalTopicCellIdentifier = @"horizontalTopicCell";

#import "AHYDiscoverViewController.h"
#import "AHYAdvisorListCell.h"
#import "AHYHorizontalTopicCell.h"
#import "AHYRecommendView.h"

@interface AHYDiscoverViewController ()

@end

@implementation AHYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[AHYAdvisorListCell class] forCellReuseIdentifier:kAdvisorListCellIdentifier];
    [self.tableView registerClass:[AHYHorizontalTopicCell class] forCellReuseIdentifier:kHorizontalTopicCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //sections: topic category & most populor advisors
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //title for most populor advisors
    return nil;
}

#pragma mark --UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   //select item;
}

@end
