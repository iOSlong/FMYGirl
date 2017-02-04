//
//  FMYSqliteViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYSqliteViewController.h"
#import "FMYDBManager.h"


@interface FMYSqliteViewController ()

@end

@implementation FMYSqliteViewController {
    FMYDBManager *_DBM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _DBM = [FMYDBManager sharedDBmanager];
    
}




@end
