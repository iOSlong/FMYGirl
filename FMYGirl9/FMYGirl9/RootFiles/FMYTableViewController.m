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

- (NSMutableArray *)arrDataSource {
    if (!_arrDataSource) {
        _arrDataSource = [NSMutableArray array];
    }
    return _arrDataSource;
}
- (FMYTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FMYTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView layoutSpanBounds:FMYSpanMake(0, 0, 0, 0)];
    

}



#pragma mark - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[self.arrDataSource firstObject] isKindOfClass:[NSArray class]]) {
        return self.arrDataSource.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self.arrDataSource firstObject] isKindOfClass:[NSArray class]]) {
        return [self.arrDataSource[section] count];
    }
    return self.arrDataSource.count;
}
- (FMYTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusecellIdentifer = nil;
    reusecellIdentifer = NSStringFromClass([self class]);
    FMYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusecellIdentifer];
    if (cell == nil) {
        cell = [[FMYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusecellIdentifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([[self.arrDataSource firstObject] isKindOfClass:[NSArray class]]) {
        if (indexPath.row < [self.arrDataSource[indexPath.section] count]) {
            NSObject *item = self.arrDataSource[indexPath.section][indexPath.row];
            cell.textLabel.text = item.description;
        }
    }else if (indexPath.row < self.arrDataSource.count) {
        NSObject *item = self.arrDataSource[indexPath.row];
        cell.textLabel.text = item.description;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
