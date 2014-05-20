//
//  ViewController.h
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-14.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AVFoundation/AVFoundation.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CameraViewController.h"
#import "SamplerViewController.h"
#import "DiracAudioPlayer.h"

@interface ViewController : UIViewController <CameraViewControllerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    GPUImageMovie *video;
    NSInteger loops;
    
    AVPlayer *mainPlayer;
    AVPlayerItem *playerItem;
   
}

@property (weak, nonatomic) IBOutlet GPUImageView *videoPlaybackView;
@property (nonatomic) NSURL *movieURL;
@property(nonatomic) NSURL *audioURL;

@property (strong, nonatomic) DiracAudioPlayer *audioPlayer;

@property(nonatomic) float duration;
@property(nonatomic) float pitch;
@property(nonatomic) float volume;

//@property(weak, nonatomic) NSError *error;

- (void)displayLatestVideo;

@end
