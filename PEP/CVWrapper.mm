//
//  CVWrapper.m
//  PEP
//
//  Created by Corina Nibbering on 14-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVWrapper.h"
#import <UIKit/UIKit.h>
#import "stitching.h"
#import "UIImage+OpenCV.h"

@implementation CVWrapper

+ (NSArray*) processImageWithOpenCV: (UIImage*) inputImage
{

    cv::Mat thr;
    cv::Mat img = [inputImage CVMat];
    cv::Mat hsvImage;
//    cv::cvtColor(img , hsvImage, CV_BGR2HSV);
//    threshold(thr,thr,180,255,cv::THRESH_BINARY_INV);
    
    std::vector<cv::Mat>channels;
    
    int x,y;
    x = inputImage.size.width/2;
    y = inputImage.size.height/2;

    cv::Vec3b intensity = img.at<cv::Vec3b>(y, x);

    int redd = intensity.val[0];
    int greenn = intensity.val[1];
    int bluee = intensity.val[2];

    NSArray * check = [NSArray arrayWithObjects:[NSNumber numberWithInt:redd], [NSNumber numberWithInt:greenn], [NSNumber numberWithInt:bluee], nil];
    return check;
//    return recognized;
}



+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;
{
   
    return inputImage1;
}
//
//- (void)processImage:(UIImage *)input
//{
//    int width  = input.size.width;
//    int height = input.size.height;
//    
//    // allocate the pixel buffer
//    uint32_t *pixelBuffer = calloc( width * height, sizeof(uint32_t) );
//    
//    // create a context with RGBA pixels
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate( pixelBuffer, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast );
//    
//    // invert the y-axis, so that increasing y is down
//    CGContextScaleCTM( context, 1.0, -1.0 );
//    CGContextTranslateCTM( context, 0, -height );
//    
//    // draw the image into the pixel buffer
//    UIGraphicsPushContext( context );
//    [input drawAtPoint:CGPointZero];
//    UIGraphicsPopContext();
//    
//    // scan the image
//    int x, y;
//    uint8_t r, g, b, a;
//    uint8_t *pixel = (uint8_t *)pixelBuffer;
//    
//    for ( y = 0; y < height; y++ )
//        for ( x = 0; x < height; x++ )
//        {
//            r = pixel[0];
//            g = pixel[1];
//            b = pixel[2];
//            a = pixel[3];
//            
//            // do something with the pixel value here
//            
//            pixel += 4;
//        }
//    
//    // release the resources
//    CGContextRelease( context );
//    CGColorSpaceRelease( colorSpace );
//    free( pixelBuffer );
//}


@end