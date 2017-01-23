//
//  UIView+NSLayout.h
//  XWJSC
//
//  Created by xuewu.long on 16/12/13.
//  Copyright © 2016年 fmylove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct FMYSpan {
    CGFloat spanLeft;
    CGFloat spanRight;
    CGFloat spanTop;
    CGFloat spanBottom;
}FMYSpan;

extern FMYSpan FMYSpanMake(CGFloat x, CGFloat y, CGFloat top, CGFloat bottom);

FMYSpan spanZero();

/*
 FMYSpanMake
 必须要将 实现部分转移到.m 文件中， 否者这个地方在变异的时候会出现报错：
 ld: 18 duplicate symbols for architecture x86_64
 clang: error: linker command failed with exit code 1 (use -v to see invocation)
 */
//FMYSpan spanZero() {
//    return FMYSpanMake(0, 0, 0, 0);
//}


@interface UIView (NSLayout)

#pragma mark base set
- (void)layoutWidth:(CGFloat)width;
- (void)layoutHeight:(CGFloat)height;
- (void)layoutTop:(CGFloat)top;
- (void)layoutLeft:(CGFloat)left;
- (void)layoutRight:(CGFloat)right;
- (void)layoutBottom:(CGFloat)bottom;

- (void)layoutCenterX:(CGFloat)centerX;
- (void)layoutCenterY:(CGFloat)centerY;
- (void)layoutCenter ;

- (void)layoutSpanBounds:(FMYSpan)span;


#pragma mark  two-dimension set
- (void)layoutSize:(CGSize)size;
- (void)layoutAuthor:(CGPoint)point;


#pragma mark relation dimension set
- (void)relation:(NSLayoutRelation)relation
          toItem:(nullable UIView *)toView
    desAttribute:(NSLayoutAttribute)desAttri
     toAttribute:(NSLayoutAttribute)toAttri
      multiplier:(CGFloat)multiplier
        constant:(CGFloat)constant;

- (void)leftSpan:(CGFloat)spanH toItem:(UIView * _Nonnull)toView;
- (void)rightSpan:(CGFloat)spanH toItem:(UIView * _Nonnull)toView;
- (void)topSpan:(CGFloat)spanV toItem:(UIView * _Nonnull)toView;
- (void)bottomSpan:(CGFloat)spanV toItem:(UIView * _Nonnull)toView;

- (void)equalAttribute:(NSLayoutAttribute)attribute toItem:(UIView * _Nonnull)toView;


/*
 约束的大量叠加使用，is not a good ideal
 这里只是为了掩饰怎么使用约束。
 */

@end
