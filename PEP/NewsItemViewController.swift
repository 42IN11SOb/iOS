//
//  NewsItemViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 07-06-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class NewsItemViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    var stackContentView: UIStackView! = UIStackView()
    
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
        self.view.backgroundColor = backgroundColor
        self.view.willRemoveSubview(scrollView)

//
//  
//        stackContentView.spacing = 16.0
//        stackContentView.axis = .Vertical
//        stackContentView.layoutMarginsRelativeArrangement = true
//        stackContentView.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        let contentLabel : UILabel = UILabel()
//        contentLabel.attributedText = newsItem?.getContent()
//        contentLabel.numberOfLines = 0
//        
//        stackContentView.addArrangedSubview(contentLabel)
//        
//        
//        let lead = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 20.0)
//        
//        let trail = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: -20.0)
//        
//        let top = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1.0, constant: 100.0)
//        
//        self.scrollView.addSubview(stackContentView)
//        
//        view.addConstraint(lead)
//        view.addConstraint(trail)
//        view.addConstraint(top)
        
        
        let htmlString : NSMutableString = NSMutableString(string: "<html><head><title></title></head><body style=\"background:transparent;\">")
        
        htmlString.appendString(newsItem!.content)
        htmlString.appendString("</body></html>")
        
        let webView = UIWebView(frame: self.view.frame)
        
        
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
        scrollView.contentSize = CGSize(width: SCREENWIDTH - 40, height: stackContentView.frame.height + 20)
    }
    
    
    
    
}