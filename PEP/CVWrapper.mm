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
    
    int red, green, blue;
    red = 0;
    green = 0;
    blue = 0;
    int numberOfPixels = 1;
//    NSDictionary *colorValues = [[NSDictionary alloc] init];
    
    cv::Vec3b intensity = img.at<cv::Vec3b>(y, x);
    red = intensity.val[0];
    NSLog(@"%d red", intensity.val[0]);
    green = intensity.val[1];
    blue = intensity.val[2];
    
//    
//    for(int i=0; i < numberOfPixels; i++){
//        int xx =(x-2)+i;
//        int yy = (y-2)+i;
//        
//        cv::Vec3b intensity = img.at<cv::Vec3b>(yy, xx);
//        red += intensity.val[0];
//        green += intensity.val[1];
//        blue += intensity.val[2];
//    }
    
    int avgRed =0, avgGreen=0, avgBlue = 0;
    avgRed = red/(numberOfPixels);
    avgGreen = green/(numberOfPixels);
    avgBlue = blue/(numberOfPixels);
    
    
    NSLog(@" %d red , %d green %d blue", avgRed, avgGreen, avgBlue);
//    colorValues = @{
//                    @"r": [NSNumber numberWithInt:avgRed],
//                    @"g": [NSNumber numberWithInt:avgGreen],
//                    @"b": [NSNumber numberWithInt:avgBlue],};



    NSArray * check = [NSArray arrayWithObjects:[NSNumber numberWithInt:avgRed], [NSNumber numberWithInt:avgGreen], [NSNumber numberWithInt:avgBlue], nil];
    return check;
//    return recognized;
}


+ (NSDictionary*) calculateFromThree: (int)x y:(int)y img:(cv::Mat)img {
    int red, green, blue;
    int numberOfPixels = 3;
    NSDictionary *colorValues = [[NSDictionary alloc] init];
    
    for(int i=0; i < numberOfPixels; i++){
        cv::Vec3b intensity = img.at<cv::Vec3b>((y-1)+i, (x-1)+i);
        red += intensity.val[0];
        green += intensity.val[1];
        blue += intensity.val[2];
    }
    
    int avgRed, avgGreen, avgBlue;
    avgRed = red/numberOfPixels;
    avgGreen = green/numberOfPixels;
    avgBlue = blue/numberOfPixels;
    colorValues = @{
                    @"r": [NSNumber numberWithInt:avgRed],
                    @"g": [NSNumber numberWithInt:avgGreen],
                    @"b": [NSNumber numberWithInt:avgBlue],};
    
    return colorValues;
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