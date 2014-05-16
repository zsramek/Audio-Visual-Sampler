//
//  SamplerViewController.h
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-15.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DiracAudioPlayer.h"

@interface SamplerViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    BOOL flag;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *recordButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pauseButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UISlider *pitchSlider;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder1;
//@property (strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property (strong, nonatomic) DiracAudioPlayer *audioPlayer;

@property(nonatomic) float duration;
@property(nonatomic) float pitch;
@property(nonatomic) float volume;

@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;


@end
