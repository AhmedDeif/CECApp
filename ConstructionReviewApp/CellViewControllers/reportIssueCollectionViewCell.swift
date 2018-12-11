//
//  reportIssueCollectionViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/22/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class reportIssueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var indexPath: Int?
    weak var viewController: ReportIssueViewController?
    
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if viewController != nil {
            viewController?.deleteImage(indexPath: indexPath!)
        }
    }
    
    func setImage(image:UIImage) {
        self.imageView.image = image
    }
}

protocol issueImageDeletionProtocol {
    func deleteImage(indexPath: Int)
}
