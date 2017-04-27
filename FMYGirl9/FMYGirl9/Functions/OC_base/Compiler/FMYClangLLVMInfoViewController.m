//
//  FMYClangLLVMInfoViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/27.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYClangLLVMInfoViewController.h"
#import <WebKit/WebKit.h>

@interface FMYClangLLVMInfoViewController ()<UITableViewDelegate, UITableViewDataSource,
WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView     *webView;
@property (nonatomic, strong) FMYTableView  *tableView;
@property (nonatomic, strong) NSArray       *arrDiagnotisc;
@property (nonatomic, strong) UILabel       *labelInfo;
@end

@implementation FMYClangLLVMInfoViewController

- (UILabel *)labelInfo {
    if (!_labelInfo) {
        _labelInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 200)];
        _labelInfo.adjustsFontSizeToFitWidth = YES;
        _labelInfo.textAlignment = NSTextAlignmentCenter;
        _labelInfo.textColor = RandomColor;
    }
    return _labelInfo;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[WKWebViewConfiguration new]];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (FMYTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FMYTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
        [_tableView registerClass:[FMYTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FMYTableViewCell class])];
    }
    return _tableView;
}

- (instancetype)initWith:(FMYInfoType)infoType {
    self = [super init];
    _infoType = infoType;
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (_infoType == FMYInfoTypeWebView)
    {
        [self.view addSubview:self.webView];
        NSAssert(self.webUrl, @"webUrl can't be null!");
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }
    else if (_infoType == FMYInfoTypeListView)
    {
        self.arrDiagnotisc = @[@"Ignored",
                               @"Note",
                               @"Remark",
                               @"Warning",
                               @"Error",
                               @"Fatal"];
        self.labelInfo.text = @"All diagnostics are mapped into one of these 6 classes:";
        [self.labelInfo sizeToFit];
        self.tableView.tableHeaderView = self.labelInfo;
        [self.view addSubview:self.tableView];
    }
    else if (_infoType == FMYInfoTypeInfoView)
    {
        
    }
}

#pragma GCC diagnostic ignored "-Wall"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDiagnotisc.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FMYTableViewCell class])];
    cell.textLabel.text = self.arrDiagnotisc[indexPath.row];
    return cell;
}



@end
