//
//  KNDetailImgModel.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNDetailImgModel.h"

@implementation KNDetailImgModel

/** model内字典转模型*/
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    KNDetailImgModel *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}

@end
