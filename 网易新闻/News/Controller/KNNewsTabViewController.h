//
//  KNNewsTabViewController.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNNewsTabViewController : UITableViewController


/** 公开属性，接受传入的url*/
@property (nonatomic, copy) NSString *urlStr;

/** 第几*/
@property (nonatomic, assign) NSInteger index;
@end
