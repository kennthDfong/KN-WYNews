//
//  KNDetailViewController.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNDetailViewController.h"
#import "KNDetailImgModel.h"
#import "KNDetailModel.h"
#import "KNNetworkManager.h"
#import "KNReplyModel.h"
#import "KNReplyViewController.h"
#import "KNNewsDetailButtomCell.h"
#import "KNSameNewsEntity.h"

#import <MJExtension.h>
#define NewsDetailControllerClose (self.tableView.contentOffset.y - (self.tableView.contentSize.height - KNSCREEN_H + 55) > (100 - 54))
#define KNSCREEN_W [UIScreen mainScreen].bounds.size.width
#define KNSCREEN_H [UIScreen mainScreen].bounds.size.height
#define KNCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define KNCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
@interface KNDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) KNDetailModel *detailModel;
@property (nonatomic, strong) KNNewsDetailButtomCell *closeCell;
@property (nonatomic, strong) NSMutableArray *replyModels;
@property (nonatomic, strong) NSArray *sameNews;
@property (nonatomic, strong) NSArray *searchKeyword;
@property (nonatomic, strong) NSArray *newsArray;


- (IBAction)backBtnClick:(id)sender;
@end

@implementation KNDetailViewController

- (NSMutableArray *)replyModels {
    
    if (_replyModels == nil) {
        _replyModels = [NSMutableArray array];
    }
    
    return _replyModels;
}

- (NSArray *)newsArray {
    if ( _newsArray == nil) {
        _newsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _newsArray;
}


- (UIWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KNSCREEN_W, 700)];
    }
    return _webView;
}

- (IBAction)replyBtnClikc:(id)sender {
    //出栈
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [[KNNetworkManager shareOperationManager]GET:url params:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        [weakSelf successHandlerWithObject:responseObject];
    } failure:^(NSURLSessionTask *task, NSError *error) {
        NSLog(@"failure = %@",error.userInfo);
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    
}

- (void)successHandlerWithObject:(NSDictionary *)responseObject {
    
    self.detailModel = [KNDetailModel detailWithDict:responseObject[self.newsModel.docid]];
    if (self.newsModel.boardid.length < 1) {
        self.newsModel.boardid = self.detailModel.replyBoard;
    }
    //
    self.newsModel.replyCount = @(self.detailModel.replyCount);
    [self showInWebView];
    
    NSString *newsID = self.newsModel.docid;
    
    //同时加载新闻的评论
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",
                     self.newsModel.boardid, newsID];
    [self sendRequestWithURL:url];
    
    self.sameNews = [KNSameNewsEntity mj_objectArrayWithKeyValuesArray:responseObject[self.newsModel.docid][@"relative_sys"]];

    self.searchKeyword = responseObject[self.newsModel.docid][@"keyword_search"];
    
    CGFloat count = [self.newsModel.replyCount intValue];
    NSString *displayCount;
    
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    } else {
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    [self.replyButton setTitle:displayCount forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)showInWebView {
    
}

- (void)sendRequestWithURL:(NSString *)url {
    [[KNNetworkManager shareOperationManager] GET:url params:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        if (responseObject[@"hotPosts"] != [NSNull null]) {
            NSArray *dictarray = responseObject[@"hotPosts"];
            //        NSLog(@"%ld",dictarray.count);
            
            for (int i = 0; i < dictarray.count; i++) {
                NSDictionary *dict = dictarray[i][@"1"];
                KNReplyModel *replyModel = [[KNReplyModel alloc]init];
                replyModel.name = dict[@"n"];
                if (replyModel.name == nil) {
                    replyModel.name = @"火星网友";
                }
                replyModel.address = dict[@"f"];
                replyModel.say = dict[@"b"];
                replyModel.suppose = dict[@"v"];
                replyModel.icon = dict[@"timg"];
                replyModel.rtime = dict[@"t"];
                [self.replyModels addObject:replyModel];
            }
        }

    } failure:^(NSURLSessionTask *task, NSError *error) {
        
        NSLog(@"error = %@",error);
        
    }];
        
   
         
            
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtnClick:(id)sender {
}
@end
