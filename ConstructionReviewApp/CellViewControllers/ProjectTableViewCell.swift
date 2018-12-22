//
//  ProjectTableViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/15/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectStatus: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
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
    
    func setData(project: ProjectModel) {
        self.projectOwnerLabel.text = project.getProjectManager()
        self.projectNameLabel.text = project.name
        self.startDate.text = project.getStartDate()
        self.endDate.text = project.getEndDate()
        self.projectStatus.text = project.getProjectPhase()
    }
    

    
}
