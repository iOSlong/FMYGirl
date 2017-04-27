//
//  DQEpisodesGroupBarView.m
//  Le123PhoneClient
//
//  Created by xuewu.long on 17/4/12.
//  Copyright © 2017年 Ying Shi Da Quan. All rights reserved.
//

#import "DQEpisodesGroupBarView.h"
#import <Masonry.h>

#import "DQDetailEpisodesCollectionViewCell.h"

@implementation DQEpisodesGroupBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        UICollectionViewFlowLayout *_layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 10;
        _layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
        _collectionView.dataSource  = self;
        _collectionView.delegate    = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[DQDetailEpisodesCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DQDetailEpisodesCollectionViewCell class])];
        [self addSubview:_collectionView];

        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_collectionView reloadData];
    
    [_collectionView setContentOffset:CGPointMake(100, 0) animated:YES];
}

#pragma mark - UICollectionView DataSource+Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DQDetailEpisodesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DQDetailEpisodesCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[DQDetailEpisodesCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    weakSelf();
    [cell cellEpisodesEvent:^(id event) {
        strongSelf();
        NSLog(@"%@",event);
    }];
    
    if (indexPath.row < self.dataArray.count) {
        cell.cellitem = self.dataArray[indexPath.row];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (self.width - 6 * 10)/5;
    CGFloat itemH = 50.0/63.0 * itemW;
    return  CGSizeMake(itemW,itemH);
}





@end
