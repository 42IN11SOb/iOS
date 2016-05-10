//
//  StyleViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import ImageLoader

class StyleViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var contentView: UIView!
    var stackContentView: UIStackView! = UIStackView()
    
                    var figureImgView: UIImageView!
                    var seasonLabel: UILabel!
                    var adviceLabel: UILabel!
                    var figureTitleLabel: UILabel!
                    var figureLabel: UILabel!
                    var doLabel: UILabel!
                    var dontLabel: UILabel!
//    @IBOutlet weak var heightConstraintDo: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("STYLETITLE", comment:"Style title")
        self.view.backgroundColor = backgroundColor
        self.scrollView.backgroundColor = panelColor
        
        let pass = DatabaseController.sharedControl.getPassport()
        
        figureImgView = UIImageView(frame: CGRect(x: 16, y: 16, width: SCREENWIDTH*0.8, height: 150))
        
        figureImgView.load((pass.figure?.img)!)
        figureImgView.accessibilityLabel = pass.figure_title
        figureImgView.accessibilityHint = pass.figure_title
        figureImgView.accessibilityActivate()
        figureImgView.isAccessibilityElement = true
        figureImgView.userInteractionEnabled = true
        
        stackContentView.spacing = 8.0
        stackContentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackContentView.axis = .Vertical
        stackContentView.layoutMarginsRelativeArrangement = true
        stackContentView.translatesAutoresizingMaskIntoConstraints = false

        figureTitleLabel = UILabel()
        figureTitleLabel.text = pass.figure_title
        
        figureLabel = UILabel()
        adviceLabel = UILabel()
        figureLabel.text = pass.figure?.info
        figureLabel.numberOfLines = 0
        adviceLabel.numberOfLines = 0
        adviceLabel.text = pass.figure?.advice
  
        
        stackContentView.addArrangedSubview(figureImgView)
        stackContentView.addArrangedSubview(figureTitleLabel)
        stackContentView.addArrangedSubview(figureLabel)
        stackContentView.addArrangedSubview(adviceLabel)
        
        addDoLines()
        addDontLines()

        
        let widthConstraint = NSLayoutConstraint(item: stackContentView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: SCREENWIDTH - 40)
        
        
        self.scrollView.addSubview(stackContentView)

        view.addConstraint(widthConstraint)
                scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[stackView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackContentView]))
                scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[stackView]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackContentView]))

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollView.content
        scrollView.contentSize = CGSize(width: SCREENWIDTH - 40, height: stackContentView.frame.height + 20)
    }
    
    func addDoLines(){
        
        let doTitle = UILabel()
        doTitle.text = "Do"
        
        stackContentView.addArrangedSubview(doTitle)
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.axis = .Vertical
        stack.layoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        let pass = DatabaseController.sharedControl.getPassport()

        for rule in (pass.figure?.figureRules)! {
            if rule.do_or_dont {
                let label = UILabel()
                label.text = rule.text
                label.numberOfLines = 0
                stack.addArrangedSubview(label)
            }
        }
        
        stackContentView.addArrangedSubview(stack)
        
    }
    
    
    func addDontLines(){
        
        let dontTitle = UILabel()
        dontTitle.text = "Don't"
        stackContentView.addArrangedSubview(dontTitle)
        
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.axis = .Vertical
        stack.layoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        let pass = DatabaseController.sharedControl.getPassport()
        
        for rule in (pass.figure?.figureRules)! {
            if rule.do_or_dont {
                let label = UILabel()
                label.text = rule.text
                label.numberOfLines = 0
                stack.addArrangedSubview(label)
            }
        }
        
        stackContentView.addArrangedSubview(stack)
    }
    
}