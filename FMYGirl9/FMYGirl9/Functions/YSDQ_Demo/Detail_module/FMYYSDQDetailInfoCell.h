//
//  FMYYSDQDetailInfoCell.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYTableViewCell.h"

#define testString  @"《蛮荒记》的故事展开：大荒586年， 神农化羽，神帝之位悬空，引发金、木、水、火、土五族大战。神农传人拓跋野与义弟蚩尤联合对抗侵略者，双军交锋，大地却在战场中央裂开，封印太古凶魔的皮母地丘重现人间，混沌一出，天下将亡。这版概念海报一经曝光，立刻引发不少网友围观。 2015年的影视圈，掀起了网络文学改编IP的热潮：根据《盗墓笔记》、《鬼吹灯》等热门IP改编的多部电视剧、电影相继上映。2016年伊始，阿里影业也放“大招”，正式宣布《蛮荒记》这一IP也将搬上大银幕。 　据《蛮荒记》项目制片人夏天尘介绍，电影《蛮荒记》将是一个类似魔兽世界“艾泽拉斯大陆”的东方上古世界观，“如果一定要做直观的类比，艾泽拉斯大陆讲巨魔、精灵、土灵、矮人、侏儒，我们讲天下诸帝、五大圣女、大荒十神、大荒十大妖女，以《山海经》为蓝本，故事情节取材并贯通华夏传说，将全新的上古世界搬上大银幕。电影的视觉审美和世界观塑造都将打破中国人传统认知，让观众感觉熟悉却又颠覆"

@interface DQModel : NSObject
@property(nonatomic)BOOL show;
@property(nonatomic)NSString *showInfo;

@end




typedef void(^DQDetailCellBlock)(BOOL show);

@interface FMYYSDQDetailInfoCell : FMYTableViewCell


+ (CGFloat)cellHeightWithModel:(DQModel *)model;


@property (nonatomic, strong)DQModel *model;

- (void)cellEvent:(DQDetailCellBlock)thisBlock;

@end
