//
//  ProjectDescriptionCustomHeaderView.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/3/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectDescriptionCustomHeaderView: UITableViewHeaderFooterView {
    

    @IBOutlet weak var projectStartDateLabel: UILabel!
    @IBOutlet weak var projectEndDateLabel: UILabel!
    @IBOutlet weak var projectPhaseLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UITextView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var projectDescriptionLabelHeight: NSLayoutConstraint!
    var contentHeight: CGFloat?
    var compressedContentHeight: CGFloat?
    var expandedContentHeight: CGFloat?
    var compressedViewActive = true
    weak var tableViewDelegate: ProjectDescriptionViewController?
   
    @IBAction func readMoreTapped(_ sender: Any) {
        // change height of textView
        print("tpped")
        if compressedContentHeight == nil {
            self.expandedContentHeight = self.projectDescriptionLabel.contentSize.height
            self.compressedContentHeight = self.projectDescriptionLabelHeight.constant
        }
        if compressedViewActive {
            compressedViewActive = false
            self.tableViewDelegate?.readMoreButton(expandView: true, additionalHeight: self.expandedContentHeight! - self.compressedContentHeight!)
            
            self.projectDescriptionLabelHeight.constant = expandedContentHeight!
            self.readMoreButton.setTitle("show less", for: .normal)
//            self.invalidateIntrinsicContentSize()
        }
        else {
            compressedViewActive = true
            self.projectDescriptionLabelHeight.constant = compressedContentHeight!
            self.readMoreButton.setTitle("read more", for: .normal)
            self.tableViewDelegate?.readMoreButton(expandView: false, additionalHeight: self.expandedContentHeight! - self.compressedContentHeight!)
//            self.invalidateIntrinsicContentSize()
        }
        
    }
}

protocol  readMoreButtonProtocol {
    func readMoreButton(expandView:Bool, additionalHeight: CGFloat)
}
