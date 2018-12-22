//
//  IssueImagesCollectionViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/20/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit



class IssueImagesCollectionViewController: UICollectionViewController {

    fileprivate let reuseIdentifier = "issueImageCollectionViewCell"
    fileprivate let customHeaderReuseIdentifier = "IssuePicturesCollectionReusableView"
//    fileprivate let customFooterReuseIdentifier = "IssueDetailsFooterCollectionReusableView"
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 60.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let fullScreenImageTag = 99915
    
    var issueStatusBarExpand = false
    var imagesArr = [UIImage]()
    var projectIssue: IssueModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCells() {
        self.collectionView!.register(UINib(nibName: "IssueImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UINib(nibName: customHeaderReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: customHeaderReuseIdentifier)
//        self.collectionView!.register(UINib(nibName: customFooterReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: customFooterReuseIdentifier)
    }
    
    
    func setUpData() {
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
        imagesArr.append(#imageLiteral(resourceName: "key"))
//        projectIssue?.images = imagesArr
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projectIssue?.images.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IssueImageCollectionViewCell
        cell.indexPath = indexPath
        cell.setData(imageURL: self.projectIssue!.images[indexPath.row].path, indexPath: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: customHeaderReuseIdentifier, for: indexPath) as! IssuePicturesCollectionReusableView
            reusableview.setData(issue: projectIssue!)
            return reusableview

//        case UICollectionElementKindSectionFooter:
//            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: customFooterReuseIdentifier, for: indexPath) as! IssueDetailsFooterCollectionReusableView
//            reusableView.viewController = self
//            reusableView.setData(issue: projectIssue!)
//            return reusableView
        default:  fatalError("Unexpected element kind")
        }
        
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "imageManipulationViewController") as! ImageViewController
        let cell = self.collectionView?.cellForItem(at: indexPath) as! IssueImageCollectionViewCell
        controller.image = cell.imageView.image
        self.navigationController?.pushViewController(controller, animated: true)
        return false
    }
    
    
    
    @objc func dismissFullScreen() {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        for view:UIView in (self.view.subviews) {
            if view.tag == fullScreenImageTag {
                view.removeFromSuperview()
            }
        }
    }

}

extension IssueImagesCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 165)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if self.issueStatusBarExpand {
//            return CGSize(width: collectionView.frame.width, height: 140)
//        }
//        return CGSize(width: collectionView.frame.width, height: 42)
//        
//    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension IssueImagesCollectionViewController: showIssueStatusDetailsProtocol {
    
    func toggleFooterHeight() {
        self.issueStatusBarExpand = !self.issueStatusBarExpand
        self.collectionView!.collectionViewLayout.invalidateLayout()
        self.collectionView?.scrollToItem(at: IndexPath(item: (self.projectIssue?.images.count)!-1, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
    }
    
}


