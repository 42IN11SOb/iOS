//
//  CameraViewController.m
//  PEP
//
//  Created by Corina Nibbering on 11-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

#import "CameraViewController.h"
#import "Detector.h"

@interface CameraViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
@property (nonatomic, strong) Detector* detector;


@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@end
