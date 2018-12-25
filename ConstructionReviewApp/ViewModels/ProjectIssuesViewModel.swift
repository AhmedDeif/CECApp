//
//  projectIssuesViewModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/15/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire

class ProjectIssuesViewModel {
    
    var projectId: String = ""
    var dataTaskInProgress: Bool = false
    var projectIssues: [IssueModel] = [IssueModel]()
    var isProjectIdSet: Bool = false
    
    func setProjectId(projectId: String) {
        self.projectId = projectId
        self.isProjectIdSet = true
    }
    
    func deleteProjectId() {
        self.projectId = ""
        self.isProjectIdSet = false
    }
    
    func getProjectIssues(completion: ((_ requestSuccess: Bool, _ error: ErrorModel?) -> ())?) {
        
        if !isProjectIdSet {
            return
        }
        
        if NetworkManager.isConnectedToInternet() {
            let url = API.getProjectIssues.replacingOccurrences(of: "{projectId}", with: self.projectId)
            NetworkManager.shared().request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
                
                switch response.result {
                case .success(_):
                    if let jsonData = response.data {
                        guard let decodedObj = try? JSONDecoder().decode(ProjectIssuesModel.self, from: jsonData)
                            else {
                                self.onFailure()
                                completion?(false, ErrorModel(type: .serializationError, message: "Fetching data failed, Please pull to refresh"))
                                return
                            }
                        self.projectIssues = decodedObj.result
                    }
                    self.onSuccess()
                    completion?(true, nil)
                case .failure(_):
                    self.onFailure()
                    completion?(false, ErrorModel(type: .serializationError, message: "Fetching data failed, Please pull to refresh"))
                }
            }
        }
        else {
            completion?(false, ErrorModel(type: .noNetworkConnection, message: "You are not connected to the internet"))

        }
    }
    
    
    func onSuccess() {
        self.dataTaskInProgress = false
    }
    
    
    
    func onFailure() {
        self.dataTaskInProgress = false
    }
    
    
    
}
