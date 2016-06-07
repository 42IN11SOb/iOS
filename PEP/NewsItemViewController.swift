//
//  NewsItemViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 07-06-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import AVFoundation


// IMPORTANT NOTE! 
//  When showing a loaded youtube video in full screen,
//  layout constraints are broken. This seems to be a problem in iOS 9
// http://stackoverflow.com/questions/32765124/ios-9-uiwebview-embedded-video-fullscreen-play-cause-a-constraint-error

class NewsItemViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var webView : UIWebView!
    let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    var newsItem: NewsItem? {
        didSet{
            configureView()
        }
    }
    
    override func loadView() {
        super.loadView()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
             print(error)
        }
        self.view.backgroundColor = backgroundColor

        webView.mediaPlaybackRequiresUserAction = false
        webView.translatesAutoresizingMaskIntoConstraints = false
      
        
    
        
        let htmlString : NSMutableString = NSMutableString(string: "<html><head><title></title></head><body style=\"background:transparent;\">")
        
        htmlString.appendString(newsItem!.content)
        htmlString.appendString("</body></html>")  
        
        webView.backgroundColor = UIColor.clearColor()
        webView.loadHTMLString(htmlString.description, baseURL: nil)
        
        self.view.addSubview(webView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func configureView(){
        
        self.title = self.newsItem!.title
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    
}