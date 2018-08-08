//
//  Constants.swift
//  Chat-App
//
//  Created by Danny Bokati on 1/26/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://chat-app-dannybokati.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_CREATEUSER = "\(BASE_URL)user/add"
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail"
let URL_ALL_CHANNELS = "\(BASE_URL)channel"
let URL_ADD_CHANNEL = "\(BASE_URL)channel/add"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"
let URL_FIND_USER_BY_ID = "\(BASE_URL)user"

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNEL_DATA_DID_CHANGE = Notification.Name("notifChannelDataChanged")
let NOTIF_CHANNEL_SECLECTED = Notification.Name("notificationChannelSelected")
let NOTIF_UNREAD_MESSAGE_FOUND = Notification.Name("notificationUnreadMessageFound")

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
    
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToke)"
]

let NORMAL_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToke)",
    "Content-Type":"application/json; charset=utf-8" ]
