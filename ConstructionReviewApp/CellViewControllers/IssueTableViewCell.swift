//
//  IssueTableViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/19/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var issueCreatorLabel: UILabel!
    @IBOutlet weak var issueStatusLabel: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    let cornerRadius: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func styleCell() {
        self.cornerView.layer.cornerRadius = cornerRadius
        self.selectionStyle = .none
    }

    
}
