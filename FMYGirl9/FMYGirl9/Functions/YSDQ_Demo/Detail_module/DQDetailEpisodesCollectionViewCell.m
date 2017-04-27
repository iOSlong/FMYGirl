//
//  DQDetailEpisodesCollectionViewCell.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/11.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "DQDetailEpisodesCollectionViewCell.h"
#import <Masonry.h>

@implementation DQDetailEpisodesCollectionViewCell {
    DQEpisodesCellBlock _ECBlock;
}
- (void)cellEpisodesEvent:(DQEpisodesCellBlock)thisBlock {
    _ECBlock = thisBlock;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = RGBCOLOR_HEX(0xF6F6F6);
        self.contentView.layer.cornerRadius = 2;
        
        _btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTitle.frame = self.bounds;
        [_btnTitle setTitleColor:RGBCOLOR_HEX(0x444444) forState:UIControlStateNormal];
        [_btnTitle setTitleColor:RGBCOLOR_HEX(0xF44343) forState:UIControlStateSelected];
        [_btnTitle.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:15]];
        [_btnTitle setTitle:@"321" forState:UIControlStateNormal];
        [_btnTitle addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _imgvMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _imgvMark.contentMode = UIViewContentModeScaleAspectFill;
        [_imgvMark setImage:[UIImage imageNamed:@"半屏选集完成下载icon"]];
        
        [self.contentView addSubview:_btnTitle];
        [self.contentView addSubview:_imgvMark];
        
        [_btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(self.contentView.mas_width);
            make.height.equalTo(self.contentView.mas_height);
        }];
        
        [_imgvMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-4);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-4);
        }];
        
    }
    return self;
}

- (void)btnTitleClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (_ECBlock) {
        _ECBlock(btn.titleLabel.text);
    }
}

- (void)setState:(DQEpisodeState)state {
    _state = state;
    [_imgvMark setHidden:NO];
    if (_state == DQEpisodeStateDownloading) {
        [_imgvMark setImage:[UIImage imageNamed:@"半屏选集下载icon"]];

    }else if (_state == DQEpisodeStateDownloaded) {
        [_imgvMark setImage:[UIImage imageNamed:@"半屏选集完成下载icon"]];

    }else if (_state == DQEpisodeStateNormal) {
        [_imgvMark setHidden:YES];
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    _btnTitle.selected = isSelected;
}

- (void)setCellitem:(id)cellitem {
    _cellitem = cellitem;
    if ([cellitem isKindOfClass:[NSString class]]) {
        [_btnTitle setTitle:cellitem forState:UIControlStateNormal];
    }
}

@end
