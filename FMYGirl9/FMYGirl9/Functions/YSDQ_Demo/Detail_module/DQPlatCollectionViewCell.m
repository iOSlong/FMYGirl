//
//  DQPlatCollectionViewCell.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "DQPlatCollectionViewCell.h"
#import "DQDetailEpisodesCollectionViewCell.h"
#import <Masonry.h>


@implementation DQPlatCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
//        CGFloat itemW = (self.width - 6 * 10)/5;
//        CGFloat itemH = 50.0/63.0 * itemW;
//        NSNumber *videoType =  [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoType"];
//        if ([videoType integerValue] == 1) {
//            itemW = self.width - 20;
//            itemH = 44;
//        }
//        flowLayout.itemSize     = CGSizeMake(itemW,itemH);
//        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);
        _collectionView.dataSource         = self;
        _collectionView.delegate           = self;
        _collectionView.scrollEnabled      = YES;
        _collectionView.pagingEnabled      = NO;
        _collectionView.allowsSelection    = YES;
        
        
        _collectionView.backgroundColor = RGBCOLOR_HEX(0xad2fda);
        
        [_collectionView registerClass:[DQDetailEpisodesCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DQDetailEpisodesCollectionViewCell class])];
        
    }
    return _collectionView;
}

#pragma mark - CollectionViewDataSource and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataArray.count;
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
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (self.width - 6 * 10)/5;
    CGFloat itemH = 50.0/63.0 * itemW;
    NSNumber *videoType =  [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoType"];
    if ([videoType integerValue] == 1) {
        itemW = self.width - 20;
        itemH = 44;
    }
    return  CGSizeMake(itemW,itemH);
}


- (void)setDataArray:(NSArray *)dataArray {
    if (dataArray && dataArray.count > 1) {
        _dataArray = dataArray;
    }else{
        _dataArray = @[@"",@"",@"",@"",@"",
                           @"",@"",@"",@"",@"",
                           @"",@"",@"",@"",@"",
                           @"",@"",@"",@"",@"",
                           @"",@"",@"",@"",@"",
                           @"",@"",@"",@"",@"",
                           @"",@"",@"",@"",@""];

    }
}

@end
