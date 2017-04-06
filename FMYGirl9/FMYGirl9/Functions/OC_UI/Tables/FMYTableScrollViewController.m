//
//  FMYTableScrollViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/3/23.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYTableScrollViewController.h"

@interface FMYTableScrollViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;

@end

@implementation FMYTableScrollViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
    }
    return _tableView;
}

- (void)reloadData {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    [_dataArray removeAllObjects];
    
    NSArray *section1 = @[@"王诩",@"司空",@"王诩",@"司空"];
    NSArray *section2 = @[@"王诩2",@"司空2",@"王诩2",@"司空2"];
    NSArray *section3 = @[@"王诩3",@"司空3",@"王诩3",@"司空3"];
    NSArray *section4 = @[@"王诩4",@"司空4",@"王诩4",@"司空4"];

    [_dataArray addObjectsFromArray:@[section1,section2,section3,section4]];
    
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    [self reloadData];
}

#pragma mark - DataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"section - %ld",(long)section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}
- (FMYTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusecellIdentifer = nil;
    reusecellIdentifer = NSStringFromClass([self class]);
    FMYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusecellIdentifer];
    if (cell == nil) {
        cell = [[FMYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusecellIdentifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row < [self.dataArray[indexPath.section] count]) {
        NSObject *item = self.dataArray[indexPath.section][indexPath.row];
        cell.textLabel.text = item.description;
    }
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 124 + arc4random()%100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ScrollNotification 
// 手动拖动 起始和终止调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"");
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"停止拖拽惯性滑动");
//}

/// 无论是拖拽立刻停止  还是拖拽之后的惯性停止， 都会调用下面这个函数。
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        NSLog(@"滑动停止   -    惯性");
    }else{
        NSLog(@"滑动停止   -    拖拽");
    }
    NSArray *visibalCellArr = self.tableView.visibleCells;
    NSMutableArray *visibleIndexPathArr = [NSMutableArray array];
    for (FMYTableViewCell *cell in visibalCellArr) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [visibleIndexPathArr addObject:indexPath];
    }
    NSLog(@"%@",visibleIndexPathArr);
}




// 自动滚动 起始和终止调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"停止 自动动画滑动");
}


@end
