//
//  FMYMovie.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/25.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYMovie.h"
#import <objc/runtime.h>

@implementation FMYMovie

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([FMYMovie class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
        
    }
    
    free(ivars);

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([FMYMovie class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [coder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
            
        }
        free(ivars);

    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@", _movieName, _movieId, _pic_url, _user];
}


@end
