//
//  KNNetworkManger.m
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import "KNNetworkManager.h"

@implementation KNNetworkManager


+ (instancetype)shareNetworkMangerContainBaseURL {
    static KNNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[KNNetworkManager alloc] init];
        //给一个指定的baseURL
        NSURL *baseUrl = [NSURL URLWithString:@"http://c.m.163.com/"];
        //默认的设置，缓存，超时，连接要求等
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *HTTPSessionMgr = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl sessionConfiguration:config];
        
        HTTPSessionMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        manager.HTTPSessionManager = HTTPSessionMgr;
        
    });
    return manager;
}





+ (instancetype)shareNetworkManger {
    static KNNetworkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken, ^{
        manager = [[KNNetworkManager alloc]init];
        NSURL *baseUrl = [NSURL URLWithString:@""];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *HTTPSessionMgr = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl sessionConfiguration:config];
        
        HTTPSessionMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        manager.HTTPSessionManager = HTTPSessionMgr;
    });
    
    return manager;
}



//将方法定义在工具类中，方便以后第三方库有更改时，只需要修改工具类中的实现，则能完成代码的修改。
- (void)GET:(NSString *)URLstr params:(id)params success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    
    
     [self.HTTPSessionManager GET:URLstr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
    
}
@end
