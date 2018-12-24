//
//  IssueDetailsViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/20/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssueDetailsViewController: UIViewController {

    var projectIssue: IssueModel?
    let seugueID = "issueImagesEmbeddedSegue"
    @IBOutlet weak var containerView: UIView!
    var viewExpanded = false
    @IBOutlet weak var issueActionView: UIView!
    @IBOutlet weak var actionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeIssueButton: UIButton!
    @IBOutlet weak var reopenIssueButton: UIButton!
    
    @IBOutlet weak var issueStatusLabel: UILabel!
    @IBOutlet weak var issueExpansionTime: UIButton!
    
    var viewModel: IssueViewModel = IssueViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        viewModel.setProjectId(projectId: String(self.projectIssue!.projectId))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func styleView() {
        
        if projectIssue!.issueResolved() {
            self.issueStatusLabel.text = "Done"
        }
        else {
            if projectIssue!.issueClosed() {
                self.issueStatusLabel.text = "Closed"
            }
            else {
                self.issueStatusLabel.text = "Pending"
            }
            self.issueExpansionTime.isHidden = true
            self.issueExpansionTime.isEnabled = false
        }
    }
    
    
    func showActionView() {
        self.actionViewHeightConstraint.constant = 90
        self.reopenIssueButton.layer.cornerRadius = 18
        self.closeIssueButton.layer.cornerRadius = 18
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
        }, completion:  {
            (value: Bool) in
            self.viewExpanded = true
        })
    }
    
    
    func hideActionView() {
        self.actionViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion:  {
            (value: Bool) in
            self.viewExpanded = false
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.seugueID {
            let childController = segue.destination as! IssueImagesCollectionViewController
            childController.projectIssue = self.projectIssue
        }
    }
    
    
    @IBAction func expandIssueActionView(_ sender: Any) {
        self.viewExpanded ? hideActionView() : showActionView()
    }
    
    
    @IBAction func closeIssue(_ sender: Any) {
        if NetworkManager.isConnectedToInternet() {
            self.showLoadingIndicator()
            viewModel.closeIssue(issueId: String(self.projectIssue!.id)) { (error) in
                self.hideLoadingIndicator()
                if error != nil {
                    self.view.makeToast(error!.message)
                }
                else {
                    UserDefaults.standard.set(self.projectIssue!.id, forKey: UserDefaults.Keys.mustRateIssue.rawValue)
                    UserDefaults.standard.set(self.projectIssue!.projectId, forKey: UserDefaults.Keys.mustRateIssueProject.rawValue)
                    UserDefaults.standard.set(self.projectIssue!.description, forKey: UserDefaults.Keys.issueDescription.rawValue)
                    UserDefaults.standard.set(self.projectIssue!.type, forKey: UserDefaults.Keys.issueTitle.rawValue)
                    UserDefaults.standard.set(true, forKey: UserDefaults.Keys.mustRateIssueFlag.rawValue)
                    let viewControllers = self.navigationController?.viewControllers
                    let issueTableVC = viewControllers![(viewControllers?.count)!-2] as! IssueTableViewController
                    issueTableVC.closedIssue = true
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        else {
            self.view.makeToast("You are not connected to the internet")
        }
    }
    
    
    @IBAction func reopenIssue(_ sender: Any) {
        if NetworkManager.isConnectedToInternet() {
            self.showLoadingIndicator()
            viewModel.reopenIssue(issueId: String(self.projectIssue!.id)) { (error) in
                self.hideLoadingIndicator()
                if error != nil {
                    self.view.makeToast(error!.message)
                }
                else {
                    let viewControllers = self.navigationController?.viewControllers
                    let issueTableVC = viewControllers![(viewControllers?.count)!-2] as! IssueTableViewController
                    issueTableVC.issueReopend = true
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        else {
            self.view.makeToast("You are not connected to the internet")
        }
    }
    
}
