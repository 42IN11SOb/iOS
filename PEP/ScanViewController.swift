//
//  ViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import AVFoundation


class ScanViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{

    // #TODO:
    // - var outlets aanmaken voor alle elementen in de view
    // - scan knop of continue scan?
    // - camera koppeling (camera spul zelf in core!)
    // - model aanmaken voor een herkende scan 
    // - scan 'recognized' functie opzetten (al is het maar een opzet) 
    // -

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SCANTITLE", comment:"Scan title")
        self.view.backgroundColor = backgroundColor

        setupCameraSession()
    }


    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layer.addSublayer(previewLayer)
        
        cameraSession.startRunning()
       
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var cameraSession: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = AVCaptureSessionPresetLow
        return s
    }()
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
        preview.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        preview.position = CGPoint(x: CGRectGetMidX(self.view.bounds), y: CGRectGetMidY(self.view.bounds))
        preview.videoGravity = AVLayerVideoGravityResize
        return preview
    }()
    
    func setupCameraSession() {
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) as AVCaptureDevice
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            cameraSession.beginConfiguration()
            
            if (cameraSession.canAddInput(deviceInput) == true) {
                cameraSession.addInput(deviceInput)
            }
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if (cameraSession.canAddOutput(dataOutput) == true) {
                cameraSession.addOutput(dataOutput)
            }
            
            cameraSession.commitConfiguration()
            
            let queue = dispatch_queue_create("com.oogverblindendmooi.queue", DISPATCH_QUEUE_SERIAL)
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        // Here you collect each frame and process it
        
        print("frame")
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        // Here you can count how many frames are dopped
    }

    
}

