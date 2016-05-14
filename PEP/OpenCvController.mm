//
//  OpenCvController.m
//  PEP
//
//  Created by John Huiskes on 29-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

#import "OpenCvController.h"
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>

@implementation OpenCvController : NSObject

- (void) someMethod {
    NSLog(@"SomeMethod Ran");
    NSLog(@"picture received");
    CvVideoCamera *hoi = [[CvVideoCamera alloc] init]; 
}


- (void)processImage:(cv::Mat &)image {
    
}


@end