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
    
    int pos_x,pos_y;
    pos_x = inputImage.size.width/2;
    pos_y = (inputImage.size.height/2) + 20;
    
    
    int numberOfPointsPerRow = 3;
    int totalNr = numberOfPointsPerRow * numberOfPointsPerRow;
    int *redColor = new int[totalNr];
    int *greenColor = new int[totalNr];
    int *blueColor = new int[totalNr];
    
    int counter =0;
    for(int i=0; i<numberOfPointsPerRow; i++){
        for(int j=0; j<numberOfPointsPerRow; j++){
            int red, green, blue;
            red = 0;
            green = 0;
            blue = 0;
            int xpos = ((inputImage.size.width / 5) * j) + (inputImage.size.width / 5);
            int ypos = ((inputImage.size.height/ 5) * i) + (inputImage.size.height/ 5);
//            int xpos = (pos_x - 50) + (j * 10);
//            int ypos = (pos_y - 50) + (i * 10);
            
            cv::Vec3b intensity = img.at<cv::Vec3b>(ypos, xpos);
            red = intensity.val[0];
            green = intensity.val[1];
            blue = intensity.val[2];
            
            redColor[counter] = red;
            greenColor[counter] = green;
            blueColor[counter] = blue;
            counter++;
            
        }
    }
//
    NSLog(@" %d", counter);
    int redMode = getMode(redColor, counter);
    int greenMode = getMode(greenColor, counter);
    int blueMode =getMode(blueColor, counter);
   
    NSArray * check = [NSArray arrayWithObjects:[NSNumber numberWithInt:redMode], [NSNumber numberWithInt:greenMode], [NSNumber numberWithInt:blueMode], nil];
    return check;
    
    
//    return colorValues;

}



int getMode(int array[], int size){

    int * rep = new int[size];
    for(int i=0; i<size; i++){
        rep[i]= 0;
        int j = 0;
        
        while((j< i) && ((array[i] > (array[j] + 20)) || (array[i] < (array[j] - 20)))){
            if ((array[i] > (array[j] + 20)) ||  (array[i] < (array[j] - 20))) {
                ++j;
            }
        }
        ++(rep[j]);
    }
    
    int maxRep = 0;
    for(int i=1; i<size; i++){
        if(rep[i] > rep[maxRep]){
            maxRep = i;
        }
    }
    
    delete [] rep;
    
    return array[maxRep];

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





@end