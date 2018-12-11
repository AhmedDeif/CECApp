//
//  CameraHandler.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/22/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit
import Foundation
import Photos


class CameraHandler:NSObject {
    
    
    private static let sharedCameraHandler:CameraHandler = {
        return CameraHandler()
    }()
    
    var currentViewController: UIViewController!
    var imageSelectionCompletionHandler: ((UIImage) -> Void)?

    
    class func shared() -> CameraHandler {
        return sharedCameraHandler
    }
    
    func setHandlerParams(viewController: UIViewController, completion: @escaping ((UIImage) -> Void)) {
        self.currentViewController = viewController
        self.imageSelectionCompletionHandler = completion
    }
    
    
    deinit {
        print("deallocated")
    }


    func useCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentViewController.present(myPickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Camera unavailable", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.currentViewController.present(alert, animated: true, completion: nil)
        }
    }

    func usePhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentViewController.present(myPickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Photo Library unavailable", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.currentViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkCameraPermissions() -> Bool {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            return true
        }
        return false
    }
    
    
    func checkPhotoLibraryAccess() -> Bool {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            return true
        }
        return false
    }
    
    
    func getCameraAccess () {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                self.useCamera()
            } else {
                let alert = UIAlertController(title: "Camera access required", message: "You did not allow access to camera and the application needs camera access to take pictures. Please change the access rights in the phone settings.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.currentViewController.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    func getPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.usePhotoLibrary()
            }
            else {
                let alert = UIAlertController(title: "Access to photos required", message: "You did not allow access to your photo library and the application needs access to photo library select pictures from your library. Please change the access rights in the phone settings.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.currentViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Add images from:", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if self.checkCameraPermissions() {
                self.useCamera()
            }
            else {
                self.getCameraAccess()
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if self.checkPhotoLibraryAccess() {
                self.usePhotoLibrary()
            }
            else {
                self.getPhotoLibraryAccess()
            }
            
        }))
        
         actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.currentViewController.present(actionSheet, animated: true, completion: nil)

    }
}

extension CameraHandler: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentViewController.dismiss(animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageSelectionCompletionHandler?(selectedImage)
        }
        else {
            // ToDo: show alert that image selection process failed.
            let alert = UIAlertController(title: "Image Selection Failed", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.currentViewController.present(alert, animated: true, completion: nil)
        }
        currentViewController.dismiss(animated: true, completion: nil)
    }
}
