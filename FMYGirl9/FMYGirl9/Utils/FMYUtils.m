//
//  FMYUtils.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYUtils.h"


const char * makeDictCachePath(const char *fullNameSpace)
{
    NSString *fullNS = [NSString stringWithUTF8String:fullNameSpace];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *desPath =  [paths[0] stringByAppendingPathComponent:fullNS];
    const char *cPath =  [desPath cStringUsingEncoding:NSUTF8StringEncoding];
    return cPath;
}


@implementation FMYUtils

+ (NSString *)pathOfDatabase {
    static NSString *path = nil;
    if (nil == path) {
        path = [[FMYUtils pathOfNameSpace] stringByAppendingPathComponent:CACHE_DISK_DATABASE];
    }
    return path;
}

+ (NSString *)pathOfNameSpace {
    static NSString *path = nil;
    if (nil == path) {
        const char *nameSpace = [CACHE_DISK_NAMESPACE cStringUsingEncoding:NSUTF8StringEncoding];
        path =  [NSString stringWithCString:makeDictCachePath(nameSpace) encoding:NSUTF8StringEncoding];
    }
    return path;
}



@end