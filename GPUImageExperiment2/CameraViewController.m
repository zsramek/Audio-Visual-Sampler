//
//  CameraViewController.m
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-14.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import "CameraViewController.h"
#import "GPUImage.h"
#import "ViewController.h"

@class CameraViewController;
@class ViewController;

@implementation CameraViewController

@synthesize movieURL;
@synthesize recordButton, stopRecordButton, backButton;
@synthesize gpuImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    stopRecordButton.enabled = NO;
    
    //Setup video camera
    gpuImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [videoCamera addTarget:gpuImageView];
    
    // Begin showing video camera stream
    [videoCamera startCameraCapture];
    
}

- (IBAction)startRecording:(id)sender
{
    //Setup GPUImageMovieWriter
    pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]);
    movieURL = [[NSURL alloc] initFileURLWithPath:pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 640.0) fileType:AVFileTypeQuickTimeMovie outputSettings:[self getVideoSettings]];
    
    
    recordButton.enabled = NO;
    stopRecordButton.enabled = YES;
    [videoCamera addTarget:movieWriter];
    [movieWriter startRecording];
}
- (IBAction)stopRecording:(id)sender
{
    recordButton.enabled = YES;
    [videoCamera removeTarget:movieWriter];
    [movieWriter finishRecording];
    NSLog(@"Recording Finished");
    UISaveVideoAtPathToSavedPhotosAlbum(pathToMovie, nil, nil, NULL);
    
    [self.delegate handleURLFromCameraViewController:movieURL];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)backToHome:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


















//--------Video Settings----------------------------------------------------------------

- (NSDictionary *) getVideoSettings {
    
    NSDictionary *videoCleanApertureSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithInt:640], AVVideoCleanApertureWidthKey,
                                                [NSNumber numberWithInt:640], AVVideoCleanApertureHeightKey,
                                                [NSNumber numberWithInt:10], AVVideoCleanApertureHorizontalOffsetKey,
                                                [NSNumber numberWithInt:10], AVVideoCleanApertureVerticalOffsetKey,
                                                nil];
    
    NSDictionary *videoAspectRatioSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInt:3], AVVideoPixelAspectRatioHorizontalSpacingKey,
                                              [NSNumber numberWithInt:3],AVVideoPixelAspectRatioVerticalSpacingKey,
                                              nil];
    
    NSDictionary *codecSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:2500000], AVVideoAverageBitRateKey,
                                   [NSNumber numberWithInt:1],AVVideoMaxKeyFrameIntervalKey,
                                   videoCleanApertureSettings, AVVideoCleanApertureKey,
                                   //videoAspectRatioSettings, AVVideoPixelAspectRatioKey,
                                   //AVVideoProfileLevelH264Main30, AVVideoProfileLevelKey,
                                   AVVideoProfileLevelH264BaselineAutoLevel, AVVideoProfileLevelKey,
                                   nil];
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   codecSettings,AVVideoCompressionPropertiesKey,
                                   [NSNumber numberWithInt:640], AVVideoWidthKey,
                                   [NSNumber numberWithInt:640], AVVideoHeightKey,
                                   nil];
    
    return videoSettings;
}

@end
