//
//  CameraViewController.h
//  GPUImageExperiment2
//
//  Created by Zefan Sramek on 2014-05-14.
//  Copyright (c) 2014 Zefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@class CameraViewController;

@protocol CameraViewControllerDelegate <NSObject>

- (void)handleURLFromCameraViewController:(NSURL*)passedURL;

@end

@interface CameraViewController : UIViewController
{
    GPUImageVideoCamera *videoCamera;
    GPUImageFilter *filter;
    GPUImageMovieWriter *movieWriter;
    NSString *pathToMovie;
}

@property (nonatomic) NSURL *movieURL;

@property (nonatomic) IBOutlet GPUImageView *gpuImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *recordButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stopRecordButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property (nonatomic, weak) id <CameraViewControllerDelegate> delegate;



@end
