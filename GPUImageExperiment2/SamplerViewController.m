//
//  SamplerViewController.m
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-15.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import "SamplerViewController.h"

@class DiracAudioPlayer;

@implementation SamplerViewController

@synthesize playButton, pauseButton, recordButton, doneButton;
@synthesize audioRecorder1, //audioPlayer1;
audioPlayer;
@synthesize pitchLabel, durationLabel, pitchSlider, durationSlider;
@synthesize pitch, duration, volume;

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
    
    playButton.enabled = NO;
    pauseButton.enabled = NO;
    
    self.pitch = 1.0;
    self.volume = 0.5;
    self.duration = 1.0;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];

    NSString *soundFilePath1 = [docsDir
                                stringByAppendingPathComponent:@"sound1.caf"];

    NSURL *soundFileURL1 = [NSURL fileURLWithPath:soundFilePath1];
    
    NSDictionary *recordSettings = [NSDictionary
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

- (IBAction)pitchSlider:(UISlider*)sender
{
    self.pitch = sender.value;
    [pitchLabel setText:[NSString stringWithFormat:@"%.1f",sender.value]];
}

- (IBAction)durationSlider:(UISlider*)sender
{
    self.duration = sender.value;
    [durationLabel setText:[NSString stringWithFormat:@"%.1f",sender.value]];
}

- (IBAction)volumeSlider:(UISlider*)sender
{
    self.volume = sender.value;
}

- (IBAction)speedSlider:(UISlider*)sender
{
    self.pitch = sender.value;
    self.duration = (2.0 - sender.value);
}

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
    
        /*
        audioPlayer1 = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:audioRecorder1.url
                        error:&error];
        
        audioPlayer1.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
        {
            audioPlayer1.enableRate = YES;
            [audioPlayer1 play];
        }
         */
        
       
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
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
