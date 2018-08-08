//
//  LoginVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 12/25/17.
//  Copyright © 2017 Gtech Developeres. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

  
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

 
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = emailTextField.text, emailTextField.text != "" else {return}
        guard let password = passwordTextField.text, passwordTextField.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
            if success {
                print("logged In")
                AuthService.instance.findUserByEmail(email: AuthService.instance.userEmail, completion: { (success) in
                    if success {
                        print("Data Initialised")
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        NotificationCenter.default.post(name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
                        self.performSegue(withIdentifier: "unwindSegue", sender: nil)
                    }
                }, viewController: self)
            }
        }, viewController: self)
    }
    @IBOutlet weak var closeBtn: UIButton!
    
   
    @IBAction func closeBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn == true {
         performSegue(withIdentifier: "unwindSegue", sender: nil)
        }
        else{
            print("Please Login First")
        }
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateAccount", sender: nil)
    }
}
