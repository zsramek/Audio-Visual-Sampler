//
//  ViewController.m
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-14.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize movieURL, audioURL;
@synthesize videoPlaybackView;
@synthesize audioPlayer;
@synthesize volume, duration, pitch;
//@synthesize error;


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View did load.");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleURLFromCameraViewController:(NSURL *)URL
{
    NSLog(@"Camera Delegate Worked");
    self.movieURL = URL;
    [self displayLatestVideo];
}

- (void) handleURLFromSamplerViewController:(NSURL *)URL: (float)passedDuration: (float)passedPitch;
{
    NSLog(@"Sampler Delegate Worked");
    self.audioURL = URL;
    self.pitch = 2.0 - passedPitch;
    self.duration = 2.0 - passedDuration;
    NSLog(@"pitch: %.1f",pitch);
}

- (void)displayLatestVideo
{
    NSLog(@"Displaying Video");
    
    /*
    AVPlayer *mainPlayer = [[AVPlayer alloc] init];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:movieURL];
    [mainPlayer replaceCurrentItemWithPlayerItem:playerItem];
    */
    
    mainPlayer = [[AVQueuePlayer alloc] init];
    playerItem = [[AVPlayerItem alloc] initWithURL:movieURL];
    [mainPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [mainPlayer setRate:0.5];
    
    mainPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[mainPlayer currentItem]];
    
    video = [[GPUImageMovie alloc] initWithPlayerItem:playerItem];
    [video addTarget:videoPlaybackView];
    video.playAtActualSpeed = YES;
    //[video setShouldRepeat:YES];
    [mainPlayer setRate:0.5];
   // [mainPlayer play];
    [video startProcessing];
    [mainPlayer pause];
   //[video endProcessing];
    
    
}

- (IBAction)stopAll:(id)sender
{
    [video endProcessing];
    [mainPlayer pause];
    [audioPlayer stop];
}

- (IBAction)playAll:(id)sender
{
    loops = -1.0;
    
    NSError *error = [[NSError alloc]init];
    
    audioPlayer = [[DiracAudioPlayer alloc] initWithContentsOfURL:audioURL channels:1 error:&(error)];
    
    [audioPlayer changePitch:pitch];
    //[audioPlayer setVolume:volume];
    [audioPlayer changeDuration:duration];
    [audioPlayer setNumberOfLoops:loops];
    
    [mainPlayer play];
    [audioPlayer play];
    [video startProcessing];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camera"])
    {
        CameraViewController *b = (CameraViewController *) segue.destinationViewController;
        b.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"sampler"])
    {
        SamplerViewController *c = (SamplerViewController *) segue.destinationViewController;
        c.delegate = self;
        
        c.soundFileURL1 = self.audioURL;
    }
    
    
    [mainPlayer pause];
    [video endProcessing];
    [audioPlayer stop];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    [mainPlayer setRate:0.5];
    //[p play];
}

@end
