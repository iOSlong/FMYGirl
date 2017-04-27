//
//  DQEpisodesGroupBarView.h
//  Le123PhoneClient
//
//  Created by xuewu.long on 17/4/12.
//  Copyright © 2017年 Ying Shi Da Quan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQEpisodesGroupBarView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;


@end
