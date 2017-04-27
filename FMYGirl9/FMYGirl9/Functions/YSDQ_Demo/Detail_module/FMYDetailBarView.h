//
//  FMYDetailBarView.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, DQDetailEvent) {
    DQDetailEventFaverClick,
    DQDetailEventShareClick,
    DQDetailEventDownloadClick,
    DQDetailEventSiteClick,
    DQDetailEventNone,
};

typedef void(^DQDetailBarBlock)(DQDetailEvent event);





@interface DQSiteView : UIView
@property (nonatomic, strong) UIImageView   *imgvSiteIcon;
@property (nonatomic, strong) UILabel       *labelSite;
@property (nonatomic, strong) FMYButton     *btnSiteAccessory;

@property (nonatomic, strong) NSString *siteInfo;

- (void)siteEvent:(DQDetailBarBlock)thisBlock;

@end





@interface FMYDetailBarView : UIView

@property (nonatomic, copy, readonly)DQDetailBarBlock detailBarBlock;

- (void)detailBarEvent:(DQDetailBarBlock)thisBlock;


@end
