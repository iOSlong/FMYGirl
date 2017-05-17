//
//  FMYCollectionViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/3/28.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYCollectionViewController.h"
#import "FMYCollectionViewCell.h"
#import "FMYCollectionReusableView.h"
#import <MJRefresh/MJRefreshNormalHeader.h>

@interface FMYCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionoView;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@end

@implementation FMYCollectionViewController {
    NSArray *_itemLayoutInfo;
}

- (MJRefreshNormalHeader *)refreshHeader {
    if (!_refreshHeader) {
        weakSelf();
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            strongSelf();
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_refreshHeader endRefreshing];
            });
        }];
    }
    return _refreshHeader;
}

- (UICollectionView *)collectionoView {
    if (!_collectionoView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        //注意：如果是Vertical的则cell是水平布局排列，如果是Horizontal则cell是垂直布局排列 （这个就叫做流式布局）
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每一个item的大小
        flowLayout.itemSize     = CGSizeMake(SCREENW,100);
        //设置分区的EdgeInset
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        
        flowLayout.minimumLineSpacing = 2;
        
        flowLayout.minimumInteritemSpacing = 10;
        
//        [flowLayout setHeaderReferenceSize:CGSizeMake(SCREENW, 55)];
        
        

        CGRect one = {{0,0},{SCREENW,SCREENH - 48}};
        _collectionoView = [[UICollectionView alloc] initWithFrame:one collectionViewLayout:flowLayout];
        _collectionoView.dataSource         = self;
        _collectionoView.delegate           = self;
        _collectionoView.scrollEnabled      = YES;
        _collectionoView.pagingEnabled      = NO;
        _collectionoView.allowsSelection    = YES;
        
        
        _collectionoView.backgroundColor = RGBCOLOR_HEX(0xad2fda);
        
        [_collectionoView registerClass:[FMYCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FMYCollectionViewCell class])];
        
        
        [_collectionoView registerClass:[FMYCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([FMYCollectionReusableView class])];
        [_collectionoView registerClass:[FMYCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([FMYCollectionReusableView class])];
    }
    return _collectionoView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _itemLayoutInfo = @[@{@0:@4},
                        @{@1:@3},
                        @{@2:@3},
                        @{@3:@10},];
    
    [self.view addSubview:self.collectionoView];
    
    self.collectionoView.mj_header = self.refreshHeader;
    
    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithTitle:@"scroll" style:UIBarButtonItemStylePlain target:self action:@selector(scrollBarItemClick:)];
    self.navigationItem.rightBarButtonItem = rBarItem;
    
    
}

- (void)scrollBarItemClick:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:3];
    [self.collectionoView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _itemLayoutInfo.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *itemInfo = _itemLayoutInfo[section];
    return [[itemInfo objectForKey:[itemInfo allKeys].firstObject] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FMYCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[FMYCollectionViewCell alloc] initWithFrame:CGRectZero];
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SCREENW/2 - 10, 100);
    }
    else if (indexPath.section == 1) {
        return CGSizeMake(SCREENW/3 - 10, 100);
    }
    else if (indexPath.section == 2) {
        return CGSizeMake(SCREENW/3 - 10, 150);
    }
    return CGSizeMake(SCREENW-10, arc4random()%200);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",indexPath);
}

#pragma mark - SupplementView About
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FMYCollectionReusableView *reusableView;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([FMYCollectionReusableView class]) forIndexPath:indexPath];
        
    }
    if (!reusableView) {
        reusableView = [[FMYCollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 55)];
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section%2==0) {
        return CGSizeMake(SCREENW, 35);
    }
    return CGSizeMake(SCREENW, 20);
}

@end
