//
//  FMYYSDQDetailInfoCell.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/5.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYYSDQDetailInfoCell.h"
#import <Masonry.h>


@interface FMYYSDQDetailInfoCell ()
@property (nonatomic, strong) UILabel *labelIntroduce;
@end

@implementation FMYYSDQDetailInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBACOLOR_HEX(0x999999, 0.6);
        [self configureUIItems];
    }
    return self;
}
- (void)configureUIItems {
    self.labelIntroduce = [UILabel new];
    self.labelIntroduce.numberOfLines = 0;
    self.labelIntroduce.font = [UIFont systemFontOfSize:11];
    self.labelIntroduce.textAlignment  = NSTextAlignmentLeft;
    self.labelIntroduce.backgroundColor = [UIColor cyanColor];
    
    [self.contentView addSubview:_labelIntroduce];
    
    [self.labelIntroduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@mySpanIn);
        make.left.equalTo(@mySpanLeft);
        make.width.equalTo(@myDisplayW);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(mySpanIn);
    }];
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[NSString class]]) {
        self.labelIntroduce.text = model;
    }
}

+ (CGFloat)cellHeightWithModel:(NSString *)string {

    CGSize size = [FMYUtils sizeFrom:[UIFont systemFontOfSize:11] andStr:string limitW:myDisplayW];
    
    return size.height + mySpanIn * 2;
}



@end
