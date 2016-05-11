//
//  Detector.h
//  PEP
//
//  Created by Corina Nibbering on 11-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>



@interface Detector: NSObject <CvVideoCameraDelegate>

@property (nonatomic, strong) CvVideoCamera* videoCamera;

- (instancetype)initWithCameraView:(UIImageView *)view scale:(CGFloat)scale;

- (void)startCapture;
- (void)stopCapture;



@end
