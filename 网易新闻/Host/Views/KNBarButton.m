//
//  KNBarButton.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNBarButton.h"
#import "UIView+KNFrame.h"
@implementation KNBarButton



- (void)setHighlighted:(BOOL)highlighted {
    
    //取消高亮状态
}

//重写布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.y = 5;
    self.imageView.width = 25;
    self.imageView.height = 25;
    self.imageView.x = (self.width - self.imageView.width)/2.0;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel.x = self.imageView.x - (self.titleLabel.width - self.imageView.width) / 2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame ) + 2;
    
    
    //这里如果用其他的非系统所有的字体，则会出现死循环
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.shadowColor = [UIColor clearColor];
    //向中心对齐
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
