//
//  ImageViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/20/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.maximumZoomScale = 6.0
        self.scrollView.minimumZoomScale = 1.0
        self.imageContainer.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageContainer
    }

}
