//
//  FMYSqliteViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYSqliteViewController.h"
#import "FMYDBManager.h"
#import "FMYPerson.h"

@interface FMYSqliteViewController ()

@property (nonatomic, strong)FMYPerson *myperson;

@end

@implementation FMYSqliteViewController {
    FMYDBManager *_DBM;
    NSArray *_excArray;
    NSMutableArray *_sqlArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _excArray = @[@"增",@"删",@"改",@"查"];
    _sqlArray = [NSMutableArray array];

    _DBM = [FMYDBManager sharedDBmanager];
    
    [self.arrDataSource addObjectsFromArray:@[_excArray,_sqlArray]];
    
    
    self.myperson = [FMYPerson new];
    [self.myperson randomValue];
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"执行操作";
    }else if (section == 1){
        return @"库表数据";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 33;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrDataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (FMYTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusecellIdentifer = nil;
    reusecellIdentifer = NSStringFromClass([self class]);
    FMYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusecellIdentifer];
    if (cell == nil) {
        cell = [[FMYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusecellIdentifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        if (indexPath.row < _excArray.count) {
            NSObject *item = _excArray[indexPath.row];
            cell.textLabel.text = item.description;
        }
    }else{
        if (indexPath.row < _sqlArray.count) {
            NSObject *item = _sqlArray[indexPath.row];
            cell.textLabel.text = item.description;
            cell.textLabel.numberOfLines = 0;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.myperson randomValue];
            [_DBM insert:self.myperson ID:self.myperson.ID desc:self.myperson.description];
            [self reloadDataFromDB];
        }else if (indexPath.row == 1) {
            [_DBM remove:_sqlArray.firstObject ID:nil desc:nil];
            [self reloadDataFromDB];
        }
    }
}



- (void)reloadDataFromDB {
    NSArray *sqlArr = [_DBM getArrayBy:nil];
    NSLog(@"%@",sqlArr);
    [_sqlArray removeAllObjects];
    for (NSDictionary *dict in sqlArr) {
        FMYPerson *person = [FMYPerson objectWithDict:dict];
        [_sqlArray addObject:person];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
