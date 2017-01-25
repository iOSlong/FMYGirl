//
//  FMYObject.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYObject.h"
#import <objc/runtime.h>      //需要引入库

@implementation FMYObject

char * lishangyin_miss()
{
    return "相见时难别亦难，东风无力百花残。春蚕到死丝方尽，蜡炬成灰泪始干。晓镜但愁云鬓改，夜吟应觉月光寒。蓬山此去无多路，青鸟殷勤为探看";
}

- (NSString *)shangyinLi {
    NSString *noTitle = [NSString stringWithUTF8String:lishangyin_miss()];
    return noTitle;
}




@end
