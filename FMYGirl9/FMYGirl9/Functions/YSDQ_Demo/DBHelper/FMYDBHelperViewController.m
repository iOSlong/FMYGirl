//
//  FMYDBHelperViewController.m
//  FMYGirl9
//
//  Created by lxw on 2017/8/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDBHelperViewController.h"
#import "FMYDBPoet.h"

@interface FMYDBHelperViewController ()

@end

@implementation FMYDBHelperViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  TODO: systembackButton target change？
         */
        self.navigationItem.backBarButtonItem.target = self;
        self.navigationItem.backBarButtonItem.action = @selector(backButtomPressDetected:);
    }
    return self;
}

- (void)backButtomPressDetected:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *poetArr = [NSMutableArray array];
    FMYDBPoet *poetL = [FMYDBPoet new];
    poetL.name = @"Linxi";
    poetL.age = 25;
    poetL.living = YES;
    poetL.time = @"2015";
    
    FMYDBPoet *poetF = [FMYDBPoet new];
    poetF.name = @"FengM";
    poetF.age = 26;
    poetF.living = YES;
    poetF.time = @"2016";
    
    FMYDBPoet *poetY = [FMYDBPoet new];
    poetY.name = @"Yaoer";
    poetY.age = 27;
    poetY.living = NO;
    poetY.time = @"2017";
    
    [poetArr addObjectsFromArray:@[poetL,poetY,poetF]];
    
    NSInteger rowCount = [FMYDBPoet rowCountWithWhere:nil];

    NSArray *oldArr = [FMYDBPoet searchWithWhere:nil];
    BOOL status = [FMYDBPoet deleteWithWhere:nil];//清空数据库
    oldArr = [FMYDBPoet searchWithWhere:nil];
    
    [[FMYDBPoet getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper * _Nonnull helper) {
        BOOL success = YES;
        for (FMYDBPoet *poet in poetArr) {
            success = [helper insertToDB:poet];
            if (!success) {
                break;
            }
        }
        return success;
    }];
    
    rowCount = [FMYDBPoet rowCountWithWhere:@{@"living":@1}];
    rowCount = [FMYDBPoet rowCountWithWhere:@{@"living":@0}];
    
    FMYDBPoet *poetH = [FMYDBPoet new];
    poetH.name = @"hopeOne";
    poetH.age = 28;
    poetH.living = NO;
    poetH.time = @"2018";
    [poetArr addObject:poetH];
    NSArray *newarray = [FMYDBPoet searchWithWhere:@""];
    
    [[FMYDBPoet getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper * _Nonnull helper) {
        BOOL success = YES;
        for (FMYDBPoet *poet in poetArr) {
            if ([FMYDBPoet isExistsWithModel:poet]) {
                success = [helper updateToDB:poet where:nil];
            }else{
                success = [helper insertToDB:poet];
            }
            if (!success) {
                break;
            }
        }
        return success;
    }];
    
    newarray = [FMYDBPoet searchWithWhere:@""];
    newarray = [FMYDBPoet searchWithWhere:@{@"living":@0}];

    rowCount = [FMYDBPoet rowCountWithWhere:nil];
    
    //update
    poetY.time = @"forever";
    [poetY updateToDB];
    
    NSArray *upArray  = [FMYDBPoet searchWithWhere:nil];
    
    //delete
    [poetL deleteToDB];
    NSArray *deleArray  = [FMYDBPoet searchWithWhere:nil];
    
    NSLog(@"over test");

    
}



@end
