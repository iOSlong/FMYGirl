//
//  FMYMovie.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/25.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYObject.h"
#import "FMYPerson.h"
#import "NSObject+FMY.h"

//1. 如果想要当前类可以实现归档与反归档，需要遵守一个协议NSCoding
@interface FMYMovie : FMYObject<NSCoding, ModelDelegate>

@property (nonatomic, strong) FMYPerson * user;
@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *pic_url;



@end
