//
//  FMYDetailSiteDrawer.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/7.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface  DQSiteViewCell: UITableViewCell

@property (nonatomic, strong) UIImageView   *imgvSiteIcon;
@property (nonatomic, strong) UILabel       *labelSite;

@end


@interface FMYDetailSiteDrawer : UIView

@property (nonatomic, strong) NSArray *arrSites;

@end
