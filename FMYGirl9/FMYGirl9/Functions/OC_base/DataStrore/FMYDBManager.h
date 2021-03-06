//
//  FMYDBManager.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYObject.h"
#import <sqlite3.h>


#define myDBFileName    @"fmy.db" // or fmy.sqlite

//"create table if not exists list(id integer primary key autoincrement,name char,sex char)"
//const char * createList_Data  = "create table if not exists list_data(id integer primary key autoincrement,desc txt, ID txt, data blob)";
//const char *createSQL = "create table if not exists list_data(orderID integer primary key autoincrement, desc txt, ID text, data blob)";

#define createSQL  @"create table if not exists list_data(orderID integer primary key autoincrement, ID text, desc txt, data blob)"


@interface FMYDBManager : FMYObject {
    sqlite3 *_database;
}

+ (FMYDBManager *)sharedDBmanager;

- (BOOL)insert:(FMYObject *)obj ID:(NSString *)ID desc:(NSString *)desc;
- (BOOL)insert:(NSArray<FMYObject *> * )array;
- (BOOL)remove:(FMYObject *)obj ID:(NSString *)ID desc:(NSString *)desc;
- (NSArray *)getArrayBy:(NSDictionary *)queryInfo;


@end
