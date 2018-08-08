//
//  ChannelVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 12/24/17.
//  Copyright © 2017 Gtech Developeres. All rights reserved.
//

import UIKit

@IBDesignable
class ChannelVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var channelUserSelectionTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogo.layer.cornerRadius = userLogo.layer.frame.height / 2
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userLogo.image = UIImage(named: UserDataService.instance.avatarName)
            userLogo.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            tableView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.unreadMessageFound(_:)), name: NOTIF_UNREAD_MESSAGE_FOUND, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelDataDidChange(_:)), name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
        SocketService.instance.getChannel(completion: { (success) in
            if success {
                self.tableView.reloadData()
            }
        }, viewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            if segmentControl.selectedSegmentIndex == 1 {
                let searchVC = searchUserVC()
                searchVC.modalPresentationStyle = .custom
                present(searchVC, animated: true, completion: nil)
            } else {
                let addChannelVC = CreateChannel()
                addChannelVC.modalPresentationStyle = .custom
                present(addChannelVC, animated: true, completion: nil)
            }
        }
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }
    @objc func userDataDidChange(_ notif: Notification) {
        
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userLogo.image = UIImage(named: UserDataService.instance.avatarName)
            userLogo.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userLogo.image = UIImage(named: "menuProfileIcon")
            userLogo.backgroundColor = UIColor.clear
        }
    }
    
    @objc func channelDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            MessageService.instance.channels.removeAll()
            MessageService.instance.findAllChannels(completion: { (success) in
                if success {
                    self.tableView.reloadData()
                } else {
                    print("Reloading Channels Failed")
                }
            }, viewController: self)
        } else {
            MessageService.instance.channels.removeAll()
            tableView.reloadData()
        }
    }
    
    @objc func unreadMessageFound(_ notif: Notification) {
        tableView.reloadData()
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            channelUserSelectionTitle.text = "Channels"
            break;
        case 1:
            channelUserSelectionTitle.text = "Users"
            break
        default:
            channelUserSelectionTitle.text = "Channels"
            break;
        }
        tableView.reloadData()
    }
    //MARK: Channel Datasource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as! ChannelCell
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if UserDataService.instance.checkChannelIsUserType(channelName: (MessageService.instance.channels[indexPath.row].channelName)) != true {
                cell.isYourfriend = false
                cell.setupCell(channel: MessageService.instance.channels[indexPath.row])
                return cell
            }
            break;
        case 1:
            if UserDataService.instance.checkChannelIsUserType(channelName: (MessageService.instance.channels[indexPath.row].channelName)) == true {
                if UserDataService.instance.channelContainsYourName(channelName: (MessageService.instance.channels[indexPath.row].channelName)) == true {
                    cell.isYourfriend = true
                cell.setupCell(channel: MessageService.instance.channels[indexPath.row])
                return cell
                }
            }
            break;
        default:
            if UserDataService.instance.checkChannelIsUserType(channelName: (MessageService.instance.channels[indexPath.row].channelName)) != true {
                cell.isYourfriend = false
                cell.setupCell(channel: MessageService.instance.channels[indexPath.row])
                return cell
            }
            break;
        }
        let fakeCell = UITableViewCell()
        fakeCell.backgroundColor = UIColor.clear
        return fakeCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if UserDataService.instance.checkChannelIsUserType(channelName: (MessageService.instance.channels[indexPath.row].channelName)) != true {
                return 40
            } else {
                return 0
            }
            break;
        case 1:
            if UserDataService.instance.checkChannelIsUserType(channelName: (MessageService.instance.channels[indexPath.row].channelName)) == true {
                if UserDataService.instance.channelContainsYourName(channelName: (MessageService.instance.channels[indexPath.row].channelName)) == true {
                return 40
                } else {
                    return 0
                }
            } else {
                return 0
            }
            break;
        default:
            if UserDataService.instance.checkChannelIsUserType(channelName: (MessageService.instance.channels[indexPath.row].channelName)) != true {
                return 40
            } else {
                return 0
            }
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SECLECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
    }
}
