//
//  AppDelegate.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "AppDelegate.h"
#import "FMYTabBarController.h"
#import "FMYNavigationController.h"

#import "FMYUITableViewController.h"
#import "FMYOCBaseViewController.h"
#import "FMYMediaViewController.h"
#import "FMYYSDQViewController.h"

#import <NetworkExtension/NEHotspotHelper.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface AppDelegate ()

@end

#define MyfineName   ({char *p = strchr(__FILE__,'/'); if (p) { p ++ ;}else {p = __FILE__ ;} p;})

@implementation AppDelegate

- (void)maroTest {
//    NSLog(@"%s",__is_identifier);
}

- (NSDictionary *)ssidInfo {
    NSString *ssid = @"Not Found";
    NSString *macIp = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
            ssid = [dict valueForKey:@"SSID"];
            macIp = [dict valueForKey:@"BSSID"];
        }
    }
    return nil;
}

- (NSDictionary*)SSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    
    NSDictionary *info = nil;
    
    for (NSString *ifnam in ifs) {
        
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            
            break;
            
        }
        
    }
    
    return info;
}

#define DefineParamCount(...) __VA_ARGS__
#define DefineParamN_Value(N,...) __VA_ARGS__

- (NSArray *)arrWithDepart:(NSString *)mark desStr:(NSString *)desString {
    NSArray *parts = [desString componentsSeparatedByString:@"&"];
    return parts;
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *urlimg_gif = @"apiversion=2&app=2.1.9&app_name=Shandian_ios&apprunid=c6339f940bad288ff48845ffcda4bef088fe139a_1496999908&auid=c6339f940bad288ff48845ffcda4bef088fe139a&city=CN_1_5_1&code=YmCvWEh2PdhpYNXO&ct=2&ctime=1496999997034&cur_url=details_1_10033652&idfa=A7EACEDD-FC11-41CB-A585-26ACD0A72463&ilu=0&install_id=c6339f940bad288ff48845ffcda4bef088fe139a&lc=9703FEF2-4928-44FD-A376-A04886AA8DBF&nt=wifi&p1=0&p2=0a1&p3=0a12&platform=Le123Plat005&plattype=iphone&r=101795744444&ref=details&sig=bcfd893fcba62bd303ff4affed6f34c3&stime=1496999997034&ts=1496999997035&uuid=c6339f940bad288ff48845ffcda4bef088fe139a&ver=3.7.3&version=2.1.9";
    NSString *urlTest_html = @"uuid=B0B9C8C4-9D3C-4178-9051-26B81FC1DC51&p1=0&app_name=Shandian_ios&p2=0a1&idfa=A7EACEDD-FC11-41CB-A585-26ACD0A72463&ct=2&ilu=0&lc=c6339f940bad288ff48845ffcda4bef088fe139a&p3=0a12&stime=1496999727852&r=103212448430&app=2.1.9&ctime=1496999727852&apprunid=c6339f940bad288ff48845ffcda4bef088fe139a_1496999726&ver=3.7.3&install_id=c6339f940bad288ff48845ffcda4bef088fe139a&nt=wifi&ref=home&auid=c6339f940bad288ff48845ffcda4bef088fe139a&version=2.1.9&ts=1496999997035%20&sig=bcfd893fcba62bd303ff4affed6f34c3&plattype=iphone&platform=Le123Plat005&cur_url=details_1_10033652&code=YmCvWEh2PdhpYNXO&city=CN_1_5_1";
    
    NSArray *arrImg_gif     = [self arrWithDepart:@"&" desStr:urlimg_gif];
    NSArray *arrTest_html   = [self arrWithDepart:@"&" desStr:urlTest_html];
    
    NSString *baseUrl = @"http://apple.www.leyingtt.com/pgv/?";
    NSString *testUrl1 = [arrImg_gif componentsJoinedByString:@"&"];
    testUrl1 = [baseUrl stringByAppendingString:testUrl1];
    
    NSString *testUrl2 = [arrTest_html componentsJoinedByString:@"&"];
    testUrl2 = [baseUrl stringByAppendingString:testUrl2];

    
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSString *partA in arrTest_html) {
        for (NSString *partB in arrImg_gif) {
            NSRange equealR = [partA rangeOfString:@"="];
            NSString *headA = [partA substringToIndex:equealR.location];
            
            if ([partB hasPrefix:headA]) {
                NSString *headB = [partB substringToIndex:equealR.location];
                
                if ([headA isEqualToString:headB]) {
                    [muArr addObject:partB];
                }
            }
        }
    }
    NSLog(@"%@",muArr);
    
    NSString *testUrl = [muArr componentsJoinedByString:@"&"];
    
    NSMutableArray *leaveArr = [NSMutableArray array];
    
    for (NSString *partY in arrImg_gif) {
        BOOL have = NO;
        for (NSString *partN in muArr) {
            if ([partN isEqualToString:partY]) {
                have = YES;
            }
        }
        if (have == NO) {
            [leaveArr addObject:partY];
        }
    }
    
    NSLog(@"%@",leaveArr);
    NSString *leaveStr = [leaveArr componentsJoinedByString:@"&"];
    
    
    
    
    
    
    
    NSLog(@"%s,%d",DefineParamCount(__FILE__,__LINE__));
    
    NSLog(@"%s,%d",DefineParamN_Value(2,__FILE__,__LINE__));
    

    FMYUITableViewController    *uiVC   = [FMYUITableViewController new];
    
    FMYOCBaseViewController     *baseVC = [FMYOCBaseViewController new];
    
    FMYMediaViewController      *mediaVC= [FMYMediaViewController new];
    
    FMYYSDQViewController       *ysdqVC = [FMYYSDQViewController new];
    
    FMYNavigationController *navBase    = [[FMYNavigationController alloc] initWithRootViewController:baseVC];
    FMYNavigationController *navUI      = [[FMYNavigationController alloc] initWithRootViewController:uiVC];
    FMYNavigationController *navMedia   = [[FMYNavigationController alloc] initWithRootViewController:mediaVC];
    FMYNavigationController *navYsdq    = [[FMYNavigationController alloc] initWithRootViewController:ysdqVC];

    uiVC.title      = @"UI";
    navUI.title     = @"UI";
    baseVC.title    = @"OCBase";
    navBase.title   = @"OCInfo";
    
    mediaVC.title   = @"media";
    navMedia.title  = @"media";
    
    ysdqVC.title    = @"YSDQ";
    navYsdq.title   = @"YSDQ";
    
    
    [self ssidInfo];
    [self SSIDInfo];
    
    
    FMYTabBarController *tabC = [[FMYTabBarController alloc] init];
    tabC.viewControllers = @[navUI,navBase,navMedia,navYsdq];
    
    
    self.window.rootViewController = tabC;
    [self.window makeKeyAndVisible];
    
//    char *p = strchr(__FILE__,'/'); if (p) {return p ;}else {return __FILE__ ;}
    
//    char *p = strchr(__FILE__,'/'); if (p) { p++ ;}else {p = __FILE__ ;}
//    char *p = strchr(__FILE__,'/'); if (p) { p++ ;}else {p = __FILE__ ;} p;
    
    NSLog(@"%s",MyfineName);
    
    

    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
