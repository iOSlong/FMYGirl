//
//  FMYBottomView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/7.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYBottomView.h"
#import "AppDelegate.h"

@implementation FMYBottomView

- (instancetype)initWithStyle:(FMYBottomStyle)style {
    self = [self initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    _style = style;
    if (self) {
        self.imgvBackground = [self backImageViewWithGesture];
        [self addSubview:self.imgvBackground];
        if (_style == FMYBottomViewStylePlat) {
            
        }
    }
    return self;
}

- (UIImageView *)backImageViewWithGesture {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.backgroundColor = [UIColor blackColor];
    
    imageView.alpha = 0.4;
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)]];
    
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeEvent:)];
    swipeGR.direction = UISwipeGestureRecognizerDirectionDown|UISwipeGestureRecognizerDirectionUp;
    [imageView addGestureRecognizer:swipeGR];
    return imageView;
}

- (void)swipeEvent:(UISwipeGestureRecognizer *)swipeGR{
    NSLog(@"%lu",swipeGR.direction);
    [self setHidden:YES];
}
- (void)tapEvent {
    [self setHidden:YES];
}

- (void)setCenterView:(UIView *)centerView {
    if (_centerView) {
        [_centerView removeFromSuperview];
    }
    _centerView = centerView;
    [self addSubview:_centerView];
}


- (void)setHidden:(BOOL)hidden
{
    weakSelf();
    self.alpha = 1;

    UIView *drawerView = nil;
    if (self.style == FMYBottomViewStylePlat) {
        drawerView = self.centerView;
    }
    
    if (hidden) {
//        self.viewAccessory.top = SCREENH;
        [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
            self.imgvBackground.alpha = 0;
            if (drawerView) {
                drawerView.center = CGPointMake(weakSelf.width * 0.5, weakSelf.height * 0.5);
            }
        } completion:^(BOOL finished) {
            NSLog(@"hidden");
            [weakSelf removeFromSuperview];
        }];
        
    }else{
        
        UIViewController *topVC = [self appRootViewController];
        [topVC.view addSubview:self];
        //        [self.nav.view addSubview:self];
        
        [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
            self.imgvBackground.alpha = 0.70;
            if (drawerView) {
                drawerView.center = CGPointMake(weakSelf.width * 0.5, weakSelf.height * 0.5);
            }
        } completion:^(BOOL finished) {
            NSLog(@"nohidden");
        }];
    }

}


- (UIViewController *)appRootViewController
{
    //    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    //    return window.rootViewController;
#if 1
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
#endif
    
}




@end
