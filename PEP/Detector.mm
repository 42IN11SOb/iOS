
//
//  Detector.m
//  PEP
//
//  Created by Corina Nibbering on 11-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#import "Detector.h"

@interface Detector() {
    
}

@property (nonatomic, assign) CGFloat scale;


@end

@implementation Detector

- (instancetype)initWithCameraView:(UIImageView *)view scale:(CGFloat)scale {
    self = [super init];
    if (self) {
        self.videoCamera = [[CvVideoCamera alloc] initWithParentView:view];
        self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
        self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        self.videoCamera.defaultFPS = 30;
        self.videoCamera.grayscaleMode = NO;
        self.videoCamera.delegate = self;
        self.scale = scale;
     }
    
    return self;
}


- (void)startCapture {
    [self.videoCamera start];
}

- (void)stopCapture; {
    [self.videoCamera stop];
}

- (void)processImage:(cv::Mat &)image {
    
}


@end