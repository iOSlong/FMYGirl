//
//  FMYBannnerView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/3/21.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYBannnerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation FMYBannerItem

@end


@interface FMYBannnerView ()<UIScrollViewDelegate>
@property (nonatomic) UIScrollView      *scrollView;
@property (nonatomic) UIPageControl     *pageControl;
@property (nonatomic) NSTimer           *timer;
@property (assign)    NSInteger         showIndex;
@property (nonatomic) UILabel           *labelInfo;
@property (nonatomic) NSMutableArray    *picUrlArr;
@end

@implementation FMYBannnerView {
    FMYBannerBlock _thisBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picUrlArr = [NSMutableArray array];
        [self setBaseUIItems];
    }
    return self;
}

- (void)setBaseUIItems {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self.scrollView layoutSpanBounds:FMYSpanMake(0, 0, 0, 0)];
    
    self.labelInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.width, 20)];
    self.labelInfo.centerY = self.height - 20;
    [self addSubview:self.labelInfo];
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
    self.pageControl.bottom = self.height;
    self.pageControl.tintColor = [UIColor redColor];
    [self addSubview:self.pageControl];
    
}


#pragma mark - Timer_About
- (void)timerWithItem:(FMYBannerItem *)item {
    NSNumber *index = [NSNumber numberWithInteger:[_bannelItems indexOfObject:item]];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:item.timeSpan target:self selector:@selector(timerEvent:) userInfo:@{@"index":index} repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent:(NSTimer *)timer {
    NSLog(@"%@",timer.userInfo);
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * (_showIndex + 1)  , 0) animated:YES];
    
    [self timerWithItem:_bannelItems[_showIndex - 1]];
}


- (void)setBannelItems:(NSArray *)bannelItems {
    _bannelItems = bannelItems;
    [self setContentFromItemArr:_bannelItems];
}

- (void)setContentFromItemArr:(NSArray *)items {
    [self.picUrlArr addObjectsFromArray:items];
    if (items.count > 1) {
        [self.picUrlArr addObject:[items firstObject]];
        [self.picUrlArr insertObject:[items lastObject] atIndex:0];
    }
    self.pageControl.numberOfPages  = items.count;
    self.pageControl.currentPage    = 0;
    
    if (self.picUrlArr.count) {
        CGFloat offsetMax = 0.0;
        for (int index = 0; index < _picUrlArr.count; index++) {
            UIImageView *imgv   = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
            imgv.contentMode    = UIViewContentModeScaleAspectFit;
            imgv.userInteractionEnabled = YES;
            imgv.tag    = index;
            imgv.left   = index * self.scrollView.width;

            [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgvTapClick:)]];
            FMYBannerItem *item = _picUrlArr[index];
            if (item.imgUrl){
                [imgv sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
            }
            
            [self.scrollView addSubview:imgv];
            
            offsetMax = imgv.right;
        }
        
        self.scrollView.contentSize = CGSizeMake(offsetMax, _scrollView.height);
        if (offsetMax > self.scrollView.width) {
            _showIndex = 1;
            [self.scrollView setContentOffset:CGPointMake(_scrollView.width * _showIndex, 0) animated:NO];
            [self timerWithItem:[_bannelItems firstObject]];
        }
        
    }
}

- (void)imgvTapClick:(UITapGestureRecognizer *)tapG {
    NSInteger index = tapG.view.tag;
    if (_thisBlock) {
        _thisBlock(index);
    }
}



#pragma mark - scrollViewDelegate
// 手动交互操作
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex     = (NSInteger)scrollView.contentOffset.x/(NSInteger)self.width;
    NSInteger scrollW       = self.scrollView.width;
    NSInteger pageCount     = self.picUrlArr.count;
    _showIndex    = pageIndex;
    if (pageIndex == 0 || pageIndex == pageCount - 1) {
        if (pageIndex == 0) {
            _showIndex = pageCount - 2;
        }else if (pageIndex == pageCount - 1) {
            _showIndex = 1;
        }
        [self.scrollView setContentOffset:CGPointMake(scrollW * _showIndex, 0) animated:NO];
    }
    
    self.pageControl.currentPage = _showIndex - 1;
    
    [self timerWithItem:_bannelItems[_showIndex - 1]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer setFireDate:[NSDate distantFuture]];
}

// 自动滑动操作
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger pageIndex     = (NSInteger)scrollView.contentOffset.x/(NSInteger)self.width;
    NSInteger scrollW       = self.scrollView.width;
    NSInteger pageCount     = self.picUrlArr.count;
    _showIndex    = pageIndex;
    if (pageIndex == 0 || pageIndex == pageCount - 1) {
        if (pageIndex == 0) {
            _showIndex = pageCount - 2;
        }else if (pageIndex == pageCount - 1) {
            _showIndex = 1;
        }
        [self.scrollView setContentOffset:CGPointMake(scrollW * _showIndex, 0) animated:NO];
    }
    
    self.pageControl.currentPage = _showIndex - 1;

}
- (void)bannerEvent:(FMYBannerBlock)bannerBlock {
    _thisBlock = bannerBlock;
}

@end
