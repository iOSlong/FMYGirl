//
//  FMYTableViewController.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYViewController.h"

@interface FMYTableViewController : FMYViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FMYTableView *tableView;

@end
