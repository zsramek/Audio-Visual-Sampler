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
#import "ViewController.h"

@class SamplerViewController;

@protocol SamplerViewControllerDelegate <NSObject>

- (void)handleURLFromSamplerViewController:(NSURL*)passedURL: (float) passedDuration: (float)passedPitch;

@end

@interface SamplerViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    BOOL flag;
    
    NSArray *dirPaths;
    NSString *docsDir;
    NSString *soundFilePath1;
    NSDictionary *recordSettings;
    
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *recordButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pauseButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UISlider *pitchSlider;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder1;
@property (strong, nonatomic) DiracAudioPlayer *audioPlayer;

@property(nonatomic) float duration;
@property(nonatomic) float pitch;
@property(nonatomic) float volume;

@property (nonatomic) NSURL *soundFileURL1;

@property (nonatomic, weak) id <SamplerViewControllerDelegate> delegate;



@end
