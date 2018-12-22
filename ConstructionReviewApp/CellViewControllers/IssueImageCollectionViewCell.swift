//
//  IssueImageCollectionViewCell.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/20/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssueImageCollectionViewCell: UICollectionViewCell, ImageLoadingCompletionHandler {

    @IBOutlet weak var imageView: UIImageView!
    var indexPath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    func onImageDownloadComplete(downloadedImage: UIImage?, cellIndex: Int!) {
        if cellIndex == self.indexPath.row {
            DispatchQueue.main.async {
                self.imageView.image = downloadedImage
            }
            self.imageView.stopShimmering()
        }
    }
    
    func setData(imageURL: String, indexPath: IndexPath) {
        self.imageView.startShimmering()
//        print("image url: \(imageURL)")
        NetworkManager.shared().downloadImage(sender: self, url: URL(string:imageURL)!, cellIndex: indexPath.row) { (image, error, cellIndex) in }
    }

}

protocol ImageLoadingCompletionHandler {
    func onImageDownloadComplete(downloadedImage: UIImage?, cellIndex: Int!)
}

