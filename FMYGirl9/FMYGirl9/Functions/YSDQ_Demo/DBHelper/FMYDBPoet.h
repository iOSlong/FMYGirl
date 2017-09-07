//
//  FMYDBPoet.h
//  FMYGirl9
//
//  Created by lxw on 2017/8/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYObject.h"
#import <LKDBHelper/LKDBHelper.h>

@interface FMYDBPoet : FMYObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL living;
@property (nonatomic, strong) NSString *time;
@end
