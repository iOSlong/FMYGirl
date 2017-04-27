//
//  FMYClangLLVMInfoViewController.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/27.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYViewController.h"

typedef NS_ENUM(NSUInteger, FMYInfoType) {
    FMYInfoTypeListView,
    FMYInfoTypeWebView,
    FMYInfoTypeInfoView,
};

@interface FMYClangLLVMInfoViewController : FMYViewController

@property (nonatomic, assign, readonly) FMYInfoType infoType;
@property (nonatomic, strong) NSString *webUrl;

- (instancetype)initWith:(FMYInfoType)infoType;

@end
