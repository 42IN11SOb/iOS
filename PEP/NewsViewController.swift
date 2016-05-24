//
//  NewsViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 24-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var user: User!
    var news: News = News()
    var newsItemView = UIView()
    var stackContentView: UIStackView! = UIStackView()
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func loadView() {
        super.loadView()
        
        user = User()
        user.getUserInformation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        scrollView.backgroundColor = panelColor
        
        stackContentView.spacing = 16.0
        stackContentView.axis = .Vertical
        stackContentView.layoutMarginsRelativeArrangement = true
        stackContentView.translatesAutoresizingMaskIntoConstraints = false

        self.getNews { (loaded) in
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.createNewsViews()
            }
        }
        
        let top = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.TopMargin, multiplier: 1.0, constant: -16.0)
        
        let lead = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 20.0)
        
        let trail = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 20.0)
        
        self.scrollView.addSubview(stackContentView)
        
        self.scrollView.addConstraint(top)
        view.addConstraint(lead)
        view.addConstraint(trail)
   
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        scrollView.content
        scrollView.contentSize = CGSize(width: SCREENWIDTH - 40, height: stackContentView.frame.height + 20)
    }
    
    func createNewsViews(){
        
        
        for newsItem in self.news.newsItems {
         
            let view : UIStackView = UIStackView()
            view.spacing = 8.0
//            view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            view.axis = .Vertical
            view.layoutMarginsRelativeArrangement = true
            view.translatesAutoresizingMaskIntoConstraints = false
            
            print(newsItem.title)
            
            let title: UILabel = UILabel()
            title.text = newsItem.title
            let content: UILabel = UILabel()
            content.attributedText = newsItem.getContent()
            content.numberOfLines = 0
            view.addArrangedSubview(title)
            view.addArrangedSubview(content)
            
            stackContentView.addArrangedSubview(view)
       
        }
//        
//             self.viewDidLayoutSubviews()
//        self.view.needsUpdateConstraints()
//        self.scrollView.needsUpdateConstraints()
    }
    
    func getNews(completion: (loaded: Bool) ->()){
        
//        self.news.newsItems = []
        RequestController.getNews { (result, error) in
      
            if(result != nil){
                if ((result?.objectForKey("success")) != nil) {
                    let success = result?.objectForKey("success") as! Bool
                    if success {
                        let data = result?.objectForKey("data") as! NSArray
                        
                        for newItem in data {
                            
                            let newsItem: NewsItem = NewsItem()
                            newsItem.title = newItem.objectForKey("title") as! String
                            newsItem.content = newItem.objectForKey("content") as! String
                            
                            self.news.newsItems.append(newsItem)
                           
                        }
                        
                        
                        completion(loaded: true)
                    }
                    
                }
                
            }
            
        }

    }
    
    
}