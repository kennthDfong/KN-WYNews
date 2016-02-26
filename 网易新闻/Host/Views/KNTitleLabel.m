//
//  KNTitleLabel.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNTitleLabel.h"

@implementation KNTitleLabel

//重写init
- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    // 居中
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:18];
    self.scale = 0.0;
    return self;
}

/** 拉动的时候改变会scale，进而产生类似动画的效果*/
- (void)setScale:(CGFloat)scale {

    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0.0f blue:0.0f alpha:1];
    
    //参考值
    CGFloat minScale = 0.7;
    
    //0.7 ~ 1 之间变化
    CGFloat displayScale = minScale + (1 - minScale) * scale;
    //根据原始的scale来调整滚动过程中的scale
    self.transform = CGAffineTransformMakeScale(displayScale, displayScale);
    
}


@end
