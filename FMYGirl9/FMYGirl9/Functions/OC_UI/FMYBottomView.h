//
//  FMYBottomView.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/7.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMYNavigationController.h"


typedef NS_ENUM(NSUInteger, FMYBottomStyle) {
    FMYBottomViewStylePlat,
};





@interface FMYBottomView : UIView

@property (nonatomic, strong) FMYNavigationController *nav;
@property (nonatomic, strong) UIImageView *imgvBackground;
@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, assign, readonly)FMYBottomStyle style;

- (instancetype)initWithStyle:(FMYBottomStyle)style;
- (void)setHidden:(BOOL)hidden;

@end
