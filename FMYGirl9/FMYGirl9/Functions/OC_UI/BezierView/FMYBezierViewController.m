//
//  FMYBezierViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/7.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYBezierViewController.h"
#import "FMYBottomView.h"

#import "ControlBezierPlat.h"

@interface FMYBezierViewController ()

@property (nonatomic, strong)FMYBottomView *bottomView;
@property (nonatomic, strong)ControlBezierPlat *controlBPlat;

@property (nonatomic, strong)Control_BezierPath *bezierPentagram;
@property (nonatomic, strong)Control_BezierPath *bezierArrow;

@end

@implementation FMYBezierViewController

- (FMYBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[FMYBottomView alloc] initWithStyle:FMYBottomViewStylePlat];
    }
    return _bottomView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrDataSource addObjectsFromArray:@[@"sexangle - Plat",
                                              @"five-pointed star",
                                              @"bezier - Arrow"]];
    
    
    self.controlBPlat = [[ControlBezierPlat alloc] initWithFrame:CGRectMake(0, 0, myDisplayW, myDisplayH * 0.7) withTitles:nil andYS:nil andNS:nil];
    self.controlBPlat.backgroundColor = [UIColor lightGrayColor];
    self.controlBPlat.arrNewsItems = [FMYUtils fileGetNewsItems];
    CGFloat ratio = SCREENW/320.0;
    _controlBPlat.cbp_w    = 32.0 * ratio;
    _controlBPlat.span     = 10.0 * ratio;
    
    
    self.bezierPentagram = [[Control_BezierPath alloc] initWithFrame:CGRectMake(0, 0, 200, 200) by:BezierPathPentagram];
    self.bezierPentagram.colorStroke = [UIColor cyanColor];
    
    self.bezierArrow    = [[Control_BezierPath alloc] initWithFrame:CGRectMake(0, 0, 100, 200) by:BezierPathArrow];
    self.bezierArrow.backgroundColor = [UIColor clearColor];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        self.bottomView.centerView = self.controlBPlat;
    }
    else if (indexPath.row == 1)
    {
        self.bottomView.centerView = self.bezierPentagram;
    }
    else if (indexPath.row == 2)
    {
        self.bottomView.centerView = self.bezierArrow;
    }

    self.bottomView.hidden = NO;
}






@end
