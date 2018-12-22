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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func styleView() {
        
        if projectIssue!.issueResolved() {
            self.issueStatusLabel.text = "Done"
        }
        else {
            self.issueStatusLabel.text = "Pending"
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
        
    }
    
    
    @IBAction func reopenIssue(_ sender: Any) {
        
    }
    
}
