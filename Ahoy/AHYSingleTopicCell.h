//
//  AHYSingleTopicCell.h
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHYTopic;

@interface AHYSingleTopicCell : UITableViewCell

- (void)configure:(AHYTopic *)topic;

@end
