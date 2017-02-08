//
//  NSObject+FMY.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/24.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "NSObject+FMY.h"
#import <objc/runtime.h>


@implementation NSObject (FMY)


- (NSArray *)fmyProperties {
    
    //    object_
    //    objc_
    //    class_
    //    ivar_
    
    unsigned int outCout = 0;
    
    Ivar *vars = class_copyIvarList([self class], &outCout); // 获取到所有的变量列表
    
    NSMutableArray *properties = [NSMutableArray array];

    for (int i = 0; i < outCout; i ++) {
        
        Ivar ivar = vars[i];
        
        const char *propertyName = ivar_getName(ivar);//变量名
        
        const char *propertyType = ivar_getTypeEncoding(ivar);//编码类型
        
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];
        
        NSDictionary *dict = @{@"name": name,
                               @"type": type};
        
        [properties addObject:dict];
    }
    
    return properties;
}

+ (NSArray *)fmyProperties;
{
    return [[self class] properties];
}

+ (NSArray *)properties {
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int outCout = 0;
    Ivar *vars = class_copyIvarList([self class], &outCout);
    
    for (int i = 0; i < outCout; i ++) {
        
        Ivar ivar = vars[i];
        
        const char *propertyName = ivar_getName(ivar);//变量名
        
        const char *propertyType = ivar_getTypeEncoding(ivar);//编码类型
        
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];
        
        NSDictionary *dict = @{@"name": name,
                               @"type": type};
        
        [properties addObject:dict];
    }
    
    return properties;
}


- (NSDictionary *)objToDict;
{
    NSArray *properties = [[self class] properties];
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    
    for (NSDictionary *pro in properties) {
        NSString *key = [[pro objectForKey:@"name"] substringFromIndex:1];
        if ([self valueForKey:key]) {
            [muDict setObject:[self valueForKey:key] forKey:key];
        }
    }
    return muDict;
}


// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict
{
    // 创建对应模型对象
    id objc = [[self alloc] init];
    
    
    unsigned int count = 0;
    
    // 1.获取成员属性数组
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 2.遍历所有的成员属性名,一个一个去字典中取出对应的value给模型属性赋值
    for (int i = 0; i < count; i++) {
        
        // 2.1 获取成员属性
        Ivar ivar = ivarList[i];
        
        // 2.2 获取成员属性名 C -> OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 2.3 _成员属性名 => 字典key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 2.4 去字典中取出对应value给模型属性赋值
        id value = dict[key];
        
        
        // 获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 二级转换,字典中还有字典,也需要把对应字典转换成模型
        //
        // 判断下value,是不是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) { //  是字典对象,并且属性名对应类型是自定义类型
            // user User
            
            // 处理类型字符串 @\"User\" -> User
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            // 自定义对象,并且值是字典
            // value:user字典 -> User模型
            // 获取模型(user)类对象
            Class modalClass = NSClassFromString(ivarType);
            
            // 字典转模型
            if (modalClass) {
                // 字典转模型 user
                value = [modalClass objectWithDict:value];
            }
            
            // 字典,user
            //            NSLog(@"%@",key);
        }
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf arrayContainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    // 字典转模型
                    id model =  [classModel objectWithDict:dict];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;
                
            }
        }
        
        // 2.5 KVC字典转模型
        if (value) {
            
            [objc setValue:value forKey:key];
        }
    }
    
    
    // 返回对象
    return objc;
}



@end
