//
//  FMYYSDQViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYYSDQViewController.h"
#import "FMYYSDQDetailViewController.h"

@interface FMYYSDQViewController ()

@end

@implementation FMYYSDQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"Detail_VC"];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    if (indexPath.row == 0)
    {
        FMYYSDQDetailViewController *detailVC   = [FMYYSDQDetailViewController new];
        detailVC.hidesBottomBarWhenPushed       = YES;
        detailVC.title = @"Detail_VC";
        desVC  = detailVC;
    }
    
    [self.navigationController pushViewController:desVC animated:YES];
}

@end
