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

@synthesize movieURL;
@synthesize videoPlaybackView;

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
    NSLog(@"Delegate Worked");
    self.movieURL = URL;
    [self displayLatestVideo];
}

- (void)displayLatestVideo
{
    NSLog(@"Displaying Video");
    
    //AVPlayer *mainPlayer = [[AVPlayer alloc] init];
    //AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:movieURL];
    //[mainPlayer replaceCurrentItemWithPlayerItem:playerItem];
    
    video = [[GPUImageMovie alloc] initWithURL:movieURL];
    [video addTarget:videoPlaybackView];
    video.playAtActualSpeed = YES;
    [video setShouldRepeat:YES];
    [video startProcessing];
    //[self displayLatestVideo];
    //[video endProcessing];
    
}

- (IBAction)stopAll:(id)sender
{
    [video endProcessing];
}

- (IBAction)playAll:(id)sender
{
    [video startProcessing];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camera"])
    {
        CameraViewController *b = (CameraViewController *) segue.destinationViewController;
        b.delegate = self;
    }
    
    [video endProcessing];
}

@end
