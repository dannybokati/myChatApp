//
//  AddUserVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/31/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

class AddUserVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var addUserButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 5.0
        addUserButton.layer.cornerRadius = addUserButton.layer.frame.height / 2
        userImage.image = UIImage(named: (AuthService.instance.searchedUser.avatarName))
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: (AuthService.instance.searchedUser.avatarColor))
        userImage.layer.cornerRadius = userImage.layer.frame.height / 2
        userName.text = AuthService.instance.searchedUser.userName
        email.text = AuthService.instance.searchedUser.email
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddUserVC.backgroundTapped(_:)))
        bgView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @objc func backgroundTapped(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addUserAction(_ sender: Any) {
        let channelName = "$$$%\(UserDataService.instance.name).\(AuthService.instance.searchedUser.userName).$$$"
        let channelDescription = "userType"
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription, completion: { (success) in
            if success{
                self.showToast(message: "User Added Successfully!")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showToast(message: "Adding User Failed!")
                self.dismiss(animated: true, completion: nil)
            }
            
        }, viewController: self)
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
