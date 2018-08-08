//
//  RoundedButton.swift
//  Chat-App
//
//  Created by Danny Bokati on 2/6/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

@IBDesignable

class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupview()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupview()
    }
   
    func setupview() {
        self.layer.cornerRadius = cornerRadius
    }
}
