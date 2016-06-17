//
//  NewsViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 24-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UIScrollViewDelegate {
    
    var user: User!
    var news: News = News()
    var newsItemView = UIView()
    var stackContentView: UIStackView! = UIStackView()
    var itemTapped: NewsItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func loadView() {
        super.loadView()
        
        user = User()
        user.getUserInformation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        self.navigationItem.setHidesBackButton(false, animated:true);
        
        stackContentView.spacing = 16.0
        stackContentView.axis = .Vertical
        stackContentView.layoutMarginsRelativeArrangement = true
        stackContentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.directionalLockEnabled = true
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
        scrollView.contentSize = CGSize(width: SCREENWIDTH - 40, height: stackContentView.frame.height + 40)
    }
    
    func createNewsViews(){
        var counter: CGFloat = 0
        
        for newsItem in self.news.newsItems {
            print(newsItem.publish)
            if(newsItem.publish){
                let viewInside : UIStackView = UIStackView()
                viewInside.spacing = 0
                viewInside.layoutMargins = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
                viewInside.axis = .Vertical
                viewInside.layoutMarginsRelativeArrangement = true
                viewInside.translatesAutoresizingMaskIntoConstraints = false
                viewInside.tag = Int(counter)
                
                let title: PaddedLabel = PaddedLabel()
                title.text = newsItem.title
                title.backgroundColor = yellowColor
                title.numberOfLines = 2
                
                let bgView: UIView = UIView()
                bgView.backgroundColor = panelColor
                
                let content: PaddedLabel = PaddedLabel()
                content.attributedText = newsItem.getContent()
                content.numberOfLines = 5
                content.backgroundColor = panelColor

                viewInside.addArrangedSubview(title)
                viewInside.addArrangedSubview(content)

                viewInside.userInteractionEnabled = true
                let gesture = UITapGestureRecognizer(target: self, action: #selector(NewsViewController.clickedOnArticle(_:)))
                viewInside.addGestureRecognizer(gesture)
                
                stackContentView.addArrangedSubview(viewInside)
            }
            counter++
        }
    }
    
    func getNews(completion: (loaded: Bool) ->()){
        
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
                            newsItem.publish = newItem.objectForKey("publish") as! Bool
                            
                            self.news.newsItems.append(newsItem)
                        }
                        completion(loaded: true)
                    }
                    
                }
                
            }
            
        }

    }

    func clickedOnArticle(sender:UITapGestureRecognizer){
        
        let clicked = sender.view! as! UIStackView
        let newsId = clicked.tag
        
        let newsItem = self.news.newsItems[newsId]
        self.itemTapped = newsItem
        
        self.performSegueWithIdentifier("newsItemSeque", sender: sender)
       
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {

        
        SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height
        SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
        self.scrollView.setNeedsUpdateConstraints()
        
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newsItemSeque" {
            
            let controller:NewsItemViewController = segue.destinationViewController as! NewsItemViewController

            controller.newsItem = self.itemTapped
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
            
        }
    }
    
    
    
    
    
}