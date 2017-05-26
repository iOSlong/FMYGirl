//
//  FMYURLSessionViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/5/26.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYURLSessionViewController.h"
#import "FMYSessionDetailViewController.h"

@interface FMYURLSessionViewController ()

@end

@implementation FMYURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"Native_NSURLSession"];
    [self.arrDataSource addObject:@"AFN_SessionManager"];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYTableViewController *tableVC;
    if (indexPath.row == 0)
    {
        FMYSessionDetailViewController *nativesessionVC = [FMYSessionDetailViewController new];
        tableVC = nativesessionVC;
    }
    else if (indexPath.row == 1)
    {
        FMYSessionDetailViewController *afnsessionVC = [FMYSessionDetailViewController new];
        tableVC = afnsessionVC;
    }
    
    tableVC.title = self.arrDataSource[indexPath.row];
    tableVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tableVC animated:YES];
}



@end
