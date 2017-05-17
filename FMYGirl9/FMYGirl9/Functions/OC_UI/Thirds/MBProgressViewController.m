//
//  MBProgressViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/5/16.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "MBProgressViewController.h"

@interface MBProgressViewController ()

@end

@implementation MBProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
    [self.arrDataSource addObject:@"test progress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [FMYUtils showHint:@"你好我好大家好\n, 嘒彼小星，沌华此月，踏步星影，相月归家" hide:5];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
