//
//  FMYViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface FMYViewController ()

@end

@implementation FMYViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    

}

- (void)showHint:(NSString *)hint hide:(CGFloat)delay{
    __block NSString *hintBlock = hint;
    __block BOOL blockEnableBackgroundInteraction = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        //TBLog(@"show hint loading");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        // 如果允许操作下面的view, 需要禁用 mb 本身的userInteraction.
        hud.userInteractionEnabled = !blockEnableBackgroundInteraction;
        [hud.detailsLabel setFont:[UIFont systemFontOfSize:15 ]];
        [hud setRemoveFromSuperViewOnHide:YES];
        [hud setMode:MBProgressHUDModeText];
        [hud.detailsLabel setText:hintBlock];
        [hud hideAnimated:YES afterDelay:delay];
        hud.center = CGPointMake(hud.center.x, 200);
    });
}




@end
