//
//  EmptyTableView.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 1/14/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class EmptyTableView: UIView {

    @IBOutlet weak var alertLabel: UILabel!
    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//    
//    
    func setText(alertText: String) {
        self.alertLabel.text = alertText
    }
//
//    
//    func setupView() {
//        Bundle.main.loadNibNamed("EmptyTableView", owner: self, options: nil)
//        contentView.fixInView(self)
//    }
    
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
