//
//  ChatVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 12/24/17.
//  Copyright © 2017 Gtech Developeres. All rights reserved.
//

import UIKit
import UserNotifications

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var titleGradientView: GradientView!
    @IBOutlet weak var welcomeScreen: UIView!
    @IBOutlet weak var typingUsersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var MenuBtn: UIButton!
    
    // Variables
    
    var isTyping: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        sendButton.isHidden = true
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        MenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if error != nil {
                print("Authorization Unsuccessfull")
            }else {
                print("Authorization Successfull")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SECLECTED, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        SocketService.instance.getChatMessage(completion: { (success) in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }, viewController: self)
        
        SocketService.instance.getTypingUsers { (typingusers) in
            guard let channelId = MessageService.instance.selectedChannel?.channelID else {return}
            var names = ""
            var numberOfTypers = 0
            
            for (typinguser, channel) in typingusers {
                if (typinguser != UserDataService.instance.name) && channel == channelId {
                    if names == "" {
                        names = typinguser
                    } else {
                        names = "\(names), \(typinguser)"
                    }
                    numberOfTypers += 1
                }
            }
            if (numberOfTypers > 0) && (AuthService.instance.isLoggedIn == true){
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLabel.text = "\(names) \(verb) typing a message..."
            } else {
                self.typingUsersLabel.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn {
            welcomeScreen.isHidden = true
            AuthService.instance.findUserByEmail(email: AuthService.instance.userEmail, completion: { (success) in
                MessageService.instance.findAllChannels(completion: { (success) in
                    print("Channels Initialised")
                    if MessageService.instance.channels.count > 0 {
                        MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                        self.updateWithChannel()
                    } else {
                        self.titleLabel.text = "No Channels Yet!"
                    }
                }, viewController: self)
            }, viewController: self)
        } else {
            welcomeScreen.isHidden = false
            titleLabel.text = "Chat-App"
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
//        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
//        NotificationCenter.default.post(name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelDataDidChange(_:)), name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
        
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    @objc func channelSelected (_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        var i = 0
        for channel in MessageService.instance.channels{
            if channel.channelID == MessageService.instance.selectedChannel.channelID {
                MessageService.instance.channels[i].unreadMessagesCount = 0
                NotificationCenter.default.post(name: NOTIF_UNREAD_MESSAGE_FOUND, object: nil)
            }
            i += 1
        }
        MessageService.instance.selectedChannel.unreadMessagesCount = 0
        let channelName = MessageService.instance.selectedChannel?.channelName ?? ""
        if UserDataService.instance.checkChannelIsUserType(channelName: channelName) {
            titleLabel.text = UserDataService.instance.returnOtherUsersNameFromChannelName(channelName: channelName)
        } else {
        titleLabel.text = "#\(channelName)"
        }
        getMessages()
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            welcomeScreen.isHidden = true
            onLoginGetMessages()
           
        } else {
            welcomeScreen.isHidden = false
            titleLabel.text = "Chat-App"
            tableView.reloadData()
        }
        
    }
    
    @objc func channelDataDidChange(_ notif: Notification) {
    }
    
//    func onLoginGetMessages() {
//        titleLabel.text = "Logged In"
//        AuthService.instance.findUserByEmail(email: AuthService.instance.userEmail, completion: { (success) in
//            print("User data loaded")
//            if MessageService.instance.channels.count > 0 {
//                MessageService.instance.selectedChannel = MessageService.instance.channels[0]
//                self.updateWithChannel()
//            } else {
//                self.titleLabel.text = "No Channels Yet!"
//            }
//        })
//    }
    
    func onLoginGetMessages() {
        titleLabel.text = "Logged In"
        AuthService.instance.findUserByEmail(email: AuthService.instance.userEmail, completion: { (success) in
            print("User data loaded")
            MessageService.instance.findAllChannels(completion: { (success) in
                if success {
                    if MessageService.instance.channels.count > 0 {
                        MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                        self.updateWithChannel()
                    } else {
                        self.titleLabel.text = "No Channels Yet!"
                    }
                }
            }, viewController: self)
            
        }, viewController: self)
    }
    
    func getMessages() {
        guard let selectedChannelId = MessageService.instance.selectedChannel?.channelID else {return}
        MessageService.instance.getAllMessagesForChannel(channelID: selectedChannelId, completion: { (success) in
            if success {
            print("Chat VC Loaded.")
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
                
            } else {
                print("Something went wrong!")
            }
        }, viewcontroller: self)
    }
    
    @IBAction func editingChangedAction(_ sender: Any) {
        if messageTextField.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.stoppedTyping()
        } else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.startedTyping()
            }
            isTyping = true
        }
    }
    @IBAction func messageSendAction(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.channelID else {return}
            guard let message = messageTextField.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channeId: channelId, completion: { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                } else {
                    print("Sending Message Failed!")
                }
                SocketService.instance.stoppedTyping()
            }, viewController: self)
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}
