//
//  ChannelCell.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/24/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var channelLabel: UILabel!
    
    var isYourfriend: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        // Configure the view for the selected state
    }
    
    func setupCell(channel: Channel) {
        guard let channelName = channel.channelName else {return}
        
        if isYourfriend != true{
            if channel.unreadMessagesCount > 1 {
                channelLabel.text = "#\(channelName) - (\(String(channel.unreadMessagesCount)) new messages)"
                channelLabel.textColor = UIColor.blue
            } else if channel.unreadMessagesCount == 1 {
                channelLabel.text = "#\(channelName) - (\(String(channel.unreadMessagesCount)) new message)"
                channelLabel.textColor = UIColor.blue
            }
            else {
                channelLabel.text = "#\(channelName)"
                channelLabel.textColor = UIColor.white
            }
        } else {
            
            if channel.unreadMessagesCount > 1 {
                channelLabel.text = "@ \(UserDataService.instance.returnOtherUsersNameFromChannelName(channelName: channelName)) - (\(String(channel.unreadMessagesCount)) new messages)"
                channelLabel.textColor = UIColor.blue
            } else if channel.unreadMessagesCount == 1 {
                channelLabel.text = "@ \(UserDataService.instance.returnOtherUsersNameFromChannelName(channelName: channelName)) - (\(String(channel.unreadMessagesCount)) new message)"
                channelLabel.textColor = UIColor.blue
            }
            else {
                channelLabel.text = "@ \(UserDataService.instance.returnOtherUsersNameFromChannelName(channelName: channelName))"
                channelLabel.textColor = UIColor.white
            }
            
        }
        
        
    }
    
}
