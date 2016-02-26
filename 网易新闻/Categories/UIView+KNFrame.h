//
//  UIView+KNFrame.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KNFrame)

//通过这个分类可以快速访问frame的属性,和直接进行修改

//frame的x
@property (nonatomic, assign) CGFloat x;
//y
@property (nonatomic, assign) CGFloat y;
//宽
@property (nonatomic, assign) CGFloat width;
//高
@property (nonatomic, assign) CGFloat height;

@end
