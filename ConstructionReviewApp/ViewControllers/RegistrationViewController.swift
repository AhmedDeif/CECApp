//
//  RegistrationViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/9/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import NVActivityIndicatorView

class RegistrationViewController: UIViewController {
    

    @IBOutlet weak var repeatPasswordView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var AccessKeyView: UIView!
    
    @IBOutlet weak var confirmPasswordErrorImage: UIImageView!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var passwordErrorImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accessKeyErrorImage: UIImageView!
    @IBOutlet weak var accessKeyTextfield: UITextField!

    @IBOutlet weak var registerbutton: UIButton!
    
    weak var activeTextView: UITextField?
    let viewModel = RegistrationViewModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureView() {
        accessKeyTextfield.delegate = self
        accessKeyTextfield.tag = 1
        passwordTextField.delegate = self
        passwordTextField.tag = 2
        confirmPasswordTextfield.delegate = self
        confirmPasswordTextfield.tag = 3
        confirmPasswordTextfield.isSecureTextEntry = true
        passwordTextField.isSecureTextEntry = true
    }
    
    
    func styleView() {
        let cornerRadius: CGFloat = 5.0
        registerbutton.layer.cornerRadius = registerbutton.frame.height / 2
        repeatPasswordView.layer.cornerRadius = cornerRadius
        repeatPasswordView.layer.masksToBounds = true
        passwordView.layer.cornerRadius = cornerRadius
        passwordView.layer.masksToBounds = true
        AccessKeyView.layer.cornerRadius = cornerRadius
        AccessKeyView.layer.masksToBounds = true
        
        confirmPasswordErrorImage.isHidden = true
        passwordErrorImage.isHidden = true
        accessKeyErrorImage.isHidden = true
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
        let contentInsets: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.isScrollEnabled = true
    }
    
    

    @IBAction func registerButtonTapped(_ sender: Any) {
        
        if viewModel.validateAllFields(token: accessKeyTextfield.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextfield.text!) {
            if NetworkManager.isConnectedToInternet() {
                self.showLoadingIndicator()
                viewModel.registerUser(token: accessKeyTextfield.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextfield.text!, completion: { () in
                    self.hideLoadingIndicator()
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "projectsNavigationController") as! UINavigationController
                    self.present(viewController, animated: true, completion: nil)
                    
                })
            }
            else {
                self.view.makeToast("Your are not connected to the internet")
            }
        }
        
    }
    
    
    
    @IBAction func alreadyHaveAnAccountAction(_ sender: Any) {
        
        
    }
    
    
    

}



extension RegistrationViewController: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextView = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        validateTextFields()
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextView = nil
    }
    
    func validateTextFields() {
        if accessKeyTextfield.hasText {
            let tokenValidation = viewModel.validateTokenField(fieldInput: accessKeyTextfield.text!)
            if !tokenValidation.0 {
                showError(textfield: accessKeyTextfield, error: tokenValidation.1!)
            }
            else {
                accessKeyErrorImage.isHidden = true
            }
        }
        if passwordTextField.hasText {
            let passwordValidation = viewModel.validatePasswordField(fieldInput: passwordTextField.text!)
            if !passwordValidation.0 {
                showError(textfield: passwordTextField, error: passwordValidation.1!)
            }
            else {
                passwordErrorImage.isHidden = true
            }
        }
        if confirmPasswordTextfield.hasText {
            let confirmPasswordValidation: (Bool, ErrorModel?)
            if let passwordText = passwordTextField.text{
                confirmPasswordValidation = viewModel.validateConfirmPasswordField(password: passwordText, confirmPassword: confirmPasswordTextfield.text!)
            }
            else {
                confirmPasswordValidation = viewModel.validateConfirmPasswordField(password: "", confirmPassword: confirmPasswordTextfield.text!)
            }
            if !confirmPasswordValidation.0 {
                showError(textfield: confirmPasswordTextfield, error: confirmPasswordValidation.1!)
            }
            else {
                confirmPasswordErrorImage.isHidden = true
            }
        }
    }
    
    
    func showError(textfield: UITextField, error: ErrorModel) {
        switch textfield {
        case accessKeyTextfield:
            accessKeyErrorImage.isHidden = false
        case passwordTextField:
            passwordErrorImage.isHidden = false
        case confirmPasswordTextfield:
            confirmPasswordErrorImage.isHidden = false
        default:
            break
        }
        self.view.makeToast(error.message, duration: 3.0, position: .top, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
    }

    
}



