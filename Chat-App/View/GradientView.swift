//
//  GradientView.swift
//  Chat-App
//
//  Created by Danny Bokati on 12/24/17.
//  Copyright © 2017 Gtech Developeres. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {

    @IBInspectable var topcolor: UIColor = #colorLiteral(red: 0.3803921569, green: 0.262745098, blue: 0.5215686275, alpha: 1)
    @IBInspectable var bottomcolor: UIColor = #colorLiteral(red: 0.3176470588, green: 0.3882352941, blue: 0.5843137255, alpha: 1)
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topcolor.cgColor, bottomcolor.cgColor]
        gradientLayer.frame = self.bounds
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.locations = [0.0,0.5,1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    

}
