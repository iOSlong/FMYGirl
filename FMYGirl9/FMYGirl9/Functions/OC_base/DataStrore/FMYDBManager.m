//
//  FMYDBManager.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDBManager.h"

@implementation FMYDBManager

+ (FMYDBManager *)sharedDBmanager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 创建数据库文件目录
        if ([self mkdirOfDB])
        {
            if ([self getDataBase])
            {
                [self createTable]; //创建数据库 及 表格
            }
        }
        else
        {
            NSLog("mkdirDB failed!");
        }
    }
    return self;
}

- (BOOL)mkdirOfDB {
    NSString *dataPath = [FMYUtils pathOfDatabase];
    NSLog(@"==========================================detailPath:\n %@",dataPath);
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if (error) return NO;
    return YES;
}

- (BOOL)getDataBase {
    NSString *dbPath = [FMYUtils pathOfDatabase];
    NSString *sqlitePath = [dbPath stringByAppendingPathComponent:myDBFileName];
    int dbresult =  sqlite3_open([sqlitePath UTF8String], &_database);
    if(dbresult != SQLITE_OK){
        NSLog(@"创建／打开数据库失败,%d",dbresult);
        return NO;
    }
    return YES;
}
- (void)createTable {
    char *error;
    
    //    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
    const char *createSQL = "create table if not exists list_data(orderID integer primary key autoincrement, desc txt, ID text, data blob)";
    
    int tableResult = sqlite3_exec(_database, createSQL, NULL, NULL, &error);
    
    if (tableResult != SQLITE_OK) {
        
        NSLog(@"创建表失败:%s",error);
    }
}



@end
