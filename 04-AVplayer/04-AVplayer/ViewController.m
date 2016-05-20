//
//  ViewController.m
//  04-AVplayer
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property(nonatomic,strong)AVPlayerViewController *playerContrller;
//播放器对象
@property(nonatomic,strong)AVPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //1.将player 转换成CAPlayerlayer对象，主要用来显示画面
    AVPlayerLayer *layer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    //2.设置frame 位置大小
    layer.frame=CGRectMake(20, 300, 300, 200);
//    layer.masksToBounds=YES;
//    layer.cornerRadius;
    [self.view.layer addSublayer:layer];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark 通知中心
-(void)didFineshPlayBack:(NSNotification *)notification{
    NSLog(@"=========完成播放");
#if 0
    [_playerContrller dismissViewControllerAnimated:YES completion:nil];
#endif

}


-(AVPlayer *)player{
    if(_player){
        return _player;
    }
    //1.创建资源类型
      //1.1创建媒体资源管理器
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"123" withExtension:@"mp4"];
    AVPlayerItem *item=[[AVPlayerItem alloc] initWithURL:url];
    //添加监听播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFineshPlayBack:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    _player=[[AVPlayer alloc] initWithPlayerItem:item];
    
    return _player;
}

- (IBAction)palyAction:(id)sender {
#if 0    //1.初始化控制器对象
    _playerContrller=[[AVPlayerViewController alloc]init];
    //2.设置播放器对象
    _playerContrller.player=[self player];
    //3.设置控制面板
    _playerContrller.showsPlaybackControls=YES;
    //4.设置屏幕画面载入 全屏
    _playerContrller.videoGravity=AVLayerVideoGravityResizeAspect;
    [self presentViewController:_playerContrller animated:YES completion:^{
        //播放视频
        [_playerContrller.player play];
    }];
#endif
    //播放
    [self.player play];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
