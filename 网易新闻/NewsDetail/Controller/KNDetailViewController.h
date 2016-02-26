//
//  KNDetailViewController.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNewsModel.h"


@interface KNDetailViewController : UIViewController


/** 新闻模型*/
@property (nonatomic, strong) KNewsModel *newsModel;

/** */
@property (nonatomic, assign) NSInteger index;
@end
