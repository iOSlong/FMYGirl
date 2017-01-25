//
//  NSObject+FMY.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/24.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ModelDelegate <NSObject>

@optional
// 提供一个协议，只要准备这个协议的类，都能把数组中的字典转模型
//用在三级数组转换
+ (NSDictionary *)arrayContainModelClass;


@end



@interface NSObject (FMY)

- (NSArray *)fmyProperties;
+ (NSArray *)fmyProperties;


// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict;

@end
