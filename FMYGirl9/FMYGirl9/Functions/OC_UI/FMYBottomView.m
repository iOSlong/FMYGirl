//
//  FMYBottomView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/2/7.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYBottomView.h"
#import "AppDelegate.h"
#import <Masonry.h>

@implementation FMYBottomView

- (instancetype)initWithStyle:(FMYBottomStyle)style {
    self = [self initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    _style = style;
    if (self) {
        _imgvBackground = [self backImageViewWithGesture];
        [self addSubview:_imgvBackground];
        
        if (_style == FMYBottomViewStylePlat)
        {
            _imgvBackground.backgroundColor = [UIColor blackColor];
            _imgvBackground.alpha = 0.4;
        }
        else if (_style == FMYBottomViewStyleLucency)
        {
            _imgvBackground.backgroundColor = [UIColor cyanColor];
            _imgvBackground.alpha = 0.3;
        }
    }
    return self;
}

- (UIImageView *)backImageViewWithGesture {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    
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
            if (_style == FMYBottomViewStylePlat) {
                _imgvBackground.alpha = 0;
            }else{
                _imgvBackground.alpha = 0;
            }
            if (drawerView) {
                drawerView.center = CGPointMake(weakSelf.width * 0.5, weakSelf.height * 0.5);
            }
        } completion:^(BOOL finished) {
            NSLog(@"hidden");
            [weakSelf removeFromSuperview];
        }];
        
    }else{
        
        [self showWithConstraints];
        //        [self.nav.view addSubview:self];
        
        [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
            if (_style == FMYBottomViewStylePlat) {
                _imgvBackground.alpha = 0.70;
            }else{
                _imgvBackground.alpha = 0.3;
            }
            if (drawerView) {
                drawerView.center = CGPointMake(weakSelf.width * 0.5, weakSelf.height * 0.5);
            }
        } completion:^(BOOL finished) {
            NSLog(@"nohidden");
        }];
    }

}

- (void)showWithConstraints {
    UIViewController *topVC = [self appRootViewController];
    [topVC.view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.mas_top);
        make.left.equalTo(self.superview.mas_left);
        make.right.equalTo(self.superview.mas_right);
        make.bottom.equalTo(self.superview.mas_bottom);
    }];
    
    [_imgvBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
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
