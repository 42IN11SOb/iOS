//
//  CVWrapper.h
//  PEP
//
//  Created by Corina Nibbering on 14-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CVWrapper : NSObject

+ (NSArray*) processImageWithOpenCV: (UIImage*) inputImage;
+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;

@end