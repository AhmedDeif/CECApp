//
//  LoginViewViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/8/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import Toast_Swift

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
    var viewModel = LoginViewModel()
    
    var shouldPasswordResetMessage = false
    var passwordResetMessage: String = ""
    
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
        if self.shouldPasswordResetMessage {
            self.view.makeToast(self.passwordResetMessage)
        }
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
        passwordTextfield.isSecureTextEntry = true
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
        aRect.size.height -= keyboardSize!.height
        
        let activeTextFieldRect: CGRect? = self.view.window?.convert((activeTextView?.frame)!, from: activeTextView)
        
        let maxPoint: CGPoint? = CGPoint(x: (activeTextFieldRect?.maxX)!, y: (activeTextFieldRect?.maxY)! )
        if self.activeTextView != nil {
            if (!aRect.contains(maxPoint!)){
                self.scrollView.scrollRectToVisible(activeTextFieldRect!, animated: true)
            }
        }
    }
    
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        //Once keyboard disappears, restore original positions
        let contentInsets: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets

        self.scrollView.isScrollEnabled = true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if self.validateFields() {
            self.startAnimating()
            viewModel.login(username: emailTextfield.text!, password: passwordTextfield.text!) { (loginAuthorised, error) in
                self.stopAnimating()
                if loginAuthorised {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(vc, animated: true, completion: nil)
                }
                else {
                    self.showError(textfield: self.passwordTextfield, error: error!)
                }
            }
        }
    }
    
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextView = textField
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.validateFields()
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextView = nil
    }
    
    
    func validateFields() -> Bool {
        var allFieldsAreValid = true
        if emailTextfield.hasText {
            let emailValidation = self.viewModel.validateEmailField(text: emailTextfield.text!)
            if !emailValidation.0 {
                showError(textfield: emailTextfield, error: emailValidation.1!)
                return false
            }
            else {
                emailErrorImage.isHidden = true
            }
        }
        else {
            showError(textfield: emailTextfield, error: ErrorModel(type: .emptyField, message: "This field is required"))
            return false
        }
        return allFieldsAreValid
    }
    
    
    func showError(textfield:UITextField, error:ErrorModel) {
        switch textfield {
        case emailTextfield:
            emailErrorImage.isHidden = false
        case passwordTextfield:
            passwordTextfield.isHidden = false
        default:
            break
        }
        self.view.makeToast(error.message, duration: 3.0, position: .top, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
    }

    
}


