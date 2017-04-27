//
//  FMYClangllvmViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/27.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYClangllvmViewController.h"
#import "FMYClangLLVMInfoViewController.h"

@interface FMYClangllvmViewController ()

@end

@implementation FMYClangllvmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"clang.llvm.org"];
    [self.arrDataSource addObject:@"Diagnostic Mappings"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *subVC;
    if (indexPath.row == 0)
    {
        FMYClangLLVMInfoViewController *infoVC = [[FMYClangLLVMInfoViewController alloc] initWith:FMYInfoTypeWebView];
        infoVC.webUrl = @"http://clang.llvm.org/docs/UsersManual.html#id10";
        subVC = infoVC;
    }
    else if (indexPath.row == 1)
    {
        FMYClangLLVMInfoViewController *infoVC = [[FMYClangLLVMInfoViewController alloc] initWith:FMYInfoTypeListView];
        subVC = infoVC;
    }
    subVC.title = self.arrDataSource[indexPath.row];
    subVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subVC animated:YES];
}





@end
