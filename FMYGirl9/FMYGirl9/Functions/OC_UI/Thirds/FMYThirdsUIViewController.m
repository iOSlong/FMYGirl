//
//  FMYThirdsUIViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/5/16.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYThirdsUIViewController.h"
#import "MBProgressViewController.h"


@interface FMYThirdsUIViewController ()

@end

@implementation FMYThirdsUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.arrDataSource addObject:@"MBProgressView"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0)
        {
            MBProgressViewController *mbprogressVC = [MBProgressViewController new];
            desVC  = mbprogressVC;
            UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backBarButtonItem;
        }
    }
    desVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:desVC animated:YES];
}




@end
