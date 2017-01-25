//
//  FMYChinese+Lishanyin.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/25.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYChinese+Lishanyin.h"
#import <objc/runtime.h>

@implementation FMYChinese (Lishanyin)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(shangyinLi);
        Method oriMethod =  class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(liShangyin_jinse);
        Method cusMethod =  class_getInstanceMethod(selfClass, cusSEL);
        
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        
        if (addSucc)
        {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }
        else
        {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

- (NSString *)liShangyin_jinse {
    
    NSString *miss = [NSString stringWithUTF8String:lishangyin_miss()];
    NSLog(@"%@",miss);
    
    NSString *jinse = @"锦瑟无端五十弦,一弦一柱思华年。 庄生晓梦迷蝴蝶,望帝春心托杜鹃。 沧海月明珠有泪,蓝田日暖玉生烟。 此情可待成追忆?只是当时已惘然。";
    return jinse;
}


@end
