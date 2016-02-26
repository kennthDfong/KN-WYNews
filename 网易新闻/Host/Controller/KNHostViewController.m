//
//  KNHostViewController.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNHostViewController.h"
#import "UIView+KNFrame.h"
#import "KNTitleLabel.h"
#import <MJExtension.h>
#import "KNNewsTabViewController.h"
@interface KNHostViewController ()<UIScrollViewDelegate>


/** 顶部 标题栏*/
@property (weak, nonatomic) IBOutlet UIScrollView *titleScollerView;
/** 内容视图*/
@property (weak, nonatomic) IBOutlet UIScrollView *contentScollerView;
/** 标题中的label*/
@property (nonatomic, strong) KNTitleLabel *titleLabel;
/** 记录开始的编译*/
@property (nonatomic, assign) CGFloat beginOffsetX;

/** 新闻数组*/
@property (nonatomic, strong) NSArray *newsTitleArray;
/** */
@property (nonatomic, strong) UIImageView *tran;
/** */
@property (nonatomic, strong) UIButton *rightItem;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleScrollViewTopConstraint;
@end

@implementation KNHostViewController

//news的array的加载
- (NSArray *)newsTitleArray {
    if (_newsTitleArray == nil) {
        NSString *newsPlstPath = [[NSBundle mainBundle] pathForResource:@"NewsURLs" ofType:@"plist"];
        _newsTitleArray = [NSArray arrayWithContentsOfFile:newsPlstPath];
    }
    return _newsTitleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRightItem) name:@"KNADKey" object:nil];
    //所有scollerView都不需要自动缩进64
    self.automaticallyAdjustsScrollViewInsets = NO;
    
   [self addSubControllers];
    
    [self configTitleScorllView];
    
    [self configContentScorllView];

    
}

#pragma - mark  ***** 设置标题视图相关 *****
- (void)configTitleScorllView {
    
    //设置不显示ScrollerView 的指示条
    self.titleScollerView.showsHorizontalScrollIndicator = NO;
    self.titleScollerView.showsVerticalScrollIndicator = NO;
    
    [self addLabel];
    
    self.titleScollerView.contentSize = CGSizeMake(self.titleLabel.width * self.newsTitleArray.count, 0);
}

- (void)addLabel {

    for (int i = 0; i < self.newsTitleArray.count; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        
        KNTitleLabel *Titlelbl = [KNTitleLabel new];
        
        //UIViewController *vc = self.childViewControllers[i];
        Titlelbl.text = self.newsTitleArray[i][@"title"];
        Titlelbl.frame = CGRectMake(lblX, lblY, lblW, lblH);
        Titlelbl.font = [UIFont systemFontOfSize:19];
        [self.titleScollerView addSubview:Titlelbl];
        Titlelbl.tag = i;
        //能响应交互
        Titlelbl.userInteractionEnabled = YES;
        
       //点击手势
        UIGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTap:)];
        
        [Titlelbl addGestureRecognizer:tapGuesture];
        
    }
    
    
}

//点击相应
- (void)titleLabelTap:(UIGestureRecognizer *)recognizer {

    
    KNTitleLabel *titleLabel = (KNTitleLabel *)recognizer.view;

    NSLog(@"%ld",(long)titleLabel.tag);
    
    CGFloat offsetX = titleLabel.tag * self.contentScollerView.width;
    CGFloat offsetY = self.contentScollerView.contentOffset.y;

    //滚动视图滚动的时候，Y不会改变
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.contentScollerView setContentOffset:offset animated:YES];
    
}


#pragma - mark ***** 设置内容视图相关 *****
- (void)configContentScorllView {
    self.contentScollerView.delegate = self;
}

//添加TableViewController，减少主控制器负担和代码量
- (void)addSubControllers {
    
    for (int i = 0; i < self.newsTitleArray.count; i++) {
        UIStoryboard *newsStoryBoard = [UIStoryboard storyboardWithName:@"news" bundle:[NSBundle mainBundle]];
        KNNewsTabViewController *vc = newsStoryBoard.instantiateInitialViewController;
        
        vc.title = self.newsTitleArray[i][@"title"];
        vc.urlStr = self.newsTitleArray[i][@"urlString"];
        [self addChildViewController:vc];
        
    }
    
}

#pragma - mark ***** ScorllView 代理方法相关 *****


/** 滚动结束时*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    
    // 索引 ＝ X的偏移 / 宽
    NSUInteger index = scrollView.contentOffset.x / self.contentScollerView.width;
    KNTitleLabel *titleLabel = (KNTitleLabel *)self.titleScollerView.subviews[index];
    //需要移动时，让label的中点刚好是view的中点
    CGFloat offsetX =  titleLabel.center.x - self.titleScollerView.width * 0.5;
    CGFloat offsetMax = self.titleScollerView.contentSize.width - self.titleScollerView.width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > offsetMax) {
        offsetX = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetX, self.titleScollerView.contentOffset.y);
    
    [self.titleScollerView setContentOffset:offset animated:YES];
    
    KNNewsTabViewController *newsVC = self.childViewControllers[index];
    newsVC.index = index;
    
    [self.titleScollerView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx != index) {
            //将不是被选中的label 字体恢复为原样;
            KNTitleLabel *otherLabel = self.titleScollerView.subviews[idx];
            otherLabel.scale = 0.0;
        }
        
    }];
    
    //如果已经添加过一次，则直接返回
    if (newsVC.view.superview) {
        return;
    }
    
    //否则 添加新的VC
    newsVC.view.frame = scrollView.bounds;
    [self.contentScollerView addSubview:newsVC.view];
    
}
/** 手势导致滚动结束*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    //改变titleLbal的逻辑
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.width);
    NSUInteger leftIndex = (int)value; //强转成整数
    NSUInteger rightIndex = leftIndex + 1; //
    CGFloat scaleRight = value - leftIndex; //0～1
    CGFloat scaleLeft = 1 - scaleRight;//
    
    //取得当前的label
    KNTitleLabel *lableLeft =  self.titleScollerView.subviews[leftIndex];
    //移动中改变大小，停止时，是最大值。
    lableLeft.scale = scaleLeft;
    
    if (rightIndex < self.titleScollerView.subviews.count) {
        KNTitleLabel *labelRight = self.contentScollerView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
    
}



- (void)showRightItem {
    
}
@end
