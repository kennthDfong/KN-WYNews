//
//  KNTabBar.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNTabBar.h"
#import "KNBarButton.h"
#import "UIView+KNFrame.h"

@interface KNTabBar ()

@property (nonatomic, strong)  KNBarButton *selButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation KNTabBar

- (void)addImageView {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@""];
    self.imageView = imageView;
    
    [self addSubview:imageView];
}



//传入属性赋值给图片
- (void)addBarButtonWithNormalStateImageName:(NSString *)norImage DisImage:(NSString *)disImage title:(NSString *)title{
    
    NSLog(@"1");
    
    KNBarButton *btn = [KNBarButton new];
    [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:disImage] forState:UIControlStateDisabled];
        
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:183/255.0 green:20/255.0 blue:28/255.0 alpha:1] forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    
    // 让第一个按钮默认为选中状态
    if (self.subviews.count == 2) {
        btn.tag = 1;
        [self btnClick:btn];
    }
    
}

- (void)btnClick:(KNBarButton *)sender {
    
    if ([self.KNDelegate respondsToSelector:@selector(changeSelIndexForm:to:)]) {
        
        [self.KNDelegate changeSelIndexForm:_selButton.tag to:sender.tag];
        
    }
    //设置按钮显示状态  并切换选中按钮
    _selButton.enabled = YES;
    _selButton = sender;
    
    sender.enabled = NO;
}



- (void)layoutSubviews {
    
    UIImageView *imgView = self.subviews[0];
    imgView.frame = self.bounds;
    
    for (int i = 1 ; i < self.subviews.count; i++) {
        UIButton *btn =  self.subviews[i];
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 5;
        CGFloat btnH = 49;
        CGFloat btnX = (i - 1) * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.tag = i - 1;
        
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
