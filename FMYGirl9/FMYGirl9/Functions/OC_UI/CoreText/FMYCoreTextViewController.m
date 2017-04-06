//
//  FMYCoreTextViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/6.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYCoreTextViewController.h"
#import "FMYCoreTextShowViewController.h"

@interface FMYCoreTextViewController ()

@end

@implementation FMYCoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"Hello world - show"];
    [self.arrDataSource addObject:@"Hello more - show"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    FMYCoreTextShowViewController *coretestShow = [FMYCoreTextShowViewController new];
    desVC  = coretestShow;
    if (indexPath.row == 0)
    {
        coretestShow.stringShow = @"hello World";
    }
    else if (indexPath.row == 1)
    {
        coretestShow.stringShow = @"Hello World! "
        " 创建绘制的区域，CoreText 本身支持各种文字排版的区域，"
        " 我们这里简单地将 UIView 的整个界面作为排版的区域。"
        " 为了加深理解，建议读者将该步骤的代码替换成如下代码，"
        " 测试设置不同的绘制区域带来的界面变化。";
    }
    [self.navigationController pushViewController:desVC animated:YES];
}


@end
