//
//  FMYCoreTextShowViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/6.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYCoreTextShowViewController.h"
#import "FMYCoreTextView.h"
#import <Masonry.h>

@interface FMYCoreTextShowViewController ()

@property (nonatomic, strong)FMYCoreTextView *coreTextV;

@end

@implementation FMYCoreTextShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.coreTextV = [FMYCoreTextView new];
    self.coreTextV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_coreTextV];

    [self.coreTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(mySpanLeft);
        make.right.equalTo(self.view.mas_right).offset(-mySpanLeft);
        make.top.equalTo(self.view.mas_top).offset(mySpanLeft);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.coreTextV.showText = self.stringShow;
}




@end
