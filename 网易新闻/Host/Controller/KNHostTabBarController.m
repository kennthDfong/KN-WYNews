//
//  KNHostTabBarController.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNHostTabBarController.h"
#import "KNADManager.h"
#import "KNNetworkManager.h"
#import "KNTabBar.h"
@interface KNHostTabBarController ()<KNTabBarDelegate>

@end

@implementation KNHostTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self loadAndDisplayADView];
    

     [self configureHostTabBar];

}

#pragma - mark 创建启动广告

- (void)loadAndDisplayADView {
    
    //开始则加载最新的广告图片
    [KNADManager loadLastADImage];
    
    //有广告则显示
    if ([KNADManager isShouldDisplayAD]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"top20"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rightItem"];
        
        CGSize MainScreenSize = [UIScreen mainScreen].bounds.size;
        
        UIView *adView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize.width, MainScreenSize.height)];
        UIImageView *adImgView = [[UIImageView alloc]initWithImage:[KNADManager getADImage]];
        UIImageView *adButtomImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"adBottom.png"]];
        
        [adView addSubview:adImgView];
        [adView addSubview:adButtomImgView];
        
        adImgView.frame = CGRectMake(0, 0, MainScreenSize.width, MainScreenSize.height - 135);
        adButtomImgView.frame = CGRectMake(0, MainScreenSize.height - 135, MainScreenSize.width, 135);
        
        [self.view addSubview:adView];
        
        //隐藏状态栏。
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        adView.alpha = 0.9f;
        
        [UIView animateWithDuration:3.0f animations:^{
            
            adView.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            
            
            [UIView animateWithDuration:1.0 animations:^{
                adView.alpha = 0.0f;
                
                [UIApplication sharedApplication].statusBarHidden = NO;
            } completion:^(BOOL finished) {
                
                [adView removeFromSuperview];
            }];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KNADKey" object:nil];
        }];
        
    }else {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];
    }
    
}

#pragma - mark 配置tabBar 

- (void)configureHostTabBar {
    KNTabBar *tabBar = [KNTabBar new];
    tabBar.frame = self.tabBar.bounds;
    
    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];

    [self.tabBar addSubview:tabBar];
    
    tabBar.KNDelegate = self;
    
    [tabBar addImageView];
 
    
    [tabBar addBarButtonWithNormalStateImageName:@"tabbar_icon_news_normal"  DisImage:@"tabbar_icon_news_highlight"  title:@"新闻"];
    
    
        [tabBar addBarButtonWithNormalStateImageName:@"tabbar_icon_reader_normal"  DisImage:@"tabbar_icon_reader_highlight" title:@"阅读"];
    [tabBar addBarButtonWithNormalStateImageName:@"tabbar_icon_media_normal"  DisImage:@"tabbar_icon_media_highlight" title:@"视听"];
    [tabBar addBarButtonWithNormalStateImageName:@"tabbar_icon_reader_normal"  DisImage:@"tabbar_icon_found_highlight" title:@"发现"];
    [tabBar addBarButtonWithNormalStateImageName:@"tabbar_icon_reader_normal"  DisImage:@"tabbar_icon_me_highlight" title:@"我"];
    self.selectedIndex = 0;
}

//  delegate方法，相应改变
- (void)changeSelIndexForm:(NSInteger)AtFirst to:(NSInteger)AtLast {
    
    self.selectedIndex = AtLast;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSLog(@"warning");
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
