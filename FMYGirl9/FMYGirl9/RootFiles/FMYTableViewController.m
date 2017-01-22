//
//  FMYTableViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYTableViewController.h"

@interface FMYTableViewController ()

@end

@implementation FMYTableViewController

- (FMYTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FMYTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}


#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusecellIdentifer = nil;
    reusecellIdentifer = NSStringFromClass([self class]);
    FMYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusecellIdentifer];
    if (cell == nil) {
        cell = [[FMYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusecellIdentifer];
    }
    return cell;
}



@end
