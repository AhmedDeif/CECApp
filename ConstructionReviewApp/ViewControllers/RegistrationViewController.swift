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
//        networkCall()
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
        
        print("==============================")
        print("activefieldTag: \(activeTextView?.tag)")
        print("Frame size: \(aRect.size)")
        
        aRect.size.height -= keyboardSize!.height
        
        print("Active rect size minus keyboard : \(aRect.size.height)")
        print("keyboard height: '\(keyboardSize!.height)")
        
        let activeTextFieldRect: CGRect? = self.view.window?.convert((activeTextView?.frame)!, from: activeTextView)
        
        let maxPoint: CGPoint? = CGPoint(x: (activeTextFieldRect?.maxX)!, y: (activeTextFieldRect?.maxY)! )
//        let maxPoint = activeTextFieldRect?.
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
    
    
    func networkCall() {
        
        let paramters = ["token":"0902",
                         "password":"Ahmed123",
                         "confirm":"Ahmed123"]
        NetworkManager.shared().request(API.validateToken, method: .post, parameters: paramters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case let .success(value):
                print("Token unregistered successfully")
                
                if let jsonData = response.data {
                    let decodedObj = try? JSONDecoder().decode(ValidateToken.self, from: jsonData)
                    print(jsonData)
                    print(decodedObj)
                }
            case let .failure(error):
                print("Failed to unregister token.")
            }
        }
    }
    

    @IBAction func registerButtonTapped(_ sender: Any) {
        // ToDo: check that all fields are now valid
        // ToDo: Add completition handler
        viewModel.registerUser(token: accessKeyTextfield.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextfield.text!, completion: { () in
            // ToDo: deactivate loading screen
        })
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
        
        switch textField {
        case accessKeyTextfield:
            let result = viewModel.validateTokenField(fieldInput: accessKeyTextfield.text!)
            if !result.0 {
                let error = result.1
                accessKeyErrorImage.isHidden = false
                self.view.makeToast(error?.message, duration: 3.0, position: .top, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            else {
                accessKeyErrorImage.isHidden = true
            }
        case passwordTextField:
            let result = viewModel.validatePasswordField(fieldInput: passwordTextField.text!)
            if !result.0 {
                let error = result.1
                passwordErrorImage.isHidden = false
                self.view.makeToast(error?.message, duration: 3.0, position: .top, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            else {
                passwordErrorImage.isHidden = true
            }
        case confirmPasswordTextfield:
            let result = viewModel.validateConfirmPasswordField(password: passwordTextField.text!, confirmPassword: confirmPasswordTextfield.text!)
            if !result.0 {
                let error = result.1
                confirmPasswordErrorImage.isHidden = false
                self.view.makeToast(error?.message, duration: 3.0, position: .top, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            else {
                confirmPasswordErrorImage.isHidden = true
            }
        default:
            print("Unkown error occured")
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextView = nil
    }

    
}



