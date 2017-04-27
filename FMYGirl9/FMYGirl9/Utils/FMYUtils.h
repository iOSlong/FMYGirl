//
//  FMYUtils.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYObject.h"

#define DQ_FONT_DETAIL_13  [UIFont fontWithName:@"PingFangSC-Regular" size:13]
#define DQ_FONT_DETAIL_18  [UIFont fontWithName:@"PingFangSC-Medium" size:18]

#define DQ_COLOR_DETAIL_TITLE   RGBCOLOR_HEX(0x222222)
#define DQ_COLOR_DEFAIL_DESC    RGBCOLOR_HEX(0x666666)


const char * makeDictCachePath(const char *fullNameSpace);

@interface FMYUtils : FMYObject

+ (FMYUtils *)sharedFMYUtils;
@property (nonatomic, assign) CGPoint localP;




+ (NSString *)pathOfNameSpace;
+ (NSString *)pathOfDatabase;


+ (NSArray *)fileGetNewsItems;


+ (NSAttributedString *)showAttributedFrom:(NSString *)string;

+ (CGSize)sizeFrom:(NSString *)text attributes:(NSDictionary *)attributes limitW:(CGFloat)maxW;

/// 默认详情页面信息展示的
+ (NSDictionary *)attributesOfText_DedailInfo;


+ (NSAttributedString *)stringAttributed:(NSDictionary *)attributes fromStr:(NSString *)text;


@end
