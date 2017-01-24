//
//  FMYLayoutConstraintViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/24.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYLayoutConstraintViewController.h"

@interface FMYLayoutConstraintViewController ()

@property (nonatomic) UIView *viewBottom;
@property (nonatomic) UIView *viewMidleTop;
@property (nonatomic) UIView *viewMidleBottom;
@property (nonatomic) UIView *viewTopLT;//左上
@property (nonatomic) UIView *viewTopRT;//右上
@property (nonatomic) UIView *viewTopLB;//下左
@property (nonatomic) UIView *viewTopMB;//下中
@property (nonatomic) UIView *viewTopRB;//下右

@end

@implementation FMYLayoutConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewBottom = [self viewWithColor:[UIColor redColor]];
    
    self.viewMidleTop       = [self viewWithColor:[UIColor yellowColor]];
    self.viewMidleBottom    = [self viewWithColor:[UIColor blueColor]];
    
    self.viewTopLB  = [self viewWithColor:[UIColor greenColor]];
    self.viewTopLT  = [self viewWithColor:[UIColor grayColor]];
    self.viewTopRT  = [self viewWithColor:[UIColor brownColor]];
    self.viewTopRB  = [self viewWithColor:[UIColor cyanColor]];
    self.viewTopMB  = [self viewWithColor:[UIColor magentaColor]];
    
    
    [self.view addSubview:self.viewBottom];
    [self.viewBottom layoutSpanBounds:FMYSpanMake(mySpanLeft, mySpanLeft, mySpanIn, 64)];
    
    [self.viewBottom addSubview:self.viewMidleTop];
    [self.viewBottom addSubview:self.viewMidleBottom];
    
    [self.viewMidleTop layoutAuthor:CGPointMake(mySpanLeft, mySpanLeft)];
    [self.viewMidleTop layoutRight:mySpanLeft];
    [self.viewMidleTop layoutHeight:100];
    
    [self.viewMidleBottom relation:NSLayoutRelationEqual toItem:self.viewMidleTop desAttribute:NSLayoutAttributeWidth toAttribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.viewMidleBottom relation:NSLayoutRelationEqual toItem:self.viewMidleTop desAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom multiplier:1 constant:mySpanLeft];
    [self.viewMidleBottom layoutBottom:mySpanLeft];
    [self.viewMidleBottom equalAttribute:NSLayoutAttributeCenterX toItem:self.viewMidleTop];
    
    
    [self.viewMidleBottom addSubview:self.viewTopLT];
    [self.viewMidleBottom addSubview:self.viewTopRT];
    [self.viewMidleBottom addSubview:self.viewTopLB];
    [self.viewMidleBottom addSubview:self.viewTopRB];
    [self.viewMidleBottom addSubview:self.viewTopMB];
    
    
    [self.viewTopLT layoutAuthor:CGPointMake(mySpanLeft, mySpanLeft)];
    [self.viewTopLT relation:NSLayoutRelationEqual toItem:self.viewMidleBottom desAttribute:NSLayoutAttributeWidth toAttribute:NSLayoutAttributeWidth multiplier:0.4 constant:1];
    [self.viewTopLT relation:NSLayoutRelationEqual toItem:self.viewMidleBottom desAttribute:NSLayoutAttributeHeight toAttribute:NSLayoutAttributeHeight multiplier:0.4 constant:1];
    
    
    
    [self.viewTopRT relation:NSLayoutRelationEqual toItem:self.viewTopLT desAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight multiplier:1 constant:mySpanIn];
    [self.viewTopRT layoutRight:mySpanLeft];
    [self.viewTopRT equalAttribute:NSLayoutAttributeTop toItem:self.viewTopLT];
    [self.viewTopRT equalAttribute:NSLayoutAttributeBottom toItem:self.viewTopLT];

    
    [self.viewTopLB equalAttribute:NSLayoutAttributeLeft toItem:self.viewTopLT];
    [self.viewTopLB relation:NSLayoutRelationEqual toItem:self.viewTopLT desAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom multiplier:1 constant:mySpanLeft];
    [self.viewTopLB layoutBottom:mySpanLeft];
    
    [self.viewTopMB equalAttribute:NSLayoutAttributeTop toItem:self.viewTopLB];
    [self.viewTopMB relation:NSLayoutRelationEqual toItem:self.viewTopLB desAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight multiplier:1 constant:mySpanIn];
    [self.viewTopMB equalAttribute:NSLayoutAttributeWidth toItem:self.viewTopLB];
    [self.viewTopMB equalAttribute:NSLayoutAttributeHeight toItem:self.viewTopLB];
    
    [self.viewTopRB equalAttribute:NSLayoutAttributeTop toItem:self.viewTopLB];
    [self.viewTopRB relation:NSLayoutRelationEqual toItem:self.viewTopMB desAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight multiplier:1 constant:mySpanIn];
    [self.viewTopRB equalAttribute:NSLayoutAttributeWidth toItem:self.viewTopLB];
    [self.viewTopRB equalAttribute:NSLayoutAttributeHeight toItem:self.viewTopLB];

    [self.viewTopRB layoutRight:mySpanLeft];
}



- (UIView *)viewWithColor:(UIColor *)color {
    UIView *view = [UIView new];
    view.backgroundColor = color;
    return view;
}


@end
