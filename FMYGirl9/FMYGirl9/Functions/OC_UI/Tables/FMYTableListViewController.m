//
//  FMYTableListViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/3/23.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYTableListViewController.h"
#import "FMYTableScrollViewController.h"
#import "FMYCollectionViewController.h"

@interface FMYTableListViewController ()

@end

@implementation FMYTableListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObject:@"滚动监听"];
    
    [self.arrDataSource addObject:@"Collection滚动监听"];
    
    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    [request.allHTTPHeaderFields setValuesForKeysWithDictionary:@{}];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
//    [downloadTask resume];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMYViewController *desVC;
    if (indexPath.row == 0)
    {
        FMYTableScrollViewController *propertiesVC = [FMYTableScrollViewController new];
        desVC   = propertiesVC;
    }
    else if (indexPath.row == 1)
    {
        FMYCollectionViewController *collectionVC = [FMYCollectionViewController new];
        desVC   = collectionVC;
    }
    
    [self.navigationController pushViewController:desVC animated:YES];
}

@end
