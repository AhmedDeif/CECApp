//
//  ProjectDetailsHeaderView.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/19/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit


class ProjectDetailsHeaderView: UITableViewHeaderFooterView {

    weak var delegate: CustomHeaderDelegate?
    var project: ProjectModel?
    
    @IBOutlet weak var projectNameLabel: UILabel!
    
    
    @IBAction func moreInfoButtonTapped(_ sender: Any) {
        delegate?.didTapDetailsButton()
    }
    
    func setData() {
        self.projectNameLabel.text = project!.name
    }
}


protocol CustomHeaderDelegate: class {
    
    func didTapDetailsButton()
    
}
