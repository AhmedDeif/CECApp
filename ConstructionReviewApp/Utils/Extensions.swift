//
//  Extensions.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/25/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import UIKit


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
