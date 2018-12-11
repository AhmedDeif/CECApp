//
//  LoginViewViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/8/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var emailErrorImage: UIImageView!
    @IBOutlet weak var passwordErrorImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    weak var activeTextView: UITextField?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        self.view.setBackgroudAsGradient()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        passwordTextfield.delegate = self
        emailTextfield.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func styleView() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        emailContainerView.layer.cornerRadius = 5
        emailErrorImage.layer.masksToBounds = true
        passwordContainerView.layer.cornerRadius = 5
        passwordContainerView.layer.masksToBounds = true
        emailErrorImage.isHidden = true
        passwordErrorImage.isHidden = true
    }
    
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = false
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
         print("Frame size: \(aRect.size)")
        aRect.size.height -= keyboardSize!.height
        print("Active rect size minus keyboard : \(aRect.size.height)")
        print("keyboard height: '\(keyboardSize!.height)")
        
        let activeTextFieldRect: CGRect? = self.view.window?.convert((activeTextView?.frame)!, from: activeTextView)
        
        let maxPoint: CGPoint? = CGPoint(x: (activeTextFieldRect?.maxX)!, y: (activeTextFieldRect?.maxY)! )
         print("Maxpoint: \(maxPoint)")
        if self.activeTextView != nil {
            if (!aRect.contains(maxPoint!)){
                print("Must scroll to make view visible")
                self.scrollView.scrollRectToVisible(activeTextFieldRect!, animated: true)
            }
            
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        let contentInsets: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets

        self.scrollView.isScrollEnabled = true
    }

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextView = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextView = nil
    }

    
    
}


