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

@interface FMYRuntimePropertiesViewController ()
@property  (nonatomic) UIView *viewHeader;
@property  (nonatomic) NSArray *arrClassName;
@property  (nonatomic) UISegmentedControl *segControl;

@end

@implementation FMYRuntimePropertiesViewController
- (NSArray *)arrClassName {
    if (!_arrClassName) {
        _arrClassName = @[NSStringFromClass([FMYPerson class]),
                          NSStringFromClass([FMYChinese class])];
    }
    return _arrClassName;
}
- (UISegmentedControl *)segControl {
    if (!_segControl) {
        _segControl = [[UISegmentedControl alloc] initWithItems: self.arrClassName];
        
        [_segControl addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
        
        [_segControl layoutSize:CGSizeMake(myDisplayW * 0.5, 40)];
    }
    return _segControl;
}
- (UIView *)viewHeader {
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] init];
        _viewHeader.backgroundColor = [UIColor yellowColor];
        
        [_viewHeader addSubview:self.segControl];
    }
    return _viewHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.tableHeaderView = [self viewHeader];
    [self.segControl layoutCenter];
    [self.viewHeader layoutAuthor:CGPointMake(mySpanLeft, mySpanIn)];
    [self.viewHeader layoutSize:CGSizeMake(myDisplayW, myDisplayW * 0.38)];

}

- (void)segmentValueChange:(UISegmentedControl *)segC {
    NSString *className = self.arrClassName[segC.selectedSegmentIndex];
    id objc = NSClassFromString(className);
//    self.arrDataSource = [FMYObject]
}





@end
