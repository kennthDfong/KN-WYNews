//
//  KNReplyViewController.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNReplyViewController.h"
#import "KNReplyHeaderVIew.h"
#import "KNReplyCell.h"

@interface KNReplyViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtnClick:(id)sender;


@end

@implementation KNReplyViewController

static NSString *identifier = @"replyCell";

- (IBAction)backBtnClick:(id)sender {
    
    //从系统的栈中pop出一个controller
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)viewWillAppear:(BOOL)animated {
    //设置不进行缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
