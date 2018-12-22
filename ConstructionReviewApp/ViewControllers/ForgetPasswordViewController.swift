//
//  ForgetPasswordViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/9/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    // ToDo: Add gesture recognizer to dismiss when clicked out of view
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textfieldContainerView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    let viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func styleView() {
        textfieldContainerView.layer.cornerRadius = 5
        textfieldContainerView.layer.masksToBounds = true
        resetPasswordButton.layer.cornerRadius = resetPasswordButton.frame.height / 2.0
        errorImage.isHidden = true
        contentView.layer.cornerRadius = 5
    }
    
    func validateField() -> Bool {
        if !emailTextfield.hasText {
            errorImage.isHidden = false
            self.view.makeToast("The email field cannot be empty")
            return false
        }
        else {
            errorImage.isHidden = true
        }
        if !emailTextfield.text!.isValidEmail() {
            errorImage.isHidden = false
            self.view.makeToast("Invalid email format")
            return false
        }
        else {
            errorImage.isHidden = true
        }
        return true
    }

    
    @IBAction func resetPasswordAction(_ sender: Any) {
        if validateField() {
            self.showLoadingIndicator()
            viewModel.forgetUserPassword(email: emailTextfield.text!) { (successful, error) in
                self.hideLoadingIndicator()
                if successful {
                    let storybaord = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storybaord.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    viewController.shouldPasswordResetMessage = true
                    viewController.passwordResetMessage = error!.message
                    self.present(viewController, animated: true, completion: nil)
                }
                else {
                    self.view.makeToast(error?.message)
                }
            }
        }
    }
}
