//
//  UserDefaults.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/18/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation

enum UDKey: String {
    case UserID = "UserID"
    case Name = "Name"
    case Email = "Email"
    case AvatarName = "AvatarName"
    case AvatarColor = "AvatarColor"
    case IsLoggedIn = "IsLoggedIn"
    
}

struct UserDefaultsHandler {
    
    let userDefault = UserDefaults.standard
    
    func setToUD(key: String, value: AnyObject) {
        self.userDefault.setValue(value, forKeyPath: key)
        self.userDefault.synchronize()
    }
    
    func setDataUD(key:String,value:AnyObject) {
        self.userDefault.set(value, forKey: key)
        self.userDefault.synchronize()
    }
    
    func removeUD(key: String) {
        self.userDefault.removeObject(forKey: key)
    }
    
    func getUDValue(key:String) -> AnyObject? {
        return self.userDefault.value(forKey: key) as AnyObject?
    }
    
   
    
    
}
