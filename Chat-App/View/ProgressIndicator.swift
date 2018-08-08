//
//  ProgressIndicator.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/18/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressHud: NSObject {
    class func showProgressHUD(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor (UIColor.blue)
        SVProgressHUD.setBackgroundColor (UIColor.clear)
        //    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        //    SVProgressHUD.setRingNoTextRadius(20)
        //    SVProgressHUD.setRingThickness(3)
        //    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
    }

    class func hideProgressHUD(){
        SVProgressHUD.dismiss()
    }
}

