//
//  AHYAdvisorListCell.h
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHYAdvisor;

@interface AHYAdvisorListCell : UITableViewCell

- (void)configure:(AHYAdvisor *)advisor;

- (void)highlightWords:(NSString *)keyWords withColor:(UIColor *)highlightedColor;

@end
