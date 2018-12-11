//
//  RatingViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/3/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {

    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueDescriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cusstomizeView()
    }

    func cusstomizeView() {
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height/2
    }


    @IBAction func submitButtonTapped(_ sender: Any) {
        // ToDo: register in defaults that no rating needs to be submitted
    }
    
}
