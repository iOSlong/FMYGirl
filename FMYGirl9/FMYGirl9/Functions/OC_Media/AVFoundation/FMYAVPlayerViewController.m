//
//  FMYAVPlayerViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/1.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FMYAVPlayerViewController ()
/**
 *  声明播放视频的控件属性[既可以播放视频也可以播放音频]
 */
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) UISlider *progressSlider;

@property (nonatomic, assign) CGFloat sumPlayOperation;

@end

@implementation FMYAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.progressSlider];
    
    [self setUpAVPlayer];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setConstraints];
}

- (void)setUpAVPlayer {
    //设置播放的url
    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSURL *url = [NSURL URLWithString:playString];

    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];

    //初始化player对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    //设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    
    
    //设置播放窗口和当前视图之间的比例显示内容
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    
    //设置播放进度的默认值
    self.progressSlider.value = 0;
    //设置播放的默认音量值
    self.player.volume = 1.0f;

}

- (UISlider *)progressSlider {
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 300, SCREENW, 10)];
        [_progressSlider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressSlider;
}


- (void)sliderChange:(UISlider *)slider {
    self.sumPlayOperation = self.player.currentItem.duration.value/self.player.currentItem.duration.timescale;
    
    //CMTimeMake(a,b) a表示当前时间，b表示每秒钟有多少帧
    [self.player seekToTime:CMTimeMakeWithSeconds(self.progressSlider.value*self.sumPlayOperation, self.player.currentItem.duration.timescale) completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}

- (void)setConstraints {
    
    [_progressSlider layoutBottom:50];
    [_progressSlider layoutLeft:0];
    [_progressSlider layoutRight:0];
    
}

@end
