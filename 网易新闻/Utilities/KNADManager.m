//
//  KNADManger.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNADManager.h"
#import "KNNetworkManager.h"

#define CachedCurrentImagePath ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingString:@"/adcurrent.png"])
#define CachedNewImagePath     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingString:@"/adnew.png"])


@implementation KNADManager




+ (void)loadLastADImage {
    KNNetworkManager *networkMgr = [KNNetworkManager shareNetworkManger];
    
    //当前时间
    NSInteger currentTime = [[NSDate new]timeIntervalSince1970];
    
    NSString *ADUrlStr = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)currentTime];
    
    [networkMgr GET:ADUrlStr params:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
       
        NSArray *ADarray = responseObject[@"ads"];
        NSString *imgUrl1 = ADarray[0][@"res_url"][0];
        NSString *imgUrl2 = nil;
    
        if (ADarray.count > 1) {
        
            
            //sdsasdasd as dasd asdsdads
            imgUrl2 = ADarray[1][@"res_url"][0];
        }
        
#warning 这里需要修改一下
        BOOL one = [[NSUserDefaults standardUserDefaults] boolForKey:@"one"];
        if (imgUrl2.length > 0) {
            if (one) {
                [self downloadImage:imgUrl1];
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            } else {
                [self downloadImage:imgUrl2];
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            }
        } else {
            [self downloadImage:imgUrl1];
        }
        
        
    } failure:^(NSURLSessionTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

+ (void)downloadImage:(NSString *)imageUrl {
    
    //使用session 发送 request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (data) {
            
            [data writeToFile:CachedNewImagePath atomically:YES];
        }
        
    }];
    
    [task resume];
    
}

+ (BOOL)isShouldDisplayAD {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    return  ([fileMgr fileExistsAtPath:CachedNewImagePath] ||
             [fileMgr fileExistsAtPath:CachedNewImagePath]);
    
    
}

+ (UIImage *)getADImage {
    UIImage *image;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    
    if ([fileMgr fileExistsAtPath:CachedNewImagePath]) {
    
        [fileMgr removeItemAtPath:CachedCurrentImagePath error:nil];
        [fileMgr moveItemAtPath:CachedNewImagePath toPath:CachedCurrentImagePath error:nil];
    }
    
    image = [UIImage imageWithData:[NSData dataWithContentsOfFile:CachedCurrentImagePath]];
    
    return image;
}


@end
