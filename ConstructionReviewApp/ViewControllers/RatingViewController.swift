//
//  RatingViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/3/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {

    
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueDescriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var contentview: UIView!
    
    var issue: IssueModel?
    var issueId: Int?
    var projectId: Int?
    var issueTitle: String?
    var issueDescription: String?
    var viewModel: IssueViewModel = IssueViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cusstomizeView()
    }

    
    
    func cusstomizeView() {
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height/2
        self.issueTitleLabel.text = self.issueTitle!
        self.issueDescriptionLabel.text = self.issueDescription!
        self.contentview.layer.cornerRadius = 10
    }


    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let rating: String = String(ratingView.rating)
        let issue: String = String(issueId!)
        viewModel.setProjectId(projectId: String(self.projectId!))
        viewModel.rateIssue(issueId: issue, issueRating: rating) { (error) in
            guard let errorType = error else {
                UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.mustRateIssue.rawValue)
                UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.mustRateIssueProject.rawValue)
                UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.issueDescription.rawValue)
                UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.issueTitle.rawValue)
                UserDefaults.standard.set(false, forKey: UserDefaults.Keys.mustRateIssueFlag.rawValue)
                self.dismiss(animated: true, completion: nil)
                return
            }
            self.view.makeToast(errorType.message)
        }
    }
    
    
}




