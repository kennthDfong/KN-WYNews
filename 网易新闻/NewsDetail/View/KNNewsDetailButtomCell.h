//
//  KNNewsDetailBurttonCell.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNReplyModel.h"
#import "KNSameNewsEntity.h"


@interface KNNewsDetailButtomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sectionHeaderLbl;


@property(nonatomic,strong)KNReplyModel *replyModel;

@property(nonatomic,strong)KNSameNewsEntity *sameNewsEntity;

@property(nonatomic,assign)BOOL iSCloseing;

+ (instancetype)theShareCell;

+ (instancetype)theSectionHeaderCell;

+ (instancetype)theSectionBottomCell;

+ (instancetype)theHotReplyCellWithTableView:(UITableView *)tableView;

+ (instancetype)theContactNewsCell;

+ (instancetype)theCloseCell;

+ (instancetype)theKeywordCell;
@end
