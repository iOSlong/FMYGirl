//
//  FMYOCBaseViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYOCBaseViewController.h"
#import "FMYRuntimTableViewController.h"
#import "FMYDataStoreViewController.h"
#import "FMYClangllvmViewController.h"

@interface FMYOCBaseViewController ()

@end

@implementation FMYOCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"Runtimes_about"];
    [self.arrDataSource addObject:@"DataStore_about"];
    [self.arrDataSource addObject:@"clang.llvm_about"];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYTableViewController *tableVC;
    if (indexPath.row == 0)
    {
        FMYRuntimTableViewController *runtimeVC = [FMYRuntimTableViewController new];
        tableVC = runtimeVC;
    }
    else if (indexPath.row == 1)
    {
        FMYDataStoreViewController *dataStoreVC = [FMYDataStoreViewController new];
        tableVC = dataStoreVC;
    }
    else if (indexPath.row == 2)
    {
        FMYClangllvmViewController *complierVC = [FMYClangllvmViewController new];
        tableVC = complierVC;
    }
    tableVC.title = self.arrDataSource[indexPath.row];
    tableVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tableVC animated:YES];
    
}



@end
