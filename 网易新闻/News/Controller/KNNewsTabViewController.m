//
//  KNNewsTabViewController.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNNewsTabViewController.h"
#import "KNNewsCell.h"
#import "KNewsModel.h"
#import "KNNetworkManager.h"

#import <MJRefresh.h>
#import <MJExtension.h>


typedef enum : NSUInteger {
    KNDownTypeReLoadData,
    KNDownTypeLoadMoreData
} KNDownType;

@interface KNNewsTabViewController ()

@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, assign) BOOL update;
@end


@implementation KNNewsTabViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //左右滑动的时候，能看到底面的占位视图
    self.view.backgroundColor = [UIColor clearColor];

    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.update = YES;
    
    
    //这里
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"KNADKey" object:nil];
    
}

//隐藏prefersStatu Bar
- (BOOL)prefersStatusBarHidden {
    return YES;
}

//收到通知则这行这个方法
- (void)welcome {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];

    [self.tableView.mj_header beginRefreshing];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"update"]) {
        //不需要更新，则直接返回
        return;
    }
    
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
    
    //发送通知，让控制器开始下载
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadContent" object:nil];
}


#pragma - mark 加载相关方法

//下拉刷新
- (void)loadData {
    NSString *allUrlString = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlStr];
    
    [self loadDataForType:KNDownTypeReLoadData withUrl:allUrlString];
    
}
//下拉加载
- (void)loadMoreData {
    NSString *allUrlStr = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlStr,(self.newsArray.count - self.newsArray.count % 10)];
    
    [self loadDataForType:KNDownTypeLoadMoreData withUrl:allUrlStr];
    
    
}

- (void)loadDataForType:(KNDownType)type withUrl:(NSString *)allUrlStr {
    
    
    
    [[KNNetworkManager shareNetworkMangerContainBaseURL] GET:allUrlStr params:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
    
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *array = responseObject[key];
        
        //mj Extension
        NSMutableArray *arrayM = [KNewsModel mj_objectArrayWithKeyValuesArray:array];
        
        if (type == KNDownTypeReLoadData) {
 
            //上拉刷新
            self.newsArray = arrayM;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        } else if (type == KNDownTypeLoadMoreData) {
            
            //下拉加载
            [self.newsArray addObjectsFromArray:arrayM];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}


#pragma - mark tabelView 数据源相关方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsArray.count;
    
}

- (KNNewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KNewsModel *newsModel = self.newsArray[indexPath.row];
    
    NSString *idStr = [KNNewsCell idForRow:newsModel];
    
    if ((indexPath.row % 20 == 0) &&
         indexPath.row != 0) {
        idStr = @"NewsCell";
    }
    
    KNNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    
    cell.newsModel = newsModel;
    
    return cell;
}

#pragma - mark tableView 代理相关方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KNewsModel *newsModel = self.newsArray[indexPath.row];
    
    CGFloat rowHeight = [KNNewsCell heightForRow:newsModel];
    
    if ((indexPath.row % 20 == 0) &&
         (indexPath.row != 0)) {
        rowHeight = 80.0;
    }
    
    return rowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
/** cell不变色*/
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor yellowColor];
    
}

@end
