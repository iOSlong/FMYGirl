//
//  FMYDataStoreViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDataStoreViewController.h"
#import "FMYSqliteViewController.h"
#import "FMYCoreDataViewController.h"

@interface FMYDataStoreViewController ()

@end

@implementation FMYDataStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.arrDataSource addObject:@"CoreData_about"];
    [self.arrDataSource addObject:@"Sqlite3_about"];
    [self.arrDataSource addObject:@"UserDefault_about"];
    [self.arrDataSource addObject:@"FileManager_about"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYTableViewController *tableVC;
    if (indexPath.row == 0)
    {
        FMYCoreDataViewController *coreDataVC = [FMYCoreDataViewController new];
        tableVC = coreDataVC;
    }
    else if (indexPath.row == 1)
    {
        FMYSqliteViewController *sqlite3VC = [FMYSqliteViewController new];
        tableVC = sqlite3VC;
    }
    else if (indexPath.row == 2)
    {
        
    }
    
    if (tableVC) {
        tableVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:tableVC animated:YES];
    }
}

@end
