//
//  FMYDetailBarView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDetailBarView.h"

@implementation FMYDetailBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUIItems];
    }
    return self;
}

- (void)configureUIItems {
    self.backgroundColor = RGBACOLOR_HEX(0x888888, 0.3);
    
    self.frame = CGRectMake(0, 0, SCREENW, 49);
}

@end
