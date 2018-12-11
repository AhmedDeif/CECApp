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

    @IBAction func resetPasswordAction(_ sender: Any) {
        
    }
    

}
