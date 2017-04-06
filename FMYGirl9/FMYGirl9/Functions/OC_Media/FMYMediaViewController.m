//
//  FMYMediaViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/1.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYMediaViewController.h"
#import "FMYAVPlayerViewController.h"
@interface FMYMediaViewController ()

@end

@implementation FMYMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"AVPlayer-base"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    if (indexPath.row == 0)
    {
        FMYAVPlayerViewController *avPlayerVC = [FMYAVPlayerViewController new];
        avPlayerVC.title = @"AVPlayer-base";
        desVC  = avPlayerVC;
    }
    
    [self.navigationController pushViewController:desVC animated:YES];
}


@end
