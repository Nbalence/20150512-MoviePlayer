//
//  ViewController.m
//  02-AvAudioRecord
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface ViewController ()<AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
//声明录音器对象
@property(strong,nonatomic)AVAudioRecorder *recorder;
//声明播放器对象
@property(strong,nonatomic)AVAudioPlayer *player;
//声明计时器对象
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation ViewController


-(void)UpDateTime{
    //获取当前录制的时间
    NSTimeInterval time=self.recorder.currentTime;
    _timeLab.text=[NSString stringWithFormat:@"%.f",time];
}

-(NSTimer *)timer{
    if (_timer) {
        return _timer;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(UpDateTime) userInfo:nil repeats:YES];
    
    return _timer;
}

//设置录音时所要的参数
-(NSDictionary *)setings{
    NSMutableDictionary *setDic=[NSMutableDictionary dictionary];
    //1设置编码格式 PCM
    [setDic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //2采样率
    [setDic setObject:@8000 forKey:AVSampleRateKey];
    //3通道数量
    [setDic setObject:@1 forKey:AVNumberOfChannelsKey];
    //4设置量化位数
      [setDic setObject:@8 forKey:AVLinearPCMBitDepthKey];
    //5编码时是否可以使用浮点数
    [setDic setObject:@YES forKey:AVLinearPCMIsFloatKey];
    //6设置编码质量
    [setDic setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    return setDic;
}

-(NSURL *)getUrl{
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *url=[docPath stringByAppendingPathComponent:@"temp.caf"];

    return [NSURL URLWithString:url];
}

-(AVAudioRecorder *)recorder{
    if (_recorder) {
        return _recorder;
    }
      //1初始化对象
    NSError *error;
    _recorder=[[AVAudioRecorder alloc] initWithURL:[self getUrl] settings:[self setings] error:&error];
   //2设置委托方法
    _recorder.delegate=self;
//    //设置分贝
//    [_recorder setMeteringEnabled:YES];
    
    //3.准备录音
    [_recorder prepareToRecord];

    return _recorder;
    
}

-(AVAudioPlayer *)player{
    if (_player) {
        return _player;
    }
   //创建播放器对象
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:[self getUrl] error:nil];
    NSLog(@"======%@",_player.settings);
    
    //准备播放
    [_player prepareToPlay];
    
    return _player;
    
}


- (IBAction)startRecord:(UIButton *)sender {
    if (self.recorder.isRecording) {
        [self.recorder pause];
        [sender setTitle:@"开始录音" forState:UIControlStateNormal];
        //暂停
        self.timer.fireDate=[NSDate  distantFuture];
    }else{
        [self.recorder record];
        [sender setTitle:@"暂停录音" forState:UIControlStateNormal];
        //启动timer
        self.timer.fireDate=[NSDate date];
    }
}
- (IBAction)stopRecord:(UIButton *)sender {
    [self.recorder stop];
    [self.timer invalidate];
     self.timer=nil;

}
- (IBAction)playRecord:(UIButton *)sender {
  //播放录音
    if (self.player.isPlaying) {
        [self.player stop];
    }else{
        [self.player play];
    }

}


#pragma mark RecordDelegate
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"======编码失败调用=====%@",error);
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音完成");

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
