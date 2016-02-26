//
//  KNNewsCell.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/25.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNNewsCell.h"
#import <UIImageView+WebCache.h>
@interface KNNewsCell ()


/** 新闻标题图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

/** 标题Label*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 评论数*/
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView2;

@property (weak, nonatomic) IBOutlet UIImageView *imgView3;

@end

@implementation KNNewsCell

+ (NSString *)idForRow:(KNewsModel *)newsModel {
    
    //返回不同类型的cell 重用 identifier
    
    //有头视图，和图片集
    if (newsModel.hasHead && newsModel.photosetID) {
        return @"TopImageCell";
    
    //值有头视图
    } else if (newsModel.hasHead) {
        return @"TopTextCell";
        
        //大图
    } else if (newsModel.imgType) {
        return @"BigImageCell";
        
        //图组新闻
    } else if (newsModel.imgextra) {
        return @"ImagesCell";
    
    //一起均没有，则是普通的新闻
    } else {
        
        return @"NewsCell";
    }
    
}


+ (CGFloat)heightForRow:(KNewsModel *)newsModel {
    
    if (newsModel.hasHead && newsModel.photosetID){
        return 245;
    }else if(newsModel.hasHead) {
        return 245;
    }else if(newsModel.imgType) {
        return 170;
    }else if (newsModel.imgextra){
        return 130;
    }else{
        return 80;
    
    }
}

//重新setter   一赋值，则执行
- (void)setNewsModel:(KNewsModel *)newsModel {
    
    newsModel = newsModel;
    
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"302"]];
    self.titleLabel.text = self.newsModel.title;
    self.subTitleLabel.text = self.newsModel.digest;
    
    // 如果回复太多就改成几点几万
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.commentNumLabel.text = displayCount;
    
    // 多图cell
    if (self.newsModel.imgextra.count == 2) {
        
        
        //sdWebImage 发送下载和缓存图片
        
        [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
        [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
    }
    
    
    
    
    
    
}


@end
