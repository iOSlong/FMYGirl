//
//  FMYImgLoadViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/6/21.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYImgLoadViewController.h"
#import <UIImageView+AFNetworking.h>

@interface FMYImgLoadViewController ()

@end

@implementation FMYImgLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *imgUrlArray = @[
                             @"http://f11.baidu.com/it/u=974761348,3026900552&fm=72",
                             @"http://img5.imgtn.bdimg.com/it/u=2483348597,1831098538&fm=26&gp=0.jpg",
                             @"http://img3.imgtn.bdimg.com/it/u=1083327552,553557555&fm=26&gp=0.jpg",
                             @"http://img2.imgtn.bdimg.com/it/u=1981593005,1408764669&fm=26&gp=0.jpg"];
    [self.arrDataSource addObjectsFromArray:imgUrlArray];
}

- (FMYTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMYTableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.arrDataSource[indexPath.row]] placeholderImage:nil];
    return cell;
}







@end
