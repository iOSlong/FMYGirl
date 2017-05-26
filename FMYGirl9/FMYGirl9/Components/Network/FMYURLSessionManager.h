//
//  FMYURLSessionManager.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/5/26.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FMYSessionTaskSuccess)(NSURLSessionTask *task, id object);
typedef void(^FMYSessionTaskFailure)(NSURLSessionTask *task, NSError *error);

@interface FMYURLSessionManager : NSObject <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession      *session;
@property (nonatomic) NSOperationQueue  *operationQueue;
@property (nonatomic) NSURLSessionConfiguration *sessionConfiguration;

@property (nonatomic, copy) FMYSessionTaskSuccess successBlock;
@property (nonatomic, copy) FMYSessionTaskFailure failureBlock;
@property (nonatomic) NSMutableData *mudata;



- (void)sessionGet:(NSString *)URLString parameters:(NSDictionary *)parameters success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure;
- (void)sessionPost:(NSString *)URLString parameters:(NSDictionary *)parameters success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure;


- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(FMYSessionTaskSuccess)success failure:(FMYSessionTaskFailure)failure;




/**
 Finish it , the session Objects cannot be reused
 
 @param cancelPendingTasks invalidate immediately  or  invalidate after task finished。
 */
- (void)invalidateSessionCancelingTasks:(BOOL)cancelPendingTasks;


@end
