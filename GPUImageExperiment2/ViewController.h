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
#import "DiracAudioPlayer.h"

@interface ViewController : UIViewController <CameraViewControllerDelegate>
{
    GPUImageMovie *video;
}

@property (weak, nonatomic) IBOutlet GPUImageView *videoPlaybackView;
@property (nonatomic) NSURL *movieURL;

- (void)displayLatestVideo;

@end
