//
//  FMYRuntimePropertiesViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/23.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYRuntimePropertiesViewController.h"
#import "FMYPerson.h"
#import "FMYChinese.h"
#import "NSObject+FMY.h"


@interface FMYRuntimePropertiesViewController ()
@property  (nonatomic) UIView *viewHeader;
@property  (nonatomic) NSArray *arrClassName;
@property  (nonatomic) UISegmentedControl *segControl;

@end

@implementation FMYRuntimePropertiesViewController
- (NSArray *)arrClassName {
    if (!_arrClassName) {
        _arrClassName = @[NSStringFromClass([FMYPerson class]),
                          NSStringFromClass([FMYObject class]),
                          NSStringFromClass([FMYChinese class]),
                          NSStringFromClass([UITableView class]),
                          NSStringFromClass([UIButton class])];
    }
    return _arrClassName;
}
- (UISegmentedControl *)segControl {
    if (!_segControl) {
        _segControl = [[UISegmentedControl alloc] initWithItems: self.arrClassName];

        [_segControl addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
        
        [_segControl layoutSize:CGSizeMake(myDisplayW, 40)];
    }
    return _segControl;
}
// TODO: 适应tableview header的效果
- (UIView *)viewHeader {
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] init];
        _viewHeader.backgroundColor = [UIColor yellowColor];
        [_viewHeader layoutHeight:myDisplayW * 0.2];
        [_viewHeader layoutWidth:SCREENW];
        [_viewHeader addSubview:self.segControl];
    }
    return _viewHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.tableHeaderView = self.viewHeader;
    [self.segControl layoutCenter];

}

- (void)segmentValueChange:(UISegmentedControl *)segC {
    [self.arrDataSource removeAllObjects];
    
    NSString *className = self.arrClassName[segC.selectedSegmentIndex];
    
    Class cls = NSClassFromString(className);
    
    if ([FMYPerson class] == cls)
    {
        [self.arrDataSource addObjectsFromArray:[FMYPerson fmyProperties]];
    }
    else if ([UITableView class] == cls)
    {
        [self.arrDataSource addObjectsFromArray:[UITableView fmyProperties]];
    }
    else if ([UIButton class] == cls)
    {
        [self.arrDataSource addObjectsFromArray:[UIButton fmyProperties]];
    }
    else if ([FMYObject class] == cls)
    {
        [self.arrDataSource addObjectsFromArray:[FMYObject fmyProperties]];
    }
    else
    {
        [self.arrDataSource addObjectsFromArray:[FMYChinese fmyProperties]];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (FMYTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMYTableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *item = self.arrDataSource[indexPath.row];
    cell.textLabel.text         = [item objectForKey:@"name"];
    cell.detailTextLabel.text   = [item objectForKey:@"type"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  64;
}





@end
