//
//  CreateAccountVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 12/25/17.
//  Copyright © 2017 Gtech Developeres. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController, AvatarDelegate {
    var imageName: String?
    
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    
    //Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImg.layer.cornerRadius = userImg.layer.frame.height / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if imageName != nil {
            userImg.image = UIImage(named: imageName!)
        }
    }
   
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let username = usernameTxt.text, usernameTxt.text != "" else {return}
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: pass, completion: { (success) in
            if success {
                print("registered")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                     print("logged In")
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.imageName == nil ? self.avatarName : self.imageName!, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print ("everything went right")
                                print(UserDataService.instance.email, UserDataService.instance.name)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                NotificationCenter.default.post(name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
                                self.performSegue(withIdentifier: "unwindSegue", sender: nil)
                                
                            } else {
                                print("you are not suppposed to see this")
                            }
                        }, viewController: self)
                    }
                }, viewController: self)
            }
        }, viewController: self)
        
        
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    @IBAction func pickBackgroudColorPressed(_ sender: Any) {
        let randomColor: CGFloat = .random()
        let randomColor2: CGFloat = .random()
        let randomColor3: CGFloat = .random()
        avatarColor = "[\(randomColor), \(randomColor2), \(randomColor3), 1]"
        userImg.backgroundColor = UIColor(red: randomColor, green: randomColor2, blue: randomColor3, alpha: 1.0)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseAvatarSegue" {
            let vc : AvatarPickerVC = segue.destination as! AvatarPickerVC
            vc.delegate = self
        }
    }
    

}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
