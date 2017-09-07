//
//  FMYDBPoet.m
//  FMYGirl9
//
//  Created by lxw on 2017/8/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDBPoet.h"

@implementation FMYDBPoet

+ (LKDBHelper *)getUsingLKDBHelper {
    static LKDBHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [LKDBUtils getPathForDocuments:@"poet.db" inDir:@"db"];
        NSLog(@"dbPath = %@",path);
        helper = [[LKDBHelper alloc] initWithDBPath:path];
    });
    return helper;
}

+ (NSString *)getPrimaryKey{
    return @"name";
}

@end
