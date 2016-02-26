//
//  KNReplyHeaderVIew.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNReplyHeaderVIew.h"

@implementation KNReplyHeaderVIew

/** 类方法快速返回热门跟帖的view */
+ (instancetype)replyViewFirst
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"KNReplyHeaderView" owner:nil options:nil];
    return array.firstObject;
}

/** 类方法快速返回最新跟帖的view */
+ (instancetype)replyViewLast
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"KNReplyHeaderView" owner:nil options:nil];
    return array.lastObject;
}

@end
