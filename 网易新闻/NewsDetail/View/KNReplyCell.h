//
//  KNReplyCell.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNReplyModel.h"


@interface KNReplyCell : UITableViewCell

@property(nonatomic,strong) KNReplyModel *replyModel;
/** 用户的发言 */
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;

@end
