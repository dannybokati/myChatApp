//
//  FontExtension.swift
//
//  Created by Prashant Ghimire on 10/9/17.
//  Copyright © 2017 prashant.ghimire@gmail.com. All rights reserved.
//

import UIKit
enum FontType : Int{
    case MainTitle = 0, CategoryTitle = 1 , Header = 2, Content = 3,SmallText = 4,Button = 5, Default = 6, SmallButton = 7
    
    
//    UIFont(name: "Bariol-Bold", size: 18)
    var customFont : UIFont {
        switch self{
        // MARK:- LargeTitle
        case .MainTitle :
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont(name: "Avenir-Heavy", size: 14)!
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont(name: "Avenir-Heavy", size: 18)!
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont(name: "Avenir-Heavy", size: 19)!
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont(name: "Avenir-Heavy", size: 20)!
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont(name: "Avenir-Heavy", size: 19)!
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont(name: "Avenir-Heavy", size: 22)!
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont(name: "Avenir-Heavy", size: 22)!
            }else{
                return UIFont(name: "Avenir-Heavy", size: 22)!
            }
        // MARK:- Title
        case .CategoryTitle :
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont(name: "Avenir-Medium", size: 12)!
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont(name: "Avenir-Medium", size: 14)!
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont(name: "Avenir-Medium", size: 18)!
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont(name: "Avenir-Medium", size: 18)!
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont(name: "Avenir-Medium", size: 18)!
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont(name: "Avenir-Medium", size: 18)!
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont(name: "Avenir-Medium", size: 18)!
            }else{
                return UIFont(name: "Avenir-Medium", size: 18)!
            }
        // MARK:- Headline
        case .Header :
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont(name: "Avenir-Heavy", size: 13)!
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont(name: "Avenir-Heavy", size: 15)!
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont(name: "Avenir-Heavy", size: 16)!
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont(name: "Avenir-Heavy", size: 17)!
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont(name: "Avenir-Heavy", size: 16)!
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont(name: "Avenir-Heavy", size: 18)!
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont(name: "Avenir-Heavy", size: 18)!
            } else{
                return UIFont(name: "Avenir-Heavy", size: 18)!
            }
        // MARK:- Footnote
        case .Content:
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont(name: "Avenir", size: 10)!
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont(name: "Avenir", size: 13)!
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont(name: "Avenir", size: 15)!
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont(name: "Avenir", size: 16)!
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont(name: "Avenir", size: 15)!
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont(name: "Avenir", size: 16)!
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont(name: "Avenir", size: 16)!
            } else{
                return UIFont(name: "Avenir", size: 16)!
            }
        // MARK:- Footnote
        case .SmallText :
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont.systemFont(ofSize: 6)
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont.systemFont(ofSize: 10)
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont.systemFont(ofSize: 12)
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont.systemFont(ofSize: 12)
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont(name: "Avenir", size: 12)!
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont.systemFont(ofSize: 14)
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont.systemFont(ofSize: 14)
            } else{
                return UIFont.systemFont(ofSize: 14)
            }
        // MARK:- Footnote
        case .Button:
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont.systemFont(ofSize: 12)
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont.boldSystemFont(ofSize: 14)
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont.boldSystemFont(ofSize: 16)
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont.boldSystemFont(ofSize: 18)
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont.boldSystemFont(ofSize: 18)
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont.boldSystemFont(ofSize: 20)
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont.boldSystemFont(ofSize: 20)
            }else{
                return UIFont.boldSystemFont(ofSize: 20)
            }
        // MARK:- Footnote
        case .Default:
            
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont.systemFont(ofSize: 10)
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont.systemFont(ofSize: 12)
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont.systemFont(ofSize: 14)
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont.systemFont(ofSize: 16)
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont.systemFont(ofSize: 16)
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont.systemFont(ofSize: 18)
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont.systemFont(ofSize: 18)
            }else{
                return UIFont.systemFont(ofSize: 18)
            }
            // MARK:- Footnote
            
        case .SmallButton :
            if PGDeviceDetector.IS_IPHONE_4_OR_LESS{
                return UIFont.systemFont(ofSize: 10)
            }else if PGDeviceDetector.IS_IPHONE_5{
                return UIFont.systemFont(ofSize: 12)
            }else if PGDeviceDetector.IS_IPHONE_6{
                return UIFont.systemFont(ofSize: 14)
            }else if PGDeviceDetector.IS_IPHONE_6P{
                return UIFont.systemFont(ofSize: 16)
            }else if PGDeviceDetector.IS_IPHONE_X{
                return UIFont.systemFont(ofSize: 16)
            }else if PGDeviceDetector.IS_IPAD{
                return UIFont.systemFont(ofSize: 18)
            }else if PGDeviceDetector.IS_IPAD_PRO{
                return UIFont.systemFont(ofSize: 18)
            }else{
                return UIFont.systemFont(ofSize: 18)
            }
            
        }
    }
    static func getFont(rawValue: Int) -> UIFont  {
        if let fontType = FontType(rawValue: rawValue) {
            return fontType.customFont
        }
        return FontType.Default.customFont
    }
}

extension UILabel {
    @IBInspectable var textFont: Int{
        set{
            self.font = FontType.getFont(rawValue: newValue)
        }
        get{
            return 0
        }
    }
    
}

extension UITextField {
    @IBInspectable var textFont: Int{
        set{
            self.font = FontType.getFont(rawValue: newValue)
        }
        get{
            return 0
        }
    }
    
    
}
extension UIButton {
    @IBInspectable var textFont: Int{
        set{
            self.titleLabel!.font  = FontType.getFont(rawValue: newValue)
        }
        get{
            return 0
        }
    }
}

