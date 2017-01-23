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

- (NSArray *)fmyProperties {
    NSMutableArray *properties = [NSMutableArray array];
    
//    object_
//    objc_
//    class_
//    ivar_
    
    unsigned int outCout = 0;
    Ivar *vars = class_copyIvarList([self class], &outCout);
    
    for (int i = 0; i < outCout; i ++) {
        
        Ivar ivar = vars[i];
        
        const char *propertyName = ivar_getName(ivar);//变量名
        
        const char *propertyType = ivar_getTypeEncoding(ivar);//编码类型
        
        NSString *name = [NSString stringWithUTF8String:propertyName];
    
        [properties addObject:name];
    }
    
    return properties;
}

+ (NSArray *)fmyProperties;
{
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int outCout = 0;
    Ivar *vars = class_copyIvarList([self class], &outCout);
    
    for (int i = 0; i < outCout; i ++) {
        
        Ivar ivar = vars[i];
        
        const char *propertyName = ivar_getName(ivar);//变量名
        
        const char *propertyType = ivar_getTypeEncoding(ivar);//编码类型
        
        NSString *name = [NSString stringWithUTF8String:propertyName];
        
        [properties addObject:name];
    }
    
    return properties;

}
@end
