//
//  SocketService.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/24/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit
import SocketIO
import UserNotifications

let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
let socket = manager.defaultSocket

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler, viewController: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewController)
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel (completion: @escaping CompletionHandler, viewController: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewController)
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channeName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[1] as? String else {return}
            guard let id = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelName: channeName, channelID: id, channelDescription: channelDescription, unreadMessagesCount: 0)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channeId: String, completion: @escaping CompletionHandler, viewController: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewController)
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channeId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    
    func getChatMessage(completion: @escaping CompletionHandler, viewController: UIViewController) {
        AuthService.instance.checkConnection(viewController: viewController)
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timestamp = dataArray[7] as? String else {return}
            
            if (channelId == MessageService.instance.selectedChannel?.channelID) && AuthService.instance.isLoggedIn {
                let newMessage = Message(message: messageBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timestamp, userID: "")
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                var i = 0
                for channel in MessageService.instance.channels {
                    if channel.channelID == channelId {
                        MessageService.instance.channels[i].unreadMessagesCount += 1
                        NotificationCenter.default.post(name: NOTIF_UNREAD_MESSAGE_FOUND, object: nil)
                    }
                    i += 1
                }
                completion(false)
            }
        }
    }
    
    func sendNotification(message: String, channelId: String, userName: String) {
        timedNotifications(inSeconds: 1, title: "New Message", subtitle: userName, body: message) { (success) in
            if success {
                print("Notification Sent Successfully")
            }
        }
        
    }
    
    func timedNotifications(inSeconds: TimeInterval, title: String, subtitle: String, body: String, completion: @escaping (_ Success: Bool) -> ()) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.subtitle = subtitle
        content.body = body
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            }else {
                completion(true)
            }
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else {return}
            completionHandler(typingUsers)
        }
    }
    
    func startedTyping() {
        guard let channelId = MessageService.instance.selectedChannel?.channelID else {return}
        socket.emit("startType", UserDataService.instance.name, channelId)
    }
    
    func stoppedTyping() {
        guard let channelId = MessageService.instance.selectedChannel?.channelID else {return}
        socket.emit("stopType", UserDataService.instance.name, channelId)
    }
    
    
}
