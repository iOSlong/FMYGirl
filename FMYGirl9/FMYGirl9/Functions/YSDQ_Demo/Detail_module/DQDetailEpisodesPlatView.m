//
//  DQDetailEpisodesPlatView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "DQDetailEpisodesPlatView.h"
#import "DQPlatCollectionView.h"
#import "DQPlatCollectionViewCell.h"
#import "DQEpisodesGroupBarView.h"
#import "FMYButton+FMY.h"
#import <Masonry.h>

@interface DQDetailEpisodesPlatView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) FMYButton *btnCancel;
@property (nonatomic, strong)  DQPlatCollectionView *collectionView;

@property (nonatomic, strong) DQEpisodesGroupBarView *groupBarView;

@end

@implementation DQDetailEpisodesPlatView

- (DQEpisodesGroupBarView *)groupBarView {
    if (!_groupBarView) {
        _groupBarView = [[DQEpisodesGroupBarView alloc] init];
    }
    return _groupBarView;
}


- (DQPlatCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[DQPlatCollectionView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height - 40)];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate        = self;
        _collectionView.dataSource      = self;
        _collectionView.pagingEnabled   = YES;
        
        [_collectionView registerClass:[DQPlatCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DQPlatCollectionViewCell class])];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if (!_episodesSection) {
            _episodesSection = [NSMutableArray array];
        }
        [self configurePlatView];
    }
    return self;
}

- (void)configurePlatView {

    
    _labelTitle = [UILabel new];
    _labelTitle.textColor = RGBCOLOR_HEX(0x444444);
    _labelTitle.text = @"选集";
    _labelTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    
    _btnCancel = [FMYButton ysdqBarBtnSelected:@"关闭点击icon" imgNormal:@"关闭icon" imgHighlight:@"关闭点击icon" target:self action:@selector(btnCancelClick:)];
    
    [self addSubview:_labelTitle];
    [self addSubview:_btnCancel];
    [self addSubview:self.collectionView];

    
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
    }];
    
    [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(_labelTitle.mas_centerY);
    }];
    

}

- (void)reloadEpisodesPlatWithType:(NSNumber *)type {
    if (self.superview == nil) {
        return;
    }
    //    for test
    if (self.episodesSection.count == 0) {
        [self.episodesSection addObjectsFromArray:@[@[@""],@[@""],@[@""]]];
    }
    
    
    
    CGFloat top = self.top;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top));
        make.left.equalTo(self.superview.mas_left);
        make.right.equalTo(self.superview.mas_right);
        make.bottom.equalTo(self.superview.mas_bottom);
    }];
    
    
    [self addSubview:self.groupBarView];
    if (self.groupBarView) {
        [self.groupBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelTitle.mas_bottom).offset(20);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@60);
        }];
    }
    
    
    self.groupBarView.dataArray = @[@"1-50",@"51-100",@"101-150",@"151-200",@"201-250",@"251-300",@"301-350",@"351-400"];
    
//    self.groupBarView.hidden = YES;// 通过请求得到判断。
    
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.groupBarView.hidden) {
            make.top.equalTo(_labelTitle.mas_bottom).offset(20);
        }else{
            make.top.equalTo(_groupBarView.mas_bottom).offset(15);
        }
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:@"VideoType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.collectionView reloadData];

}



- (void)btnCancelClick:(UIButton *)btn {
    if ([self.superview respondsToSelector:@selector(setHidden:)]) {
        [self.superview setHidden:YES];
    }else{
        NSLog(@"big wrong!");
    }
}


#pragma mark - PageScrollView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.episodesSection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DQPlatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DQPlatCollectionViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row < self.episodesSection.count) {
        cell.dataArray = self.episodesSection[indexPath.row];
    }

    [cell.collectionView reloadData];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.width, collectionView.height);
}


@end



