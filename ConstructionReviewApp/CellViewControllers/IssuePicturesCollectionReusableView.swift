//
//  IssuePicturesCollectionReusableView.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/20/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssuePicturesCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var issueTypeLabel: UILabel!
    @IBOutlet weak var issueDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(issue: IssueModel) {
        self.issueTypeLabel.text = issue.type
        self.issueDescriptionLabel.text = issue.description
    }
    
}
