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

    var frameNr = 0
    var colors: [PassportColor] = []
    var regColorView: UIView = UIView()
    var scanning: Bool = false
    var timer = NSTimer()
    var result: Bool = false
    var resultColor: PassportColor!
    
    @IBOutlet weak var scanButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SCANTITLE", comment:"Scan title")
        self.view.backgroundColor = backgroundColor
        self.navigationItem.backBarButtonItem?.title = " "
        
        let pass = DatabaseController.sharedControl.getPassport()
        for color in pass.season {
            colors.append(color as PassportColor)
        }
        
        
        setupCameraSession()
    }
    
    override func loadView() {
        super.loadView()
        self.navigationItem.backBarButtonItem?.title = " "
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layer.addSublayer(previewLayer)
        
        cameraSession.startRunning()
        
        regColorView.layer.borderWidth = 20
        regColorView.layer.borderColor = UIColor.blueColor().CGColor
        regColorView.backgroundColor = UIColor.clearColor()
        
        let frame = CGRect(x: 10, y: 64, width: SCREENWIDTH - 20, height: SCREENHEIGHT - 84)
        regColorView.frame = frame
        
        scanButton.layer.cornerRadius = 50
        
        self.view.addSubview(regColorView)
        self.view.bringSubviewToFront(regColorView)
        self.view.bringSubviewToFront(scanButton)
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
        
            if frameNr % 32 == 0 {
                
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
        
        let re: Float = array[0].floatValue
        let gr: Float = array[1].floatValue
        let bl: Float = array[2].floatValue
        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.regColorView.layer.borderColor = UIColor(red: CGFloat(array[0] as! NSNumber)/255, green: CGFloat(array[1] as! NSNumber)/255, blue: CGFloat(array[2] as! NSNumber)/255, alpha: 1).CGColor
            self.regColorView.layer.setNeedsDisplay()
        }
        
        
        if(self.scanning){
        
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                
                for color in self.colors{

                    let margin: Float = 30.0
                    if(color.redColor > (re - margin) && color.redColor < (re + margin) && color.greenColor > (gr - margin) && color.greenColor < (gr + margin) && color.blueColor > (bl - margin) && color.blueColor < (bl+margin)){
                        
                        print("----------------------------------")
                        print(color.name)
                        print("red \(re) -  \(color.redColor)" )
                        print("green \(gr) -  \(color.greenColor)" )
                        print("blue \(bl) -  \(color.blueColor)" )
                        
                        if(self.scanning){
                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                            
                            self.resultColor = color
                            self.result = true
                            self.performSegueWithIdentifier("scanResultSegue", sender: self)
                            
                            self.timer.invalidate()
                            self.resetButton()
                            self.scanning = false
                        }
 
                        
                    }
                }
            }
        }
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
    @IBAction func scanButtonClicked(sender: AnyObject) {
        
        self.scanButton.titleLabel!.text = "scanning"
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        
        self.scanButton.backgroundColor = blackColor
        self.scanButton.userInteractionEnabled = false
        self.scanning = true
    }
    
    // called every time interval from the timer
    func timerAction() {
        resetButton()
        self.performSegueWithIdentifier("scanResultSegue", sender: self)
    }
    
    func resetButton() {
        self.scanButton.backgroundColor = yellowColor
        self.scanButton.userInteractionEnabled = true
        self.scanning = false
        self.result = false
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scanResultSegue" {
            
            let controller:ScanResultViewController = segue.destinationViewController as! ScanResultViewController
            controller.scanResult = self.result
            controller.navigationItem.backBarButtonItem?.title = " "
            if(self.result){
                controller.title = "Match found!"
                controller.resultColor = resultColor
            } else {
                controller.title = "No Match found!"
            }
            
            
        }
    }
    
    
}



