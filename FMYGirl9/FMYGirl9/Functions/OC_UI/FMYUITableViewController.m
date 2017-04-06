//
//  FMYUITableViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/24.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYUITableViewController.h"

#import "FMYLayoutConstraintViewController.h"
#import "FMYMKWebViewController.h"
#import "FMYUIWebViewController.h"
#import "FMYBezierViewController.h"
#import "FMYBannersTableViewController.h"
#import "FMYTableListViewController.h"
#import "FMYCoreTextViewController.h"

@interface FMYUITableViewController ()

@end

@implementation FMYUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.arrDataSource addObject:@"LayoutConstraint"];
    [self.arrDataSource addObject:@"MKWebView - JS"];
    [self.arrDataSource addObject:@"UIWebView - JS"];
    [self.arrDataSource addObject:@"Bezier —— View"];
    [self.arrDataSource addObject:@"FocusBanner —— View"];
    [self.arrDataSource addObject:@"UITableView"];
    [self.arrDataSource addObject:@"CoreText"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    if (indexPath.row == 0)
    {
        FMYLayoutConstraintViewController *propertiesVC = [FMYLayoutConstraintViewController new];
        desVC  = propertiesVC;
    }
    else if (indexPath.row == 1)
    {
        FMYMKWebViewController *mkwevVC = [FMYMKWebViewController new];
        desVC  = mkwevVC;
    }
    else if (indexPath.row == 2)
    {
        FMYUIWebViewController *uiwevVC = [FMYUIWebViewController new];
        desVC  = uiwevVC;
    }
    else if (indexPath.row == 3)
    {
        FMYBezierViewController *bezierVC = [FMYBezierViewController new];
        desVC = bezierVC;
    }
    else if (indexPath.row == 4)
    {
        FMYBannersTableViewController *banner = [[FMYBannersTableViewController alloc] init];
        desVC = banner;
    }
    else if (indexPath.row == 5)
    {
        FMYTableListViewController *tableVC = [[FMYTableListViewController alloc] init];
        desVC = tableVC;
    }
    else if (indexPath.row == 6)
    {
        FMYCoreTextViewController *coreTextVC = [FMYCoreTextViewController new];
        desVC = coreTextVC;
    }
    desVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:desVC animated:YES];
}



@end
