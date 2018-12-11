//
//  ProjectDescriptionTableViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/3/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var corneredView: UIView!
    @IBOutlet weak var employeeTitleLabel: UILabel!
    @IBOutlet weak var employeeContactNumberLabel: UILabel!
    @IBOutlet weak var employeeEmailLabel: UILabel!
    @IBOutlet weak var empolyeeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
        // Initialization code
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
    
}
