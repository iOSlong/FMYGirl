//
//  FMYConstantUI.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/22.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#ifndef FMYConstantUI_h
#define FMYConstantUI_h


#pragma mark -   颜色相关

// Color helpers
#define RGBCOLOR(r,g,b)                                     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)                                  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RGBCOLOR_HEX(h)                                     RGBCOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF))
#define RGBACOLOR_HEX(h,a)                                  RGBACOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF), (a))
#define RGBPureColor(h)                                     RGBCOLOR(h, h, h)
#define HSVCOLOR(h,s,v)                                     [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a)                                  [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]
#define RGBA(r,g,b,a)                                       (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

//随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

//rgb 十六进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#pragma mark - 尺寸相关

// 屏幕的bounds
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
//屏幕宽度
#define SCREENW [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREENH [UIScreen mainScreen].bounds.size.height

/// 设计图纸尺寸比例
#define myRATIO  (SCREENH/667.0)

// 抽屉的宽度

#define mySpanLeft      (10 * myRATIO)
#define mySpanIn        (mySpanLeft/2)
#define myDisplayW      (SCREENW - 2 * mySpanLeft)
#define myDisplayH      (SCREENH - 2 * mySpanIn)



#endif /* FMYConstantUI_h */
