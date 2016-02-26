//
//  KNDetailModel.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNDetailModel.h"
#import "KNDetailImgModel.h"
@implementation KNDetailModel

/** model内字典转模型*/
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    KNDetailModel *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    detail.replyBoard = dict[@"replyBoard"];
    detail.replyCount = [dict[@"replyCount"] integerValue];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        KNDetailImgModel *imgModel = [KNDetailImgModel detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    
    return detail;
}

@end
