//
//  ProjectsViewModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/12/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire


class ProjectsViewModel {
    
    var dataTaskInProgress = false
    var projects: [ProjectModel] = [ProjectModel]()
    
    func getListOfProjects(completion: ((_ error: ErrorModel?) -> ())?) {
        
        guard !self.dataTaskInProgress else {
            return
        }
        
        self.dataTaskInProgress = true
        if NetworkManager.isConnectedToInternet() {
            
            NetworkManager.shared().request(API.getProjects, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
                
                switch response.result {
                    
                case .success(_):
                    if let jsonData = response.data {
                        guard let decodedObj = try? JSONDecoder().decode(ProjectResponseModel.self, from: jsonData)
                            else {
                                self.onFailure()
                                completion?(ErrorModel(type: .serializationError, message: "Fetching data failed, Please pull to refresh"))
                                return
                        }
                        self.projects = decodedObj.result
                    }
                    self.onSuccess()
                    completion?(nil)
                case .failure(_):
                    self.onFailure()
                    completion?(ErrorModel(type: .serializationError, message: "Fetching data failed, Please pull to refresh"))
                }
            }
        }
        else {
            completion?(ErrorModel(type: .noNetworkConnection, message: "You are not connected to the internet"))

        }
    }
    
    func onSuccess() {
        self.dataTaskInProgress = false
    }
    
    func onFailure() {
        self.dataTaskInProgress = false
    }
    
    
}
