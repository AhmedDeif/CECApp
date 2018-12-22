//
//  InfoViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/20/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import MessageUI

class InfoViewController: UIViewController {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var companyEmailLabel: UILabel!
    @IBOutlet weak var generalManagerEmailLabel: UILabel!
    @IBOutlet weak var managingDirectorEmailLabel: UILabel!
    @IBOutlet weak var crmDirectorEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addListeners()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addListeners() {
        let companyEmailGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.sendEmailToEmployee))
        companyEmailGestureRecognizer.name = "companyEmailGestureRecognizer"
        self.companyEmailLabel.isUserInteractionEnabled = true
        self.companyEmailLabel.addGestureRecognizer(companyEmailGestureRecognizer)
        
        let gmEmailGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.sendEmailToEmployee))
        gmEmailGestureRecognizer.name = "gmEmailGestureRecognizer"
        self.generalManagerEmailLabel.isUserInteractionEnabled = true
        self.generalManagerEmailLabel.addGestureRecognizer(gmEmailGestureRecognizer)
        
        let managingEmailGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.sendEmailToEmployee))
        managingEmailGestureRecognizer.name = "managingEmailGestureRecognizer"
        self.managingDirectorEmailLabel.isUserInteractionEnabled = true
        self.managingDirectorEmailLabel.addGestureRecognizer(managingEmailGestureRecognizer)
        
        let crmEmailGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.sendEmailToEmployee))
        crmEmailGestureRecognizer.name = "crmEmailGestureRecognizer"
        self.crmDirectorEmailLabel.isUserInteractionEnabled = true
        self.crmDirectorEmailLabel.addGestureRecognizer(crmEmailGestureRecognizer)

        
        let phoneGetsureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProjectDescriptionTableViewCell.callEmployee))
        self.phoneNumberLabel.isUserInteractionEnabled = true
        self.phoneNumberLabel.addGestureRecognizer(phoneGetsureRecognizer)
    }
    

    @objc func sendEmailToEmployee(sender:UITapGestureRecognizer) {
        switch sender.name {
        case "companyEmailGestureRecognizer" :
            sendEmail(email: companyEmailLabel.text!)
        case "gmEmailGestureRecognizer" :
            sendEmail(email: generalManagerEmailLabel.text!)
        case "managingEmailGestureRecognizer" :
            sendEmail(email: managingDirectorEmailLabel.text!)
        case "crmEmailGestureRecognizer" :
            sendEmail(email: crmDirectorEmailLabel.text!)
        default:
            print("problem")
        }
    }
    
    
    @objc func callEmployee(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string: "tel://\(phoneNumberLabel.text!)")!, options: [:], completionHandler: nil)
    }
    
}

extension InfoViewController: MFMailComposeViewControllerDelegate {
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.mailComposeDelegate = self
            self.present(mail, animated: true)
        }
    }
    
}
