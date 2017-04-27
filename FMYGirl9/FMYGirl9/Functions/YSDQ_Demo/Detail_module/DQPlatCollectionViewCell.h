//
//  DQPlatCollectionViewCell.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQPlatCollectionViewCell : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArray;

@end
