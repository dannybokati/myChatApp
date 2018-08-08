//
//  ProfileVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/23/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 5.0
        userImage.layer.cornerRadius = userImage.layer.frame.height / 2
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        id.text = "ID: \(UserDataService.instance.id)"
        
        let gestureClose = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeByGesture(_:)))
        backgroundView.addGestureRecognizer(gestureClose)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func closeByGesture(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn == true {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            userName.text = UserDataService.instance.name
            userEmail.text = UserDataService.instance.email
            id.text = "ID: \(UserDataService.instance.id)"
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        MessageService.instance.channels.removeAll()
        MessageService.instance.clearMessages()
        UserDataService.instance.logOut()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.post(name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
