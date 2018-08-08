//
//  UserDataService.swift
//  Chat-App
//
//  Created by Danny Bokati on 2/10/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""

    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
        
    }
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
        
    }
    
    func checkChannelIsUserType(channelName: String) -> Bool {
        
        let scanner = Scanner(string: channelName)
        let percentage = CharacterSet(charactersIn: "%")
        
        var checkString: NSString?
        scanner.scanUpToCharacters(from: percentage, into: &checkString)
        
        let defaultValue = false
        
        guard let checkStringUnwrapped = checkString else {return defaultValue}
        
        let checkValue = checkStringUnwrapped as String
        
        if checkValue == "$$$" {
            return true
        } else {
            return false
        }
    }
    
    func channelContainsYourName(channelName: String) -> Bool {
        print(channelName)
        let scanner = Scanner(string: channelName)
        let skipped = CharacterSet(charactersIn: "$%.")
        let period = CharacterSet(charactersIn: ".")
        scanner.charactersToBeSkipped = skipped
        
        var firstUser, secondUser : NSString?
        scanner.scanUpToCharacters(from: period, into: &firstUser)
        scanner.scanUpToCharacters(from: period, into: &secondUser)
        
        print(firstUser)
        print(secondUser)
        
        let defaultUser = false
        
        guard let firstUserUnwrapped = firstUser else {return defaultUser}
        guard let secondUserUnwrapped = secondUser else {return defaultUser}
        
        let firstStringUser = firstUserUnwrapped as String
        let secongStringUser = secondUserUnwrapped as String
        
        print(firstStringUser)
        print(secongStringUser)
        
        if (firstStringUser == UserDataService.instance.name) || (secongStringUser == UserDataService.instance.name) {
            return true
        } else {
            return false
        }
    }
    
    func returnOtherUsersNameFromChannelName(channelName: String) -> String {
        let scanner = Scanner(string: channelName)
        let skipped = CharacterSet(charactersIn: "$%.")
        let period = CharacterSet(charactersIn: ".")
        scanner.charactersToBeSkipped = skipped
        
        var firstUser, secondUser : NSString?
        scanner.scanUpToCharacters(from: period, into: &firstUser)
        scanner.scanUpToCharacters(from: period, into: &secondUser)
        
        print(firstUser)
        print(secondUser)
        
        let defaultUser = ""
        
        guard let firstUserUnwrapped = firstUser else {return defaultUser}
        guard let secondUserUnwrapped = secondUser else {return defaultUser}
        
        let firstStringUser = firstUserUnwrapped as String
        let secongStringUser = secondUserUnwrapped as String
        
        print(firstStringUser)
        print(secongStringUser)
        
        if firstStringUser == UserDataService.instance.name {
            return secongStringUser
        } else if secongStringUser == UserDataService.instance.name {
            return firstStringUser
        } else {
            return defaultUser
        }
    }
    
    func returnUsersFromChannelName(channelName: String) -> [String] {
        let scanner = Scanner(string: channelName)
        let skipped = CharacterSet(charactersIn: "$%.")
        let period = CharacterSet(charactersIn: ".")
        scanner.charactersToBeSkipped = skipped
        
        var firstUser, secondUser : NSString?
        scanner.scanUpToCharacters(from: period, into: &firstUser)
        scanner.scanUpToCharacters(from: period, into: &secondUser)
        
        let defaultUser = ["default1", "default2"]
        
        guard let firstUserUnwrapped = firstUser else {return defaultUser}
        guard let secondUserUnwrapped = secondUser else {return defaultUser}
        
        let firstStringUser = firstUserUnwrapped as String
        let secongStringUser = secondUserUnwrapped as String
        
        return [firstStringUser, secongStringUser]
    }
    
    func logOut() {
        self.avatarColor = ""
        self.avatarName = ""
        self.email = ""
        self.name = ""
        self.id = ""
        AuthService.instance.authToke = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
    }
}
