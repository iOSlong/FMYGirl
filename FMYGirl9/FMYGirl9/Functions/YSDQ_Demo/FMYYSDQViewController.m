//
//  FMYYSDQViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYYSDQViewController.h"
#import "FMYYSDQDetailViewController.h"
#import "FMYImgLoadViewController.h"
#import "FMYDBHelperViewController.h"

@interface FMYYSDQViewController ()

@end

@implementation FMYYSDQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"Detail_VC"];
    [self.arrDataSource addObject:@"ImgLoad"];
    [self.arrDataSource addObject:@"DBHelper"];

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
    else if (indexPath.row == 1)
    {
        FMYImgLoadViewController *imgloadVC = [FMYImgLoadViewController new];
        imgloadVC.title = @"ImgLoad";
        desVC = imgloadVC;
    }else if (indexPath.row == 2)
    {
        FMYDBHelperViewController *dbHelperVC = [[FMYDBHelperViewController alloc] init];
        dbHelperVC.title = @"DBHelper";
        desVC = dbHelperVC;
    }
    
    [self.navigationController pushViewController:desVC animated:YES];
}

@end
