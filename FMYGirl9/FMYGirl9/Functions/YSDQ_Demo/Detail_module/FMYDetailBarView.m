//
//  FMYDetailBarView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDetailBarView.h"
#import "FMYButton+FMY.h"
#import <Masonry.h>




@implementation DQSiteView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgvSiteIcon   = [UIImageView new];
        
        _labelSite      = [UILabel new];
        _labelSite.font = [UIFont systemFontOfSize:13];
        _labelSite.textColor = RGBCOLOR_HEX(0x444444);
        
        _imgvSiteAccessory = [UIImageView new];
        
        _imgvSiteAccessory.image = [UIImage imageNamed:@"半屏下展开icon"];
        
        _imgvSiteIcon.backgroundColor = [UIColor redColor];
        _labelSite.backgroundColor = [UIColor purpleColor];
        
        [self addSubview:_imgvSiteIcon];
        [self addSubview:_labelSite];
        [self addSubview:_imgvSiteAccessory];

        
        [_imgvSiteIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@1);
            make.left.equalTo(@0);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
        }];
        [_labelSite mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgvSiteIcon.mas_centerY);
            make.left.equalTo(_imgvSiteIcon.mas_right).offset(5);
            make.height.equalTo(@18);
        }];
        [_imgvSiteAccessory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgvSiteIcon.mas_centerY);
            make.left.equalTo(_labelSite.mas_right).offset(5);
            make.width.equalTo(@13);
            make.height.equalTo(@7);
        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_imgvSiteAccessory.mas_right).offset(5);
        }];
        
    }
    return self;
}

- (void)setSiteInfo:(NSString *)siteInfo {
    _siteInfo = siteInfo;
    if (siteInfo) {
        self.labelSite.text = siteInfo;
        [self.labelSite sizeToFit];
    }
}

@end



////////////////////////////////////////////////
@interface FMYDetailBarView ()

@property (nonatomic, strong) DQSiteView        *viewSite;

@property (nonatomic, strong) FMYButton      *btnFaver;
@property (nonatomic, strong) FMYButton      *btnShare;
@property (nonatomic, strong) FMYButton      *btnDownload;

@end

@implementation FMYDetailBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUIItems];
    }
    return self;
}

- (void)configureUIItems {
    self.backgroundColor = RGBACOLOR_HEX(0x888888, 0.3);
    
    self.frame = CGRectMake(0, 0, SCREENW, 49);
    
    
    
    _viewSite = [DQSiteView new];
    _viewSite.backgroundColor = [UIColor grayColor];
    _viewSite.siteInfo = @"乐视网";
    [self addSubview:_viewSite];
    
    [_viewSite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@10);
        make.height.equalTo(@22);
    }];
    
   
    
    
    
    ////  收藏， 分享， 下载，
    _btnFaver   = [FMYButton ysdqBarBtnSelected:@"收藏成功" imgNormal:@"收藏默认" imgHighlight:@"收藏点击态" target:self action:@selector(btnClick:)];
    _btnShare   = [FMYButton ysdqBarBtnSelected:@"分享点击" imgNormal:@"分享icon" imgHighlight:nil target:self action:@selector(btnClick:)];
    _btnDownload   = [FMYButton ysdqBarBtnSelected:@"下载点击icon" imgNormal:@"下载默认icon" imgHighlight:@"下载不可以用icon" target:self action:@selector(btnClick:)];
    
    [self addSubview:_btnFaver];
    [self addSubview:_btnShare];
    [self addSubview:_btnDownload];
    
    [_btnDownload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.right.equalTo(_btnDownload.mas_left).offset(-25);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_btnFaver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.right.equalTo(_btnShare.mas_left).offset(-25);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
}

- (void)btnClick:(FMYButton *)sender {

    DQDetailEvent event = DQDetailEventNone;
    
    if (sender == _btnFaver) {
        event = DQDetailEventFaverClick;
    }else if (sender == _btnShare) {
        event = DQDetailEventShareClick;
    }else if (sender == _btnDownload) {
        event = DQDetailEventDownloadClick;
    }

    if (_detailBarBlock) {
        _detailBarBlock(event);
    }
    sender.selected = !sender.selected;
}

- (void)detailBarEvent:(DQDetailBarBlock)thisBlock {
    _detailBarBlock = thisBlock;
}

@end
