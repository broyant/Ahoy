//
//  AHYSettingNotificationController.m
//  Ahoy
//
//  Created by lichuanjun on 20/1/2016.
//  Copyright © 2016 Ahoy. All rights reserved.
//

#import "AHYSettingNotificationController.h"

@interface AHYSettingNotificationController ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *detailLabels;

@end

@implementation AHYSettingNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    for (UILabel *label in _detailLabels) {
        label.font = TradeGothicLT(12);
        label.textColor = AHYSteelGrey;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - IBAction

- (IBAction)switchValueChanged:(UISwitch *)sender {
    NSInteger tag = sender.tag;
    NSLog(@"%s:tag:%@",__func__,@(tag));
}

@end
