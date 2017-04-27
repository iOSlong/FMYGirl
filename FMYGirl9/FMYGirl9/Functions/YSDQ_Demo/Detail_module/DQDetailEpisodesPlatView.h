//
//  DQDetailEpisodesPlatView.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQDetailEpisodesPlatView : UIView

@property (nonatomic, strong) NSMutableArray<NSArray *> *episodesSection;
- (void)reloadEpisodesPlatWithType:(NSNumber *)type;

@end
