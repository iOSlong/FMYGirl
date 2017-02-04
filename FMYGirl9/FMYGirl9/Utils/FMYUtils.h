//
//  FMYUtils.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYObject.h"


const char * makeDictCachePath(const char *fullNameSpace);

@interface FMYUtils : FMYObject

+ (NSString *)pathOfNameSpace;
+ (NSString *)pathOfDatabase;




@end
