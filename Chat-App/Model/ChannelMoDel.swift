//
//  ChannelMoDel.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/23/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation

struct Channel {
    public private(set) var channelName: String!
    public private(set) var channelID: String!
    public private(set) var channelDescription: String!
    var unreadMessagesCount = 0
}
