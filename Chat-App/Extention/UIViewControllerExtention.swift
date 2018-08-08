//
//  UIViewControllerExtention.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/30/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation
import  UIKit
import TTGSnackbar

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    func showAlert(message: String? = nil, title: String? = nil,buttonTitle:String? = nil,buttonStyle: UIAlertActionStyle = .cancel,withCompletion completion:@escaping ()->() = {}) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle ?? "OK", style:buttonStyle, handler: { action in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func showToast(message: String){
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        snackbar.show()
    }
    
    
}

