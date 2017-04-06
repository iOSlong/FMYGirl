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

@implementation AppDelegate

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
