//
//  KNADManger.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KNADManager : NSObject

+ (BOOL)isShouldDisplayAD;

+ (UIImage *)getADImage;

+ (void)loadLastADImage;
@end
