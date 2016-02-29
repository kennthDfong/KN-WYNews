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


#define NewsDetailControllerClose (self.tableView.contentOffset.y - (self.tableView.contentSize.height - SXSCREEN_H + 55) > (100 - 54))

@interface KNDetailViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) KNDetailModel *detailModel;
@property (nonatomic, strong) KNNewsDetailButtomCell *closeCell;

- (IBAction)backBtnClick:(id)sender;
@end

@implementation KNDetailViewController
- (IBAction)replyBtnClikc:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
