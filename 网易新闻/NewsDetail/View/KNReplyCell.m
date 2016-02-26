//
//  KNReplyCell.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/26.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNReplyCell.h"


@interface KNReplyCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *supposeButton;


@end

@implementation KNReplyCell

- (void)setReplyModel:(KNReplyModel *)replyModel
{
    _replyModel = replyModel;
    if (_replyModel.name == nil) {
        _replyModel.name = @"";
    }
    self.nameLabel.text = _replyModel.name;
    self.addressLabel.text = _replyModel.address;
    
    NSRange rangeAddress = [_replyModel.address rangeOfString:@"&nbsp"];
    if (rangeAddress.location != NSNotFound) {
        self.addressLabel.text = [_replyModel.address substringToIndex:rangeAddress.location];
    }
    
    self.sayLabel.text = _replyModel.say;
    
    NSRange rangeSay = [_replyModel.say rangeOfString:@"<br>"];
    if (rangeSay.location != NSNotFound) {
        NSMutableString *temSay = [_replyModel.say mutableCopy];
        [temSay replaceOccurrencesOfString:@"<br>" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temSay.length)];
        self.sayLabel.text = temSay;
    }
    self.supposeButton.titleLabel.text = _replyModel.suppose;
}


@end
