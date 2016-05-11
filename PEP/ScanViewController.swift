//
//  ViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import AVFoundation

protocol CameraFramesDelegate {
    func processCameraFrames(sampleBuffer : CMSampleBufferRef)
}

class ScanViewController: UIViewController, CameraFramesDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {

    // #TODO:
    // - var outlets aanmaken voor alle elementen in de view
    // - scan knop of continue scan?
    // - camera koppeling (camera spul zelf in core!)
    // - model aanmaken voor een herkende scan 
    // - scan 'recognized' functie opzetten (al is het maar een opzet) 
    // -
    @IBOutlet weak var previewView: UIView!
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    var delegate : CameraFramesDelegate?
    var captureSession = AVCaptureSession();
    var captureDevice : AVCaptureDevice?
    
    var stillImageOutput: AVCaptureStillImageOutput?
    //var previewLayer: AVCaptureVideoPreviewLayer?
    let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SCANTITLE", comment:"Scan title")
        self.view.backgroundColor = backgroundColor
        previewView.backgroundColor = backgroundColor
        
        let instanceOfCustomObject: OpenCvController = OpenCvController()
        instanceOfCustomObject.someProperty = "Hello World"
        print(instanceOfCustomObject.someProperty)
        instanceOfCustomObject.someMethod()
        
        //let _ = CvVideoCamera()
    /*
        /
        self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
        self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
        self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
        self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        self.videoCamera.defaultFPS = 30;
        self.videoCamera.grayscale = NO;
    */
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadCamera()
        
        }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized{
        previewLayer!.frame = previewView.bounds
        previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        }
        else
        {
            let alertController = UIAlertController(
                title: "Geen camera toegang",
                message: "De app heeft toegang nodig tot uw camera om gebruik te kunnen maken van deze functie",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            
            let settingsAction = UIAlertAction(
                title: "Instellingen",
                style: UIAlertActionStyle.Default) { (action) in
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    self.navigationController?.popViewControllerAnimated(true)
            }
            
            let confirmAction = UIAlertAction(
            title: "Terug", style: UIAlertActionStyle.Default) { (action) in
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(settingsAction)

            self.presentViewController(alertController, animated: true, completion: nil)

        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //zodra het cherm veranderd (rotate) dan word de previewlayer ook aangepast
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            self.previewLayer?.connection.videoOrientation = self.transformOrientation(UIInterfaceOrientation(rawValue: UIApplication.sharedApplication().statusBarOrientation.rawValue)!)
            self.previewLayer?.frame.size = self.previewView.frame.size
            }, completion: { (context) -> Void in
                
        })
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    
    
    
    func loadCamera(){
        
        captureSession.beginConfiguration()
        
        // Capture the session with High settings preset
        captureSession.sessionPreset = AVCaptureSessionPresetHigh;
        
        self.captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo);
        
        // Because the old error handling method is deprecated
        do {
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice));
        } catch {
            print("Error in getting input from camera");
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        
        let output = AVCaptureVideoDataOutput();
        
        var outputQueue : dispatch_queue_t?
        outputQueue = dispatch_queue_create("outputQueue", DISPATCH_QUEUE_SERIAL);
        output.setSampleBufferDelegate(self, queue: outputQueue)
        
        output.alwaysDiscardsLateVideoFrames = true;
        output.videoSettings = nil;
        
        captureSession.addOutput(output);
        
        captureSession.commitConfiguration()
        captureSession.startRunning();

    }

    //deze methode veranderd de orientatie van de camera op dezelfde orientatie als van de UIview
    func transformOrientation(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch orientation {
        case .LandscapeLeft:
            return .LandscapeLeft
        case .LandscapeRight:
            return .LandscapeRight
        case .PortraitUpsideDown:
            return .PortraitUpsideDown
        default:
            return .Portrait
        }
    }
    
    //deze methode zet het camera lampje aan of weer uit
    func toggleFlash()
    {
        if (backCamera.hasTorch) {
            do {
                try backCamera.lockForConfiguration()
                if (backCamera.torchMode == AVCaptureTorchMode.On) {
                    backCamera.torchMode = AVCaptureTorchMode.Off
                } else {
                    try backCamera.setTorchModeOnWithLevel(1.0)
                }
                backCamera.unlockForConfiguration()
            } catch {
                print(error)
            }
        }

    }
    
    //sla huidige frame op
    func captureFrame()
    {
        print("capturing frame");
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        print("frame dropped")
    }
    
    func captureOutput(captureOutput: AVCaptureOutput, didOutputSampleBuffer sampleBuffer: CMSampleBufferRef, fromConnection connection: AVCaptureConnection) {
        
        print("frame received")
    }
    
    func processCameraFrames(sampleBuffer : CMSampleBufferRef)
    {}
    
}

