//
//  ViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift


class ScanViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{

    // #TODO:
    // - var outlets aanmaken voor alle elementen in de view
    // - scan knop of continue scan?
    // - camera koppeling (camera spul zelf in core!)
    // - model aanmaken voor een herkende scan 
    // - scan 'recognized' functie opzetten (al is het maar een opzet) 
    // -

    var frameNr = 0
    var colors: [PassportColor] = []
    var regColorView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SCANTITLE", comment:"Scan title")
        self.view.backgroundColor = backgroundColor
        
        let pass = DatabaseController.sharedControl.getPassport()
        for color in pass.season {
            colors.append(color as PassportColor)
        }
        
        
        setupCameraSession()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layer.addSublayer(previewLayer)
        
        cameraSession.startRunning()
        
        regColorView.layer.borderWidth = 10
        regColorView.layer.borderColor = UIColor.blueColor().CGColor
        regColorView.backgroundColor = UIColor.clearColor()
        
        let size = 100
        let center_x = self.view.frame.size.width/2
        let center_y = self.view.frame.size.height/2
        let pos_x = Int(center_x) - (size/2)
        let pos_y = Int(center_y) - (size/2)
        
        let frame = CGRect(x: pos_x, y: pos_y, width: size, height: size)
        regColorView.frame = frame
        
        
        self.view.addSubview(regColorView)
        self.view.bringSubviewToFront(regColorView)
        
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
        s.sessionPreset = AVCaptureSessionPresetHigh
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
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)]
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
        
        if frameNr % 16 == 0 {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                //All stuff here
                let image:UIImage = self.imageFromSampleBuffer(sampleBuffer)
                let colorArray = CVWrapper.processImageWithOpenCV(image)
                self.checkColors(colorArray)
            })
        }
        frameNr += 1
        
    }
    
    func checkColors(array: NSArray){
        
        
        print(array[0])
        print(array[1])
        print(array[2])
        
        regColorView.layer.borderColor = UIColor(red: CGFloat(array[0] as! NSNumber)/255, green: CGFloat(array[1] as! NSNumber)/255, blue: CGFloat(array[2] as! NSNumber)/255, alpha: 1).CGColor
        regColorView.layer.setNeedsDisplay()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        // Here you can count how many frames are dopped
    }
    

    func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage {
        // Get a CMSampleBuffer's Core Video image buffer for the media data
        let imageBuffer: CVImageBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer)!
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
          let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        
        let address = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)

        // Create a device-dependent RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Create a bitmap graphics context with the sample buffer data
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.NoneSkipFirst.rawValue | CGBitmapInfo.ByteOrder32Little.rawValue).rawValue
        let context = CGBitmapContextCreate(address, width, height, 8, bytesPerRow, colorSpace, bitmapInfo)
        // Create a Quartz image from the pixel data in the bitmap graphics context
        
        
        let quartzImage = CGBitmapContextCreateImage(context)
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer,0)
        
        
        // Create an image object from the Quartz image
        let image = UIImage(CGImage: quartzImage!)
        

        CVPixelBufferUnlockBaseAddress(imageBuffer,0)
        
        return image
        
        
    }
}



