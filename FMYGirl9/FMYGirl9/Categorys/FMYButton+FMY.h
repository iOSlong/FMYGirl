//
//  FMYButton+FMY.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/6.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYButton.h"

@interface FMYButton (FMY)

+ (instancetype)buttonFrame:(CGRect)frame imgSelected:(NSString *)imgSelected imgNormal:(NSString *)imgNormal imgHighlight:(NSString *)imgHighlight target:(id)target action:(SEL)action mode:(UIViewContentMode)mode ContentEdgeInsets:(UIEdgeInsets)insets;

+ (instancetype)ysdqBarBtnSelected:(NSString *)imgSelected imgNormal:(NSString *)imgNormal imgHighlight:(NSString *)imgHighlight target:(id)target action:(SEL)action;


@end
