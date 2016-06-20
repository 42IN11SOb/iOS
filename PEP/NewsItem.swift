//
//  NewsItem.swift
//  PEP
//
//  Created by Corina Nibbering on 24-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit


class NewsItem: NSObject {
    // MARK: Properties
    var title: String = ""
    var content: String = ""
    var publish: Bool = false
    
    func getContent() -> NSAttributedString{
        let attributedString = try! NSAttributedString(data: self.content.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: false)!,
                                                       options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                       documentAttributes: nil)
        
        return attributedString
    }
    
    
}