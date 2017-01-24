//
//  FMYUITableViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/24.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYUITableViewController.h"
#import "FMYLayoutConstraintViewController.h"

@interface FMYUITableViewController ()

@end

@implementation FMYUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.arrDataSource addObject:@"LayoutConstraint"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYLayoutConstraintViewController *propertiesVC = [[FMYLayoutConstraintViewController alloc] init];
    [self.navigationController pushViewController:propertiesVC animated:YES];
}



@end
