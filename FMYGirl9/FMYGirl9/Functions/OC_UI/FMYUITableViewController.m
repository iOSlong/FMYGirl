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

@interface FMYUITableViewController ()

@end

@implementation FMYUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.arrDataSource addObject:@"LayoutConstraint"];
    [self.arrDataSource addObject:@"MKWebView - JS"];
    [self.arrDataSource addObject:@"UIWebView - JS"];
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
    [self.navigationController pushViewController:desVC animated:YES];
}



@end