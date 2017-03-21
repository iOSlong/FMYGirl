//
//  FMYBannersTableViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/3/21.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYBannersTableViewController.h"
#import "FMYBannnerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FMYBannersTableViewController ()

@property (nonatomic) FMYBannnerView *bannerView;

@property (nonatomic) UIImageView *footerTest;

@end

@implementation FMYBannersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bannerView = [[FMYBannnerView alloc] initWithFrame:CGRectMake(0,0,self.view.width, 200)];
    [self.bannerView layoutSize:CGSizeMake(self.view.width, 200)];
    self.bannerView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = self.bannerView;
    
    
    NSArray *urlArr = @[@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=78774946,2151458707&fm=206&gp=0.jpg",@"http://p2.ifengimg.com/cmpp/2016/10/25/00/705e90e5-5a57-41d2-9414-b9953bf82f98_size67_w500_h332.jpg", @"http://img.ltaaa.com/bbs/forum/201411/04/181900y7j487w33jx633wi.jpg"];
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        FMYBannerItem *item = [FMYBannerItem new];
        item.imgUrl     = urlArr[i];
        item.timeSpan   = 3;
        [items addObject:item];
    }
    
    self.bannerView.bannelItems = items;
    
    
    
    
    [self.bannerView bannerEvent:^(NSInteger index) {
        [self showHint:[NSString stringWithFormat:@"selected :%ld",(long)index] hide:1];
    }];
    
    
    
    
//    NSString *testUrl = @"http://img3.imgtn.bdimg.com/it/u=2397315675,2388530398&fm=23&gp=0.jpg";
//    self.footerTest = [UIImageView new];
//    [self.footerTest layoutSize:CGSizeMake(self.view.width, 200)];
//    self.footerTest.backgroundColor = [UIColor blueColor];
//    self.tableView.tableFooterView = self.footerTest;
//    [self.footerTest sd_setImageWithURL:[NSURL URLWithString:testUrl]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
