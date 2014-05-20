//
//  SamplerViewController.m
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-15.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import "SamplerViewController.h"
#import "ViewController.h"

@class DiracAudioPlayer;
@class ViewController;

@implementation SamplerViewController

@synthesize playButton, pauseButton, recordButton, doneButton;
@synthesize audioRecorder1, audioPlayer;
@synthesize pitchLabel, durationLabel, pitchSlider, durationSlider;
@synthesize pitch, duration, volume;
@synthesize soundFileURL1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    playButton.enabled = YES;
    pauseButton.enabled = NO;
    
    self.pitch = 1.0;
    self.volume = 0.5;
    self.duration = 1.0;
    
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];

    soundFilePath1 = [docsDir stringByAppendingPathComponent:@"sound1.caf"];

    if(soundFileURL1 == nil)
    {
        soundFileURL1 = [NSURL fileURLWithPath:soundFilePath1];
    }
    
    recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];

    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];
    
    
    audioRecorder1 = [[AVAudioRecorder alloc]
                       initWithURL:soundFileURL1
                       settings:recordSettings
                       error:&error];
     
}


//----------Adjustment Slider Implementation-----------------------------------------------------------------

- (IBAction)pitchSlider:(UISlider*)sender
{
    self.pitch = sender.value;
    [pitchLabel setText:[NSString stringWithFormat:@"%.1f",sender.value]];
    [audioPlayer changePitch:pitch];
}

- (IBAction)durationSlider:(UISlider*)sender
{
    self.duration = sender.value;
    [durationLabel setText:[NSString stringWithFormat:@"%.1f",sender.value]];
    [audioPlayer changeDuration:duration];
}

- (IBAction)volumeSlider:(UISlider*)sender
{
    self.volume = sender.value;
    [audioPlayer setVolume:volume];
}

- (IBAction)speedSlider:(UISlider*)sender
{
    self.pitch = sender.value;
    self.duration = (2.0 - sender.value);
    [audioPlayer changePitch:pitch];
    [audioPlayer changeDuration:duration];
}

//--------------------------------------------------------------------------------------------------------------


//--------Button Implementations--------------------------------------------------------------------------------

- (IBAction)record:(id)sender
{
    if (!audioRecorder1.recording)
    {
        recordButton.enabled = NO;
        playButton.enabled = NO;
        pauseButton.enabled = YES;
        [audioRecorder1 record];
    }
}

- (IBAction)play:(id)sender
{
    if (!audioRecorder1.recording)
    {
        [audioPlayer stop];
        pauseButton.enabled = YES;
        recordButton.enabled = NO;
        
        NSError *error;

        //Setup DiracAudioPlayer
        audioPlayer = [[DiracAudioPlayer alloc] initWithContentsOfURL:audioRecorder1.url channels:1 error:&error];
        [audioPlayer changePitch:pitch];
        [audioPlayer setVolume:volume];
        [audioPlayer changeDuration:duration];
        
        [audioPlayer play];
        
        if (audioPlayer.playing == NO)
        {
            pauseButton.enabled = NO;
        }

    }
}

- (IBAction)pause:(id)sender
{
    pauseButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    if (audioRecorder1.recording)
    {
        [audioRecorder1 stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}

- (IBAction)done:(id)sender
{
    [self.delegate handleURLFromSamplerViewController:audioRecorder1.url:pitch:duration];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//---------------------------------------------------------------------------------------------------------------


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [audioPlayer stop];
}

@end
