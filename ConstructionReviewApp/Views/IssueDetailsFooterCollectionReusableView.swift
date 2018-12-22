//
//  IssueDetailsFooterCollectionReusableView.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/25/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssueDetailsFooterCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var issueStatusDescriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeIssueButton: UIButton!
    @IBOutlet weak var reopenIssueButton: UIButton!
    @IBOutlet weak var buttonViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var issueStatusDescription: UILabel!
    @IBOutlet weak var buttonsContainerView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var issue: IssueModel?
    weak var viewController: IssueImagesCollectionViewController?
    
    let minimisedHeight: CGFloat = 38.0
    let maximisedHeight: CGFloat = 120.0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleButtons()
    }
    
    
    @IBAction func closeIssueButtonTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func reopenIssueButtonTapped(_ sender: Any) {
        
    }

    
    @IBAction func showMoreButtonTappes(_ sender: Any) {
        self.viewController?.toggleFooterHeight()
    }
    
    
    func styleButtons() {
        let cornerRadius: CGFloat = self.reopenIssueButton.frame.height / 2.0
        self.reopenIssueButton.layer.cornerRadius = cornerRadius
        self.closeIssueButton.layer.cornerRadius = cornerRadius
    }
    
    func setData(issue: IssueModel) {
        self.issue = issue
        
    }
    
}

protocol showIssueStatusDetailsProtocol {
    
    func toggleFooterHeight()
    
}
