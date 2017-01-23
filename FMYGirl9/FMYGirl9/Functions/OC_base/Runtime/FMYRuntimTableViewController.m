//
//  FMYRuntimTableViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYRuntimTableViewController.h"
#import "FMYRuntimePropertiesViewController.h"

@interface FMYRuntimTableViewController ()

@end

@implementation FMYRuntimTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"获取对象的属性"];
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
    FMYRuntimePropertiesViewController *propertiesVC = [[FMYRuntimePropertiesViewController alloc] init];
    [self.navigationController pushViewController:propertiesVC animated:YES];
}


@end
