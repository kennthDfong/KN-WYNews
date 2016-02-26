//
//  KNNewsDetailBurttonCell.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNNewsDetailButtomCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+KNFrame.h"

@interface KNNewsDetailButtomCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *userLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodLbl;
@property (weak, nonatomic) IBOutlet UILabel *userLacationLbl;
@property (weak, nonatomic) IBOutlet UILabel *replyDetail;



@property (weak, nonatomic) IBOutlet UIImageView *newsIcon;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *newsFromLbl;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLbl;



@property (weak, nonatomic) IBOutlet UIImageView *closeImgView;

@property (weak, nonatomic) IBOutlet UILabel *closeLbl;

@end

@implementation KNNewsDetailButtomCell

+ (instancetype)theShareCell {
    
    return [self getCellFormNibUseIndex:0];
}

+ (instancetype)theSectionHeaderCell {
    
    return [self getCellFormNibUseIndex:1];
}

+ (instancetype)theSectionBottomCell {
    return [self getCellFormNibUseIndex:2];
}

+ (instancetype)theHotReplyCellWithTableView:(UITableView *)tableView {
     static  NSString *ID = @"hotreplycell";
    
    KNNewsDetailButtomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [self getCellFormNibUseIndex:3];
    }
    return cell;
}

+ (instancetype)theContactNewsCell {
    return [self getCellFormNibUseIndex:4];
}

+ (instancetype)theCloseCell {
    return [self getCellFormNibUseIndex:5];
}

+ (instancetype)theKeywordCell {
    return [self getCellFormNibUseIndex:6];
}

- (void)setISCloseing:(BOOL)iSCloseing {
    _iSCloseing = iSCloseing;
    self.closeImgView.image = [UIImage imageNamed:iSCloseing ? @"newscontent_drag_return" : @"newscontent_drag_arrow"];
    self.closeLbl.text = iSCloseing ? @"松手关闭当前页" : @"上拉关闭当前页" ;
}


//当replyModel被赋值，则进行界面的修改
-(void)setReplyModel:(KNReplyModel *)replyModel
{
    _replyModel = replyModel;
    self.userLbl.text = replyModel.name;
    
    NSRange range = [replyModel.address rangeOfString:@"&"];
    if (range.location != NSNotFound) {
        replyModel.address = [replyModel.address substringToIndex:range.location];
    }
    
    self.userLacationLbl.text = [NSString stringWithFormat:@"%@ %@",replyModel.address,replyModel.rtime];
    self.replyDetail.text = replyModel.say;
    self.goodLbl.text = [NSString stringWithFormat:@"%@顶",replyModel.suppose];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:replyModel.icon] placeholderImage:[UIImage imageNamed:@"comment_profile_mars"]];
    self.iconImg.layer.cornerRadius = self.iconImg.width/2;
    self.iconImg.layer.masksToBounds = YES;
    self.iconImg.layer.shouldRasterize = YES;
}

- (void)setSameNewsEntity:(KNSameNewsEntity *)sameNewsEntity
{
    _sameNewsEntity = sameNewsEntity;
    [self.newsIcon sd_setImageWithURL:[NSURL URLWithString:sameNewsEntity.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];
    self.newsIcon.layer.cornerRadius = 2;
    self.newsIcon.layer.masksToBounds = YES;
    self.newsIcon.layer.shouldRasterize = YES;
    self.newsTitleLbl.text = sameNewsEntity.title;
    self.newsFromLbl.text = sameNewsEntity.source;
    self.newsTimeLbl.text = sameNewsEntity.ptime;
}

+ (instancetype)getCellFormNibUseIndex:(int)index {
    
    return [[NSBundle mainBundle] loadNibNamed:@"KNnewsDetailButtomCell" owner:nil options:nil][index];
    
}
@end
