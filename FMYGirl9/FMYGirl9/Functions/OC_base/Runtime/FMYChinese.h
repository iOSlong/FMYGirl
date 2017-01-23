//
//  FMYChinese.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/23.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYPerson.h"

@interface FMYChinese : FMYPerson

@property NSString *province;
@property NSString *politicsStatus;
@property FMYPerson *father;
@property FMYPerson *mother;
@property NSArray *children;

@end
