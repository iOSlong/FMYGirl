//
//  FMYBannnerView.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/3/21.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMYBannerItem : FMYObject

@property (nonatomic) NSString *imgUrl;
@property (nonatomic) NSTimeInterval timeSpan;
@end


typedef void(^FMYBannerBlock)(NSInteger index);

@interface FMYBannnerView : UIView

@property (nonatomic, strong)NSArray *bannelItems;

- (void)bannerEvent:(FMYBannerBlock)bannerBlock;

@end
