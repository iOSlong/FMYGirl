//
//  FMYSessionDetailViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/5/26.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYSessionDetailViewController.h"


#define url_jokeList  @"http://japi.juhe.cn/joke/content/list.from"

@interface FMYSessionDetailViewController ()

@end

@implementation FMYSessionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObjectsFromArray:@[@"Get",
                                             @"Post",
                                             @"Download",
                                              ]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *params = @{@"key":@"fd7e7824f6882e7b146a4c5b0eda5e5c",
                             @"sort":@"desc",
                             @"time":[NSString stringWithFormat:@"%.f",[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]],
                             @"page":@"0",
                             @"pagesize":@"15"};

    
    
    if (indexPath.row == 0) {
        
        [[[FMYURLSessionManager alloc] init] sessionGet:url_jokeList parameters:params success:^(NSURLSessionTask *task, id object) {
            NSLog(@"%@",object);
            NSError *parsError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableLeaves error:&parsError];
            if (parsError == nil) {
                NSLog(@"%@",dict);
            }
        } failure:^(NSURLSessionTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else if (indexPath.row == 1) {
        [[[FMYURLSessionManager alloc] init] sessionPost:url_jokeList parameters:params success:^(NSURLSessionTask *task, id object) {
            NSLog(@"%@",object);
            NSError *parsError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableLeaves error:&parsError];
            if (parsError == nil) {
                NSLog(@"%@",dict);
            }
        } failure:^(NSURLSessionTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    else{
        [[[FMYURLSessionManager alloc] init] dataTaskWithHTTPMethod:@"GET" URLString:url_jokeList parameters:params success:^(NSURLSessionTask *task, id object) {
            NSLog(@"%@",object);
            NSError *parsError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableLeaves error:&parsError];
            if (parsError == nil) {
                NSLog(@"%@",dict);
            }
        } failure:^(NSURLSessionTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}


@end
