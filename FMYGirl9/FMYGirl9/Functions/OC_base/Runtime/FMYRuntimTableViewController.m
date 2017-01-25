//
//  FMYRuntimTableViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYRuntimTableViewController.h"
#import "FMYRuntimePropertiesViewController.h"
#import "FMYRuntimeMsgSendViewController.h"
#import "FMYRuntimeNormalCaseViewController.h"
@interface FMYRuntimTableViewController ()

@end

@implementation FMYRuntimTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"获取对象的属性"];
    [self.arrDataSource addObject:@"动态方法解析和转发"];
    [self.arrDataSource addObject:@"runtime 7 种常用方法"];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FMYTableViewCell *cell = (FMYTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.arrDataSource[indexPath.row];
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYTableViewController *tableVC;
    if (indexPath.row == 0)
    {
        FMYRuntimePropertiesViewController *propertiesVC = [FMYRuntimePropertiesViewController new];
        tableVC = propertiesVC;
    }
    else if (indexPath.row == 1)
    {
        FMYRuntimeMsgSendViewController *msgSendVC = [FMYRuntimeMsgSendViewController new];
        tableVC = msgSendVC;
    }
    else if (indexPath.row == 2)
    {
        FMYRuntimeNormalCaseViewController *caseVC = [FMYRuntimeNormalCaseViewController new];
        tableVC = caseVC;
    }
    tableVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tableVC animated:YES];

}


@end
