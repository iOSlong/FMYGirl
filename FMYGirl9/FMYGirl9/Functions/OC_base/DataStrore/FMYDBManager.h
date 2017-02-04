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


@interface FMYDBManager : FMYObject {
    sqlite3 *_database;
}

+ (FMYDBManager *)sharedDBmanager;

@end
