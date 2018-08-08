//
//  MessageDataService.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/23/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    var messages = [Message]()
    
    var selectedChannel: Channel!
    
    func findAllChannels(completion: @escaping CompletionHandler, viewController: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewController)
        ProgressHud.showProgressHUD()
        print(URL_ALL_CHANNELS)
        print(BEARER_HEADER)
        Alamofire.request(URL_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                print(response)
                // MARK: to remove
                self.channels.removeAll()
                guard let data = response.data else {return}
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let description = item["description"].stringValue
                        let channelName = item["name"].stringValue
                        
                        let channel = Channel(channelName: channelName, channelID: id, channelDescription: description, unreadMessagesCount: 0)
                        self.channels.append(channel)
                    }
                }

                ProgressHud.hideProgressHUD()
                completion(true)
            } else {
                ProgressHud.hideProgressHUD()
                completion(false)
                debugPrint(response.result.error as Any)
                viewController.showToast(message: "Finding Channels Failed!")
            }
        }
    }
    
    func addNewChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler, viewController: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewController)
        ProgressHud.showProgressHUD()
        
        let body = [
            "name": channelName,
            "description": channelDescription
        ]
        
        Alamofire.request(URL_ADD_CHANNEL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: NORMAL_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                print(response)
                ProgressHud.hideProgressHUD()
                completion(true)
            } else {
                ProgressHud.hideProgressHUD()
                completion(false)
                debugPrint(response.result.error as Any)
                viewController.showToast(message: "Adding Channel Failed!")
            }
        }
        
    }
    
    func getAllMessagesForChannel(channelID: String, completion: @escaping CompletionHandler, viewcontroller: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewcontroller)
        ProgressHud.showProgressHUD()
        
        Alamofire.request("\(URL_GET_MESSAGES)/\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                print(response)
                guard let data = response.data else {return}
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let message = item["messageBody"].stringValue
                        let userID = item["userId"].stringValue
                        let channelID = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let avatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let individualMessage = Message(message: message, userName: userName, channelID: channelID, userAvatar: userAvatar, userAvatarColor: avatarColor, id: id, timeStamp: timeStamp, userID: userID)
                        self.messages.append(individualMessage)
                        
                    }
                }
                ProgressHud.hideProgressHUD()
                completion(true)
                
            } else {
                ProgressHud.hideProgressHUD()
                completion(false)
                debugPrint(response.result.error as Any)
                viewcontroller.showToast(message: "Fetching Messages Failed")
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    
}
