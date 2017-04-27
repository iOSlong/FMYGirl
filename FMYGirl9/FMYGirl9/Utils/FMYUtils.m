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

+ (FMYUtils *)sharedFMYUtils {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}


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


+ (NSArray *)fileGetNewsItems;
{
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fmywplist" ofType:@"plist"]];
    NSArray *newsItems = [plist objectForKey:@"newsItem"];
    return newsItems;
}



+ (NSAttributedString *)showAttributedFrom:(NSString *)string {

    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:[FMYUtils attributesOfText_DedailInfo]];
    return attributeStr;
}


+ (NSDictionary *)attributesOfText_DedailInfo {
    static NSDictionary *attributes;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 22; //行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //字间距 NSKernAttributeName:@0.5f
    attributes = @{NSFontAttributeName:DQ_FONT_DETAIL_13,
                   NSParagraphStyleAttributeName:paraStyle,
                   NSKernAttributeName:@0.5f
                   };
    return attributes;
}

+ (CGSize)sizeFrom:(NSString *)text attributes:(NSDictionary *)attributes limitW:(CGFloat)maxW{
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil].size;
    return size;
}

+ (NSAttributedString *)stringAttributed:(NSDictionary *)attributes fromStr:(NSString *)text {
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attributeStr;
}


@end




