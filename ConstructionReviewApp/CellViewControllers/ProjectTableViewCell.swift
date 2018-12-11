//
//  ProjectTableViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/15/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var corneredView: UIView!
    @IBOutlet weak var projectOwnerLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStatusImageView: UIImageView!
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
        self.corneredView.layer.cornerRadius = cornerRadius
        self.selectionStyle = .none
    }

    
}
