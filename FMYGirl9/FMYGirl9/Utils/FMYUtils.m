//
//  FMYUtils.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/4.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYUtils.h"

#define fmy_Post_DurationShort       1000
#define fmy_Post_DurationNormal      3000
#define fmy_Post_DurationLong        10000

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

+ (NSAttributedString *)attributesOfHODHint:(NSString *)hint{
    static NSDictionary *attributes;
    if (attributes == nil) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentCenter;
        paraStyle.lineSpacing = 6;
        attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                       NSParagraphStyleAttributeName:paraStyle,
                       NSKernAttributeName:@0.5f,
                       NSForegroundColorAttributeName:[UIColor whiteColor]
                       };
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:hint attributes:attributes];
    return attributeStr;
}



#pragma mark - HOD_POST_Show
+ (void)showHODAnimation:(BOOL)animated toView:(UIView *)view;{
    __block UIView *desView = view;
    __block BOOL blockEnableBackgroundInteraction = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil == desView) {
            desView = [UIApplication sharedApplication].keyWindow;
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:desView animated:animated];
        hud.userInteractionEnabled = blockEnableBackgroundInteraction;
    });
}

+ (void)removeHOD {
    [[UIApplication sharedApplication].keyWindow removeSubViewClass:[MBProgressHUD class]];
}
+ (void)showHint:(NSString *)hint hide:(CGFloat)delay {
    __block NSString *hintBlock = hint;
    __block BOOL blockEnableBackgroundInteraction = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        //TBLog(@"show hint loading");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        // 如果允许操作下面的view, 需要禁用 mb 本身的userInteraction.
        hud.userInteractionEnabled = !blockEnableBackgroundInteraction;
        [hud setRemoveFromSuperViewOnHide:YES];

        
#if 1
        [hud setMode:MBProgressHUDModeText];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = RGBACOLOR_HEX(0x000000, 0.7);
        hud.bezelView.layer.cornerRadius = 7;
        hud.detailsLabel.attributedText = [[self class] attributesOfHODHint:hintBlock];
        hud.offset = CGPointMake(hud.offset.x, hud.offset.y - 40);
#else
        hud.mode = MBProgressHUDModeCustomView;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        UILabel *newLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        newLable.numberOfLines = 0;
        newLable.textColor = [UIColor whiteColor];
        newLable.text = hint;
        hud.customView = newLable;
        hud.bezelView.color = RGBACOLOR_HEX(0x000000, 0.5);
        
//        hud.bezelView.alpha = 0.5;

#endif
        
        
        
        [hud hideAnimated:YES afterDelay:delay];
    });
}
+ (void)showHint:(NSString *)hint;
{
    [[FMYUtils class] showHint:hint hide:fmy_Post_DurationLong/1000];
}


@end




