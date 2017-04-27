//
//  DQDetailEpisodesCollectionViewCell.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DQEpisodeState) {
    DQEpisodeStateNormal,
    DQEpisodeStateDownloaded,
    DQEpisodeStateDownloading,
};

typedef void(^DQEpisodesCellBlock)(id event);

@interface DQDetailEpisodesCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton      *btnTitle;
@property (nonatomic, strong) UIImageView   *imgvMark;
@property (nonatomic, assign) DQEpisodeState state;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) id cellitem;

- (void)cellEpisodesEvent:(DQEpisodesCellBlock)thisBlock;

@end
