//
//  ViewController.m
//  03-MoviePlayerController
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()
//1声明一个mpMoviePlayrController的对象
@property(nonatomic,strong)MPMoviePlayerController*moviePlayer;

@property(nonatomic,strong)MPMoviePlayerViewController  *MPmovieViewCV;

@end





@implementation ViewController

-(void)notificationCenture:(NSNotification *)notification{
 //播放完成
#if 0
    [_moviePlayer.view removeFromSuperview];
#endif
    [_MPmovieViewCV dismissMoviePlayerViewControllerAnimated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
#if 0
     NSURL *url=[[NSBundle mainBundle] URLForResource:@"123" withExtension:@"mp4"];
    _moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:url];
   //2设置控制面板
    _moviePlayer.controlStyle=MPMovieControlStyleEmbedded;
   //3设置frame大小
    _moviePlayer.view.frame=self.view.bounds;
//    //4.准备播放
//     [_moviePlayer prepareToPlay];
    
   
#endif
    
    //注册通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenture:) name:MPMoviePlayerPlaybackDidFinishNotification object:_MPmovieViewCV];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)playeAction:(id)sender {
    //4.添加到视图
#if 0
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer play];
#endif
    //1.初始化对象
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"123" withExtension:@"mp4"];
    _MPmovieViewCV=[[MPMoviePlayerViewController alloc] initWithContentURL:url];

    [self presentMoviePlayerViewControllerAnimated:_MPmovieViewCV];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
