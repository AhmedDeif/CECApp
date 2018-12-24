//
//  Extensions.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/25/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView



struct ErrorModel: Error {
    
    enum errorType {
        case emptyField
        case fieldTooShort
        case fieldTooLong
        case invalidToken
        case passwordsDoNotMatch
        case noNetworkConnection
        case invalidEmailFormat
        case loginNotAuthorised
        case serializationError
        case requestFailed
        case requestSucceeded
    }
    
    var message: String
    var type: errorType
    
    init(type: errorType, message:String) {
        self.type = type
        self.message = message
    }
}



extension UIColor {
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension UIView {
    
    func setBackgroudAsGradient() {
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor(displayP3Red: 31/255.0, green: 40/255.0, blue: 57/255.0, alpha: 1)
        let endColor = UIColor(displayP3Red: 68/255.0, green: 103/255.0, blue: 156/255.0, alpha: 1)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func showLoadingIndicator() {
        let indicatorSize: CGSize = CGSize(width: 30.0, height: 30.0)
        startAnimating(indicatorSize,
                       message: "",
                       type: .lineScalePulseOutRapid)

    }
    
    func hideLoadingIndicator() {
        stopAnimating()
    }
    
    func showRatingSuccessfulMessage() {
        self.view.makeToast("You have successfully rated the issue")
    }
    
    
    func showRateIssueViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let rateViewController = storyboard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        let issueToRate = UserDefaults.standard.integer(forKey: UserDefaults.Keys.mustRateIssue.rawValue)
        let issueProject = UserDefaults.standard.integer(forKey: UserDefaults.Keys.mustRateIssueProject.rawValue)
        let issueTitle = UserDefaults.standard.string(forKey: UserDefaults.Keys.issueTitle.rawValue)
        let issueDescription = UserDefaults.standard.string(forKey: UserDefaults.Keys.issueDescription.rawValue)
        rateViewController.issueId = issueToRate
        rateViewController.projectId = issueProject
        rateViewController.issueDescription = issueDescription
        rateViewController.issueTitle = issueTitle
        self.present(rateViewController, animated: true, completion: nil)
    }
}

extension UserDefaults {
    enum Keys:String {
        case TokenKey = "Token"
        case isLoggedIn = "isLoggedIn"
        case passwordReset = "passwordReset"
        case mustRateIssue = "mustRateIssueWithId"
        case mustRateIssueProject = "mustRateIssueWithIdInProject"
        case mustRateIssueFlag = "mustRateIssueWithIdFlag"
        case issueTitle = "issueTitle"
        case issueDescription = "issueDescription"
    }
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, UIImage.JPEGQuality.low.rawValue)
    }
}


extension UIView {
    
    func startShimmering(){
        self.backgroundColor = UIColor.init(red: 190/255, green: 190/255, blue: 190/255, alpha: 0.51)
        let light = UIColor.white.withAlphaComponent(0.7).cgColor
        let alpha = UIColor.black.cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        
        gradient.locations = [0.4,0.5,0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0,0.1,0.2]
        animation.toValue = [0.8,0.9,1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
        
    }
    
    func stopShimmering(){
        DispatchQueue.main.async {
            self.layer.mask = nil
            self.backgroundColor = .clear
        }
    }
    
}



