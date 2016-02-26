//
//  KNNewsCell.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNewsModel.h"
@interface KNNewsCell : UITableViewCell

@property (nonatomic, strong) KNewsModel *newsModel;


//返回可重用的id
+ (NSString *)idForRow:(KNewsModel *)newsModel;

//返回行高
+ (CGFloat)heightForRow:(KNewsModel *)newsModel;
@end
