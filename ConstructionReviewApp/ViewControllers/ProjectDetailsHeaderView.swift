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
    
    @IBAction func moreInfoButtonTapped(_ sender: Any) {
        delegate?.didTapDetailsButton()
    }
}


protocol CustomHeaderDelegate: class {
    
    func didTapDetailsButton()
    
}
