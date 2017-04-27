//
//  FMYYSDQDetailViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYYSDQDetailViewController.h"
#import <Masonry.h>

#import "FMYDetailBarView.h"
#import "FMYYSDQDetailInfoCell.h"
#import "FMYBottomView.h"
#import "FMYDetailSiteDrawer.h"


#import "DQDetailEpisodesPlatView.h"

@interface FMYYSDQDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *playerContainerView;
@property (nonatomic, strong) UIView *contentContainerView;

@property (nonatomic, strong) FMYTableView *tableView;

@property (nonatomic, strong) FMYDetailBarView *barView;

@property (nonatomic, strong) FMYBottomView     *bottomView;

@property (nonatomic, strong) FMYDetailSiteDrawer *siteDrawer;

@property (nonatomic, strong) DQDetailEpisodesPlatView *episodesPlatView;

@end

@implementation FMYYSDQDetailViewController {
    DQModel *_model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureContainerView];
    
    [self.contentContainerView addSubview:self.tableView];
    
    
    [self configureAccessoryViews];
    
    _model = [DQModel new];
    _model.showInfo = testString;
    
    [self.tableView reloadData];
    
    
}


- (void)configureContainerView {
    self.playerContainerView    = [UIView new];
    self.contentContainerView   = [UIView new];
    _playerContainerView.backgroundColor    = [UIColor yellowColor];
    _contentContainerView.backgroundColor   = [UIColor purpleColor];
    
    [self.view addSubview:_playerContainerView];
    [self.view addSubview:_contentContainerView];
    
    CGFloat multiplie = MIN(SCREENW, SCREENH)/MAX(SCREENW, SCREENH);
    [self.playerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(self.view.mas_width).multipliedBy(multiplie);
    }];
    
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.playerContainerView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    self.tableView = [[FMYTableView alloc] initWithFrame:self.contentContainerView.bounds style:UITableViewStylePlain];
    _tableView.scrollIndicatorInsets    = _tableView.contentInset;
    _tableView.autoresizingMask         = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle           = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource               = self;
    _tableView.delegate                 = self;
    _tableView.bounces                  = NO;
    
    [_tableView registerClass:[FMYYSDQDetailInfoCell class] forCellReuseIdentifier:NSStringFromClass([FMYYSDQDetailInfoCell class])];
    [self.contentContainerView addSubview:_tableView];
}

- (FMYDetailBarView *)barView {
    if (!_barView) {
        _barView = [FMYDetailBarView new];
    }
    return _barView;
}


- (void)configureAccessoryViews {
    self.tableView.tableHeaderView = self.barView;
    [self.barView detailBarEvent:^(DQDetailEvent event) {
        NSLog(@"%lu",(unsigned long)event);
        CGPoint localP = [_barView convertPoint:[FMYUtils sharedFMYUtils].localP toView:self.view];
        [FMYUtils sharedFMYUtils].localP = localP;
        CGPoint p = [_barView convertPoint:CGPointMake(0, _barView.height) toView:self.view];
        
        if (!_siteDrawer) {
            _siteDrawer = [[FMYDetailSiteDrawer alloc] initWithFrame:CGRectMake(10, p.y + 64 + 8, 100, 160)];
        }
        _siteDrawer.arrSites = @[@"",@"",@"",@""];
        self.bottomView.centerView = self.siteDrawer;
        self.bottomView.hidden = NO;
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (FMYTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"ysdqCellID";
    FMYTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FMYYSDQDetailInfoCell class])];
        weakSelf();
        [((FMYYSDQDetailInfoCell *)cell) cellEvent:^(BOOL show) {
            strongSelf();
            _model.show = show;
            [strongSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        ((FMYYSDQDetailInfoCell *)cell).model = _model;
    }
    
    if (!cell) {
        cell = [[FMYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = @"查看更多";
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [FMYYSDQDetailInfoCell cellHeightWithModel:_model];
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0) {
        self.bottomView.centerView = self.episodesPlatView;
        self.bottomView.hidden = NO;
        [self.episodesPlatView reloadEpisodesPlatWithType:[NSNumber numberWithInt:indexPath.row%2]];
    }
}



- (FMYBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[FMYBottomView alloc] initWithStyle:FMYBottomViewStyleLucency];
    }
    return _bottomView;
}

- (DQDetailEpisodesPlatView *)episodesPlatView {
    if (!_episodesPlatView) {
        _episodesPlatView = [[DQDetailEpisodesPlatView alloc] initWithFrame:CGRectMake(0, SCREENH*0.4, SCREENW, SCREENH*0.55)];
    }
    return _episodesPlatView;
}








@end
