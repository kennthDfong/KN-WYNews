//
//  KNNavController.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNNavController.h"

@implementation KNNavController

//重写initialize，改变所有navBar

+ (void)initialize {
   UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor redColor]];
}

@end
