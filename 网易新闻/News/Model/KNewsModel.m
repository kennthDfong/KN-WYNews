//
//  KNewsModel.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNewsModel.h"

@implementation KNewsModel

//KVC 模型转字典
+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    KNewsModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}


@end
