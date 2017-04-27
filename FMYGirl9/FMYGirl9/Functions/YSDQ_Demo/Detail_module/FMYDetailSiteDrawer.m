//
//  FMYDetailSiteDrawer.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/7.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYDetailSiteDrawer.h"
#import <Masonry.h>
#import "FMYButton+FMY.h"

@implementation DQSiteViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgvSiteIcon   = [UIImageView new];
        
        _labelSite      = [UILabel new];
        _labelSite.font = [UIFont systemFontOfSize:13];
        _labelSite.textColor = RGBCOLOR_HEX(0x444444);
                
        
        _imgvSiteIcon.backgroundColor = [UIColor redColor];
        _labelSite.backgroundColor = [UIColor purpleColor];
        
        [self.contentView addSubview:_imgvSiteIcon];
        [self.contentView addSubview:_labelSite];
        
        
        [_imgvSiteIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(@20);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
        }];
        [_labelSite mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgvSiteIcon.mas_centerY);
            make.left.equalTo(_imgvSiteIcon.mas_right).offset(5);
            make.height.equalTo(@18);
        }];
        
        self.labelSite.text = @"乐视网";
        [self.labelSite sizeToFit];
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];

    }
    return self;
}

@end

///////////////////////////////////////////////////////

@interface FMYDetailSiteDrawer ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMYDetailSiteDrawer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUIItems];
    }
    return self;
}

- (void)configureUIItems {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _tableView.dataSource   = self;
    _tableView.delegate     = self;
    _tableView.bounces      = NO;
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor  = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:self.bounds];
    imgv.layer.borderColor  = [UIColor grayColor].CGColor;
    imgv.layer.borderWidth  = 1;
    _tableView.backgroundView = imgv;
    
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrSites.count;
}

- (DQSiteViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIDentifier = @"DQSiteViewCell";
    DQSiteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDentifier];
    if (!cell) {
        cell = [[DQSiteViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setArrSites:(NSArray *)arrSites {
    _arrSites = arrSites;
    if (arrSites.count) {
        self.tableView.height = arrSites.count * 44;
        [self.tableView reloadData];
    }
}

@end




