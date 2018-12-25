//
//  ProjectDescriptionTableViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/3/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import MessageUI


class ProjectDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var corneredView: UIView!
    @IBOutlet weak var employeeTitleLabel: UILabel!
    @IBOutlet weak var employeeContactNumberLabel: UILabel!
    @IBOutlet weak var employeeEmailLabel: UILabel!
    @IBOutlet weak var empolyeeName: UILabel!
    
    weak var parentViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
        addListeners()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func customizeView() {
        self.corneredView.layer.cornerRadius = 5.0
        self.corneredView.layer.shadowColor = UIColor.black.cgColor
        self.corneredView.layer.shadowOpacity = 0.5
        self.corneredView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.corneredView.layer.shadowRadius = 1
        self.selectionStyle = .none
    }
    
    
    func addListeners() {
        let emailGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProjectDescriptionTableViewCell.sendEmailToEmployee))
        self.employeeEmailLabel.isUserInteractionEnabled = true
        self.employeeEmailLabel.addGestureRecognizer(emailGestureRecognizer)
        
        let phoneGetsureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProjectDescriptionTableViewCell.callEmployee))
        self.employeeContactNumberLabel.isUserInteractionEnabled = true
        self.employeeContactNumberLabel.addGestureRecognizer(phoneGetsureRecognizer)
    }
    
    func setData(employee: EmployeeModel) {
        let stringAttributes = [ NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        self.employeeEmailLabel.attributedText = NSAttributedString(string: employee.email, attributes: stringAttributes)
        self.employeeTitleLabel.text = employee.employeeRoleString()
        self.employeeContactNumberLabel.attributedText = NSAttributedString(string: employee.phone, attributes: stringAttributes)
        self.empolyeeName.text = employee.name
    }
    
    
    @objc func sendEmailToEmployee(sender:UITapGestureRecognizer) {
        sendEmail()
    }
    
    
    @objc func callEmployee(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string: "tel://\(self.employeeContactNumberLabel.text!)")!, options: [:], completionHandler: nil)
    }
    

}


extension ProjectDescriptionTableViewCell: MFMailComposeViewControllerDelegate {
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let email = self.employeeEmailLabel.text ?? ""
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            mail.mailComposeDelegate = self
            parentViewController?.present(mail, animated: true)
        }
    }
    
}


