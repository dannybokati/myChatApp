//
//  PGDeviceDetector.swift
//
//  Created by Prashant Ghimire on 10/3/17.
//  Copyright © 2017 prashant.ghimire@gmail.com. All rights reserved.
//

import Foundation
import  UIKit

struct PGScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(PGScreenSize.SCREEN_WIDTH, PGScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(PGScreenSize.SCREEN_WIDTH, PGScreenSize.SCREEN_HEIGHT)
}

struct PGDeviceDetector
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && PGScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && PGScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && PGScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && PGScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && PGScreenSize.SCREEN_MAX_LENGTH == 812
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && PGScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && PGScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct PGiOSVersion{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (PGiOSVersion.SYS_VERSION_FLOAT < 8.0 && PGiOSVersion.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (PGiOSVersion.SYS_VERSION_FLOAT >= 8.0 && PGiOSVersion.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (PGiOSVersion.SYS_VERSION_FLOAT >= 9.0 && PGiOSVersion.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (PGiOSVersion.SYS_VERSION_FLOAT >= 10.0 && PGiOSVersion.SYS_VERSION_FLOAT < 11.0)
    static let iOS11 = (PGiOSVersion.SYS_VERSION_FLOAT >= 11.0 && PGiOSVersion.SYS_VERSION_FLOAT < 12.0)
}

