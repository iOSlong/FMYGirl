//
//  FMYURLSessionManager.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/5/26.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYURLSessionManager.h"

@interface FMYURLSessionManager ()
@property (nonatomic) NSMutableArray    *dataTasks;
@end

@implementation FMYURLSessionManager
- (instancetype)init
{
    return [self initWithConfiguration:nil];
}

- (instancetype)initWithConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super init];
    if (self) {
        if (configuration == nil) {
            _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        
        _dataTasks = [NSMutableArray array];
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;

        _session = [NSURLSession sessionWithConfiguration:_sessionConfiguration delegate:self delegateQueue:_operationQueue];
    }
    return self;
}
- (NSMutableData *)mudata {
    if (!_mudata) {
        _mudata = [NSMutableData data];
    }
    return _mudata;
}

- (void)sessionGet:(NSString *)URLString parameters:(NSDictionary *)parameters success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure;{
    [self dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters success:success failure:failure];
}
- (void)sessionPost:(NSString *)URLString parameters:(NSDictionary *)parameters success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure;{
    [self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure {
    NSURLRequest *request = [self requestMehod:method urlString:URLString parameters:parameters];
    NSURLSessionDataTask *dataTask = [self dataTaskRequest:request success:success failure:failure];
    
    //发送信息启动任务
    [dataTask resume];
    
    return dataTask;
}




#pragma mark - Private method
- (NSURLRequest *)requestMehod:(NSString *)method urlString:(NSString *)URLString parameters:(NSDictionary *)parameters {
    NSString *assert = [NSString stringWithFormat:@"Invalid parameter not satisfying:%@",URLString];
    NSAssert(URLString.length, assert);
    NSString    *desURL = [NSString stringWithFormat:@"%@?%@",URLString,[self urlSuffixParams:parameters]];
    NSURL               *url        = [NSURL URLWithString:desURL];
    NSMutableURLRequest *request    = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod  = method;
    return request;
}


- (NSURLSessionDataTask *)dataTaskRequest:(NSURLRequest *)request success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure {
    self.successBlock   = success;
    self.failureBlock   = failure;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request];
    [self.dataTasks addObject:dataTask];
    return dataTask;
}

- (NSString *)urlSuffixParams:(NSDictionary *)params{
    NSString *paramSuffix = @"";
    if ([params allKeys].count) {
        NSArray     *keys = params.allKeys;
        NSMutableArray  *valueArr = [NSMutableArray array];
        for (NSString *key in keys) {
            NSString *value = [params objectForKey:key];
            if (value) {
               [valueArr addObject: [NSString stringWithFormat:@"%@=%@",key,value]];
            }
        }
        paramSuffix = [valueArr componentsJoinedByString:@"&"];
    }
    return paramSuffix;
}




#pragma mark  - NSURLSessionDelegate|NSURLSessionTaskDelegate|NSURLSessionDataDelegate|NSURLSessionDownloadDelegate|NSURLSessionStreamDelegate
#pragma mark NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.mudata appendData:data];
}

#pragma mark NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error) {
        if (self.failureBlock) {
            self.failureBlock(task, error);
        }
    }else if (self.successBlock) {
        self.successBlock(task,_mudata);
    }
}


- (void)invalidateSessionCancelingTasks:(BOOL)cancelPendingTasks {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (cancelPendingTasks) {
            [self.session invalidateAndCancel];
        } else {
            [self.session finishTasksAndInvalidate];
        }
    });
}





@end
