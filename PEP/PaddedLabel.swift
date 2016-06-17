//
//  PaddedLabel.swift
//  PEP
//
//  Created by Corina Nibbering on 07-06-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//


import UIKit
class PaddedLabel: UILabel {


    var edgeInsets = UIEdgeInsetsZero {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, edgeInsets), limitedToNumberOfLines: 5)
        
        rect.origin.x -= edgeInsets.left + 10
        rect.origin.y -= edgeInsets.top
        rect.size.width  -= (edgeInsets.left + edgeInsets.right);
        rect.size.height += (edgeInsets.top + edgeInsets.bottom) + 40;
        
        return rect
    }
    
    override func drawTextInRect(rect: CGRect) {
        
        var edge = edgeInsets;
        edge.bottom = edgeInsets.bottom+20;
        edge.top = edgeInsets.top + 20;
        edge.right = edgeInsets.right + 40;
        edge.left = edgeInsets.left + 20;
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, edge))
    }
}