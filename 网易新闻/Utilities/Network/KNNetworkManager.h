//
//  KNNetworkManger.h
//  网易新闻
//
//  Created by ElCapitan on 16/2/24.
//  Copyright © 2016年 storm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


typedef void(^successBlock)(NSURLSessionTask *task, NSDictionary *responseObject);
typedef void(^failureBlock)(NSURLSessionTask *task, NSError *error);

//网络请求工具类，封装了请求的方法
@interface KNNetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *HTTPSessionManager;
/** 
 *   使用instancetype和id的区别
 *   instancetype会返回当前class，而id则有可能出现编译不出是什么类.id返回未知类型
 */


/** 此方法返回的对象，已经包含了base url*/
+ (instancetype)shareNetworkMangerContainBaseURL;

/** 返回常规对象，使用get方法需要添加详细url*/
+ (instancetype)shareNetworkManger;

+ (instancetype)shareOperationManager;

/** 使用session的GET方法*/
- (void)GET:(NSString *)URLstr params:(id)params success:(successBlock)successBlock failure:(failureBlock)failureBlock;
@end
