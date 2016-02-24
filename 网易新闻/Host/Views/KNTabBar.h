//
//  KNTabBar.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KNTabBarDelegate <NSObject>

@optional

- (void)changeSelIndexForm:(NSInteger)AtFirst to:(NSInteger)AtLast;

@end
/**  自定义的tabBar */
@interface KNTabBar : UIView

@property (nonatomic, weak) id<KNTabBarDelegate> KNDelegate;

- (void)addImageView;
- (void)addBarButtonWithNormalStateImageName:(NSString *)norImage
                                    DisImage:(NSString *)disImage
                                       title:(NSString *)title;

@end
