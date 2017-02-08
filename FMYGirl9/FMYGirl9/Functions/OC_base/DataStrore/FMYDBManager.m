//
//  FMYDBManager.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDBManager.h"

@implementation FMYDBManager {
    sqlite3_stmt *_stmt;
}

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

- (NSString *)sqlPath {
    NSString *dbPath = [FMYUtils pathOfDatabase];
    NSString *sqlitePath = [dbPath stringByAppendingPathComponent:myDBFileName];
    return sqlitePath;
}

- (BOOL)getDataBase {
    int dbresult =  sqlite3_open([[self sqlPath] UTF8String], &_database);
    if(dbresult != SQLITE_OK){
        NSLog(@"创建／打开数据库失败,%d",dbresult);
        return NO;
    }
    return YES;
}
- (void)createTable {
    char *error;
    
    //    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
//    const char *createSQL = "create table if not exists list_data(orderID integer primary key autoincrement, desc txt, ID text, data blob)";
    
    int tableResult = sqlite3_exec(_database, [createSQL UTF8String], NULL, NULL, &error);
    
    if (tableResult != SQLITE_OK) {
        
        NSLog(@"创建表失败:%s",error);
    }
}

- (BOOL)dbClose {
    return  (sqlite3_close_v2(_database) == SQLITE_OK);
}

- (BOOL)dbOpen {
    if (sqlite3_open([[self sqlPath] UTF8String], &_database) == SQLITE_OK) {
        return YES;
    }else{
        return NO;
    }
}



- (BOOL)insert:(FMYObject *)obj ID:(NSString *)ID desc:(NSString *)desc {
    NSDictionary *dict = [obj objToDict];
    NSLog(@"%@",dict);
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    if (data) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into list_data(ID, desc, data)values(?, ?, ?)"];
        if ([self dbOpen]) {
            sqlite3_stmt *stmt = nil;
            
            sqlite3_prepare_v2(_database, [insertSQL UTF8String], -1, &stmt, NULL);
            
            sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
            
            sqlite3_bind_text(stmt, 2, [desc UTF8String], -1, NULL);

            // 用data 调用bytes函数，并且获得长度。这里的长度一定要设置，不然的话数据会不正确
            sqlite3_bind_blob(stmt, 3, [data bytes], (int)[data length] , NULL);
            
            int result = sqlite3_step(stmt);
            
            if (result != SQLITE_OK) {
                NSLog(@"添加失败，%d",result);
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)remove:(FMYObject *)obj ID:(NSString *)ID desc:(NSString *)desc;
{
    if ([obj valueForKey:@"ID"]) {
        ID = [obj valueForKey:@"ID"];
    }
    if (ID) {
        NSString *removeSQL = [NSString stringWithFormat:@"delete from list_data where ID = '%@'",ID];
        if ([self dbOpen]) {
            int result =  sqlite3_exec(_database, [removeSQL UTF8String], nil, nil, NULL);
            if (result != SQLITE_OK) {
                NSLog(@"移除失败，%d",result);
                return NO;
            }
        }
    }
    return YES;
}

- (NSArray *)getArrayBy:(NSDictionary *)queryInfo {
    NSMutableArray *muArr = [NSMutableArray array];
    //TODO 处理queryInfo
    NSString *searchSQL = @"select * from list_data";
    if ([self dbOpen]) {
        sqlite3_stmt *stmt = nil;
        
        int result = sqlite3_prepare_v2(_database, [searchSQL UTF8String], -1, &stmt, nil);
        if (result == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                //
                char *c_id      = (char *) sqlite3_column_text(stmt, 1);
                char *c_desc    = (char *) sqlite3_column_text(stmt, 2);
                
                const void *c_blob = (char *) sqlite3_column_blob(stmt, 3);
                int size = sqlite3_column_bytes(stmt, 3);
                
                NSData *data = [[NSData alloc] initWithBytes:c_blob length:size];
                
                NSError *error = nil;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                
                [muArr addObject:dict];
            }
        }else{
            NSLog(@"查询失败，%d", result);
        }
        
    }
    return muArr;
}





@end
