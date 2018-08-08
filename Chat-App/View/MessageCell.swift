//
//  MessageCell.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/28/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.dataDetectorTypes = .link
        textView.text = message.message
        
        userImage.layer.cornerRadius = userImage.layer.frame.height / 2
        messageLabel.text = message.message
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        userNameLabel.text = message.userName
        
        var weekdayString: String = ""
        let messageDate = Utility.stringToDate(date: message.timeStamp)
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: messageDate as! Date)
        var hour = (calendar.component(.hour, from: messageDate as! Date))
        let minute = (calendar.component(.minute, from: messageDate as! Date))
        var time = "AM"
        if hour > 12 {
            hour = hour - 12
            time = "PM"
        }
        switch weekday {
        case 1:
            weekdayString = "Sun"
            break;
        case 2:
            weekdayString = "Mon"
            break;
        case 3:
            weekdayString = "Tue"
            break;
        case 4:
            weekdayString = "Wed"
            break;
        case 5:
            weekdayString = "Thu"
            break;
        case 6:
            weekdayString = "Fri"
            break;
        case 7:
            weekdayString = "Sat"
            break;
        default:
            weekdayString = ""
            break;
        }
        if minute < 10 {
        timeLabel.text = "\(weekdayString) \(String(hour)):0\(String(minute)) \(time)"
        } else {
            timeLabel.text = "\(weekdayString) \(String(hour)):\(String(minute)) \(time)"
        }
        
    }

}
