//
//  IssueCreationViewModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/16/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire


class IssueCreationViewModel {
    
    var dataTaskInProgress: Bool = false
    var issueImages: [UIImage] = [UIImage]()
    var isProjectIdSet: Bool = false
    private var projectId: String = ""
    var newIssueId: String = ""
    var projectType: ProjectModel.projectType?
    var issueType: String = ""
    var issueDescription: String = ""
    
    
    
    func setProjectId(projectId: String) {
        self.projectId = projectId
        self.isProjectIdSet = true
    }
    
    func deleteProjectId() {
        self.projectId = ""
        self.isProjectIdSet = false
    }
    
    
    func createIssue(completion: ((_ error: ErrorModel?) -> ())?) {
        if !isProjectIdSet {
            return
        }
        
        let url = API.postProjectIssue.replacingOccurrences(of: "{projectId}", with: self.projectId)
        print(url)
        var parameters = ["type": issueType,
                          "description": issueDescription]
        
        if NetworkManager.isConnectedToInternet() {


            NetworkManager.shared().upload(multipartFormData: { (multipartFormData) in
                var index = 0;
                
                for image in self.issueImages {
                    let imageName = String(NSDate.timeIntervalSinceReferenceDate) + "-iOS\(index)"
                    let imageData = image.jpeg(UIImage.JPEGQuality.lowest)!
                    multipartFormData.append(imageData, withName: "images", fileName: imageName, mimeType: "image/jpeg")
                    index += 1
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }

            }, usingThreshold: UInt64.init(), to: url, method: .post, headers: nil, encodingCompletion:{ encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.validate(contentType: ["application/json"]).responseJSON { response in
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }

                        if let httpStatusCode = response.response?.statusCode, let data = response.data {
                            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                                print(JSONString)
                            }
                            switch(httpStatusCode) {
                            case 200...300:
                                completion?(nil)
                            default:
                                completion?(ErrorModel(type: .requestFailed, message: "Posting the issue failed, please try again."))
                            }
                        } else {
                            completion?(ErrorModel(type: .requestFailed, message: "Posting the issue failed, please try again."))
                        }

                    }
                    upload.uploadProgress(closure: { progress in
                        print(progress)
                    })
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
        }
    }
    

    func onSucess() {
        
    }
    
    func onFailure() {
        
    }
    
}
