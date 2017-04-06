//
//  FMYYSDQDetailInfoCell.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYYSDQDetailInfoCell.h"
#import <Masonry.h>
#import "FMYButton+FMY.h"



@implementation DQModel
@end



@interface FMYYSDQDetailInfoCell ()
@property (nonatomic, strong) FMYButton  *btnArrow;
@property (nonatomic, strong) UILabel   *labelName;
@property (nonatomic, strong) UILabel   *labelSubInfo;
@property (nonatomic, strong) UILabel   *labelActors;
@property (nonatomic, strong) UILabel   *labelDirectors;
@property (nonatomic, strong) UILabel   *labelType;
@property (nonatomic, strong) UILabel   *labelIntroduce;
@end

@implementation FMYYSDQDetailInfoCell{
    DQDetailCellBlock _cellBlock;
}

- (void)cellEvent:(DQDetailCellBlock)thisBlock;
{
    _cellBlock = thisBlock;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.clipsToBounds = YES;
        [self configureUIItems];
    }
    return self;
}

- (void)showBtnClick:(FMYButton *)btn {
    btn.selected = !btn.selected;
    if (_cellBlock) {
        _cellBlock(btn.selected);
    }
}

- (void)configureUIItems {
    
    //// 展开按钮
    CGRect rectBtn = {{0,0},{30,30}};
    _btnArrow = [FMYButton buttonFrame:rectBtn imgSelected:@"半屏收起icon" imgNormal:@"半屏下展开icon" imgHighlight:nil target:self action:@selector(showBtnClick:) mode:UIViewContentModeScaleAspectFill ContentEdgeInsets:UIEdgeInsetsMake(11, 7, 11, 7)];
    _btnArrow.top   = 10;
    _btnArrow.right = SCREENW - 10;
    
    [self.contentView addSubview:_btnArrow];
    
    
    
    
    /// 片名， 评分 发布等附属信息， 主演， 导演， 类型， 详情，
    _labelName = [UILabel new];
    _labelName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    _labelName.textColor = RGBCOLOR_HEX(0x222222);
    
    _labelSubInfo   = [self labelDetailInfo];
    _labelActors    = [self labelDetailInfo];
    _labelDirectors = [self labelDetailInfo];
    _labelType      = [self labelDetailInfo];
    
    
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelSubInfo];
    [self.contentView addSubview:_labelActors];
    [self.contentView addSubview:_labelDirectors];
    [self.contentView addSubview:_labelType];
    
    
    
    _labelIntroduce = [UILabel new];
    _labelIntroduce.numberOfLines = 0;
    _labelIntroduce.backgroundColor = [UIColor cyanColor];
    
    [self.contentView addSubview:_labelIntroduce];
    
    
    _labelName.top  = 5;
    _labelName.left = 10;
    
    [self configureConstraints];
    
}

- (void)configureConstraints {
    [_labelSubInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelName.mas_left);
        make.top.equalTo(_labelName.mas_bottom).offset(10);
    }];
    
    [_labelActors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelName.mas_left);
        make.top.equalTo(_labelSubInfo.mas_bottom).offset(25);
        make.width.equalTo(@myDisplayW);
    }];
    
    [_labelDirectors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelName.mas_left);
        make.top.equalTo(_labelActors.mas_bottom).offset(12);
        make.width.equalTo(@myDisplayW);
    }];
    
    [_labelType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelName.mas_left);
        make.top.equalTo(_labelDirectors.mas_bottom).offset(12);
        make.width.equalTo(@myDisplayW);
    }];
    
    
    [self.labelIntroduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelType.mas_bottom).offset(20);
        make.left.equalTo(_labelName.mas_left);
        make.width.equalTo(@myDisplayW);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(mySpanIn);
    }];
}

- (UILabel *)labelDetailInfo {
    UILabel *label = [UILabel new];
    label.font          = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    label.textColor     = RGBCOLOR_HEX(0x666666);
    label.numberOfLines = 0;
    return label;
}

- (void)setModel:(DQModel *)model {
    _model = model;
    self.labelIntroduce.attributedText = [FMYUtils showAttributedFrom:model.showInfo];
    _labelName.text     = @"28岁未成年 电影";
    _labelSubInfo.text  = @"2016‘9.2.大陆 爱情";
    _labelActors.text   = @"演员：卡梅隆·洁儿，洛夫斯基";
    _labelDirectors.text= @"导演：尤玉林";
    _labelType.text     = @"类型：科幻悬疑";
    
    _btnArrow.selected = model.show;
    if (model.show) {
//        _labelActors.alpha      = 1;
//        _labelDirectors.alpha   = 1;
        _labelType.alpha        = 1;
        _labelIntroduce.alpha   = 1;
    }else{
        [UIView animateWithDuration:0.25 animations:^{
//            _labelActors.alpha      = 0;
//            _labelDirectors.alpha   = 0;
            _labelType.alpha        = 0;
            _labelIntroduce.alpha   = 0;
        }completion:^(BOOL finished) {

        }];
    }
}

+ (CGFloat)cellHeightWithModel:(DQModel *)model {
    if (model.show) {
        CGSize size = [FMYUtils sizeFrom:[UIFont systemFontOfSize:13] andStr:model.showInfo limitW:myDisplayW];
        return size.height + mySpanIn * 2 + 100;
    }else{
        return 100;
    }
}



@end
