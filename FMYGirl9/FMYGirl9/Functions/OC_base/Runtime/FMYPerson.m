//
//  FMYPerson.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYPerson.h"

@implementation FMYPerson




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



@end
