//
//  FMYPerson.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYPerson.h"

@implementation FMYPerson {
    NSArray *_nameArr;
    NSArray *_sexArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nameArr = @[@"马小欣",
                     @"马左冰",
                     @"木夕凤",
                     @"夕林儿",
                     @"王采薇",
                     @"玉琼",
                     @"瑶冰玲",
                     @"舞心碟",@"兑小悉"];
        
        _sexArr = @[@"boy",@"girl"];
    }
    return self;
}


- (void)sayName;{
    NSLog(@"my name is %@",self.name);
}
- (void)saySex;{
    if (self.sex) {
        NSLog(@"i am a %@",[self.sex integerValue] ? @"boy" : @"girl");
    }else{
        NSLog(@"i am not sure about this!");
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"person:%@, age:%@, ID:%@",self.name,self.age,self.ID];
}

- (void)randomValue {
    self.name = [_nameArr objectAtIndex:arc4random()%_nameArr.count];
    self.sex  = [_sexArr objectAtIndex:arc4random()%2];
    self.ID   = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    self.age  = [NSNumber numberWithInteger:arc4random()%520 + 24];
}


@end
