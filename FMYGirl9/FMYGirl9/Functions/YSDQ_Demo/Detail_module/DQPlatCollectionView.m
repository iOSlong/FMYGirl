//
//  DQPlatCollectionView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "DQPlatCollectionView.h"

@implementation DQPlatCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *_layout = [[UICollectionViewFlowLayout alloc] init];

    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _layout.itemSize     = CGSizeMake(frame.size.width,frame.size.height);
    
    _layout.minimumLineSpacing = 0;
    
    _layout.minimumInteritemSpacing = 0;
    
    return [self initWithFrame:frame collectionViewLayout:_layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}

@end
