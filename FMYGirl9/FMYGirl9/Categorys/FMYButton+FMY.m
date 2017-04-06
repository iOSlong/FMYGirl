//
//  FMYButton+FMY.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/6.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYButton+FMY.h"

@implementation FMYButton (FMY)

+ (instancetype)buttonFrame:(CGRect)frame imgSelected:(NSString *)imgSelected imgNormal:(NSString *)imgNormal imgHighlight:(NSString *)imgHighlight target:(id)target action:(SEL)action mode:(UIViewContentMode)mode ContentEdgeInsets:(UIEdgeInsets)insets;
{
    FMYButton *btn = [FMYButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgSelected] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgHighlight] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:frame];
    [btn setContentEdgeInsets:insets];
    [btn.imageView setContentMode:mode];
    
    return btn;
}

//  收藏， 分享， 下载，


+ (instancetype)ysdqBarBtnSelected:(NSString *)imgSelected imgNormal:(NSString *)imgNormal imgHighlight:(NSString *)imgHighlight target:(id)target action:(SEL)action {
    CGRect rect = {{0,0},{20,20}} ;
    return [FMYButton buttonFrame:rect imgSelected:imgSelected imgNormal:imgNormal imgHighlight:imgHighlight target:target action:action mode:UIViewContentModeScaleAspectFit ContentEdgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
}


@end
