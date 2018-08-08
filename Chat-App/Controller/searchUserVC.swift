//
//  searchUserVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/31/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

class searchUserVC: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 5.0
        searchButton.layer.cornerRadius = searchButton.layer.frame.height / 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchUserVC.backgroundTapped(_:)))
        bgView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @objc func backgroundTapped(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var searchButtonAction: UIButton!
    
    @IBAction func searchAction(_ sender: Any) {
        if idField.text != "" {
            AuthService.instance.findUserById(id: idField.text!, completion: { (success) in
                if success {
                    if self.idField.text != UserDataService.instance.id{
                        print("User Found!")
                        self.showToast(message: "User Found")
                        let addSearchedUserVC = AddUserVC()
                        addSearchedUserVC.modalPresentationStyle = .custom
                        self.present(addSearchedUserVC, animated: true, completion: nil)
                    }
                } else {
                    print("Finding User Failed!")
                }
            }, viewController: self)
        }
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
