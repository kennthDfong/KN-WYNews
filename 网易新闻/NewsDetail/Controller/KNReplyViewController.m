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
#import "UIView+KNFrame.h"
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.replyArray.count == 0) {
        return 1;
    }
    
    
    return self.replyArray.count;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置不进行缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    //预估tableViewCell 的height 提高性能
    self.tableView.estimatedRowHeight = 130;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KNReplyCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KNReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (self.replyArray.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     暂无跟帖数据";
        return cell2;
    } else {
        KNReplyModel *model = self.replyArray[indexPath.row];
        cell.replyModel = model;
    }
    
    return cell;
}

//返回来那个section的分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    if (section == 0) {
        return [KNReplyHeaderVIew replyViewFirst];
    } else {
        return [KNReplyHeaderVIew replyViewLast];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //没有回复，不需要设置height
    if (self.replyArray.count == 0) {
        return 40;
    } else {
        KNReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        KNReplyModel *model =  self.replyArray[indexPath.row];
        cell.replyModel = model;
        
        //重新布局
        [cell layoutIfNeeded];
        //获得cellLabel 适应字体后的大小
        CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        //y坐标 + 调整过之后的高 + 10
        return  cell.sayLabel.y + size.height + 10;
    }
}


@end
