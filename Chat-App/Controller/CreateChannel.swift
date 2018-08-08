//
//  CreateChannel.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/24/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

class CreateChannel: UIViewController {

    @IBOutlet weak var addChannelBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var channelDescriptionTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var channelNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addChannelBtn.layer.cornerRadius = addChannelBtn.layer.frame.height / 2
        contentView.layer.cornerRadius = 5.0
        let bgTapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateChannel.backgroundTapped(_:)))
        backgroundView.addGestureRecognizer(bgTapGesture)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backgroundTapped(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addChannelTapped(_ sender: Any) {
        
        
        
        print(channelNameTextField.text)
        print(channelDescriptionTextField.text)
        guard let channelNameUnwrapped = channelNameTextField.text else {return}
        guard let channelDescriptionUnwrapped = channelDescriptionTextField.text else {return}
        SocketService.instance.addChannel(channelName: channelNameUnwrapped, channelDescription: channelDescriptionUnwrapped, completion: { (success) in
            if success {
                print("added")
                self.dismiss(animated: true, completion: nil)
            }
        }, viewController: self)
//        MessageService.instance.addNewChannel(channelName: channelNameUnwrapped, channelDescription: channelDescriptionUnwrapped) { (success) in
//            if success {
//                print("Channed Added.")
//                NotificationCenter.default.post(name: NOTIF_CHANNEL_DATA_DID_CHANGE, object: nil)
//                self.dismiss(animated: true, completion: nil)
//            } else {
//                print("Adding channel failed.")
//            }
//        }
    }
    

}
