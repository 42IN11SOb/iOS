//
//  ColorViewPageController.swift
//  PEP
//
//  Created by Corina Nibbering on 20-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation


import UIKit

class ColorPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageColors: [PassportColor] = []
    var selectedIndex : Int?
    
    var selectedColor: PassportColor? {
        didSet{
            configureView()
        }
    }
    
    func configureView(){
        
        if pageColors.count > 0 {
            let pageContentViewController = self.viewControllerAtIndex(selectedIndex!)
            
            if let pageContentViewController  = pageContentViewController {
                self.setViewControllers([pageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        
        dataSource = self
    
        configureView()
        stylePageControl()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        configureView()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
        // MARK: - PageControl (dots)
    
    private func stylePageControl() {
        let pageControl = UIPageControl.appearanceWhenContainedInInstancesOfClasses([self.dynamicType])
        
        pageControl.currentPageIndicatorTintColor = hightlightColor
        pageControl.pageIndicatorTintColor = whiteColor
        pageControl.backgroundColor = blackColor
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageColors.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        self.title = self.pageColors[selectedIndex!].colorName
        return selectedIndex!
    }
    
        // MARK: - Delegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
        let colorController : ColorViewController = viewController as! ColorViewController
        var index = colorController.pageIndex!

        index += 1
        if(index >= self.pageColors.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
        let colorController : ColorViewController = viewController as! ColorViewController
        var index = colorController.pageIndex!
        if(index <= 0){
            return nil
        }
        index -= 1

        return self.viewControllerAtIndex(index)
    
    }
   
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((self.pageColors.count == 0) || (index >= self.pageColors.count)) {
            return nil
        }
        
        let colorPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ColorViewController") as! ColorViewController
        
        colorPageViewController.selectedColor = pageColors[index]
        colorPageViewController.pageIndex = index
        
        
        return colorPageViewController
    }
    
    
}

