//
//  CustomInsetLabel.swift
//  Cigna
//
//  Created by Karunakar Bandikatla on 7/11/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import UIKit

class CustomInsetLabel: UILabel {
   
    let topInset = CGFloat(0.0), bottomInset = CGFloat(0.0), leftInset = CGFloat(10.0), rightInset = CGFloat(0.0)
    
    override func drawTextInRect(rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }

}