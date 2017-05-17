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
#import "FMYThirdsUIViewController.h"

@interface FMYUITableViewController ()

@end

@implementation FMYUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *sectionA = [NSMutableArray array];
    NSMutableArray *sectionB = [NSMutableArray array];
    
    [sectionA addObject:@"LayoutConstraint"];
    [sectionA addObject:@"MKWebView - JS"];
    [sectionA addObject:@"UIWebView - JS"];
    [sectionA addObject:@"Bezier —— View"];
    [sectionA addObject:@"FocusBanner —— View"];
    [sectionA addObject:@"UITableView"];
    [sectionA addObject:@"CoreText"];
    
    [sectionB addObject:@"Thirds Parts"];
    
    [self.arrDataSource addObjectsFromArray:@[sectionA, sectionB]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return  section? @"---- Third Part ----" :  @"UIKit";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    if (indexPath.section == 0) {

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
    }else{
        if (indexPath.row == 0) {
            FMYThirdsUIViewController *thirdsVC = [FMYThirdsUIViewController new];
            desVC = thirdsVC;
        }
    }
    desVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:desVC animated:YES];
}



@end
