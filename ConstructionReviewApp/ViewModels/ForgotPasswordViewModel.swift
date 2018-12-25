//
//  ForgotPasswordViewModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/16/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire


class ForgotPasswordViewModel {
    
    var dataTaskInProgress: Bool = false
    
    
    func forgetUserPassword(email: String, completion: ((_ requestSucceeded: Bool, _ error: ErrorModel?) -> ())?) {
        
        if !NetworkManager.isConnectedToInternet() {
            completion?(false, ErrorModel(type: .noNetworkConnection, message: "You are not connected to the internet"))
            return
        }
        
        self.dataTaskInProgress = true
        let paramters = ["email":email]
        
        NetworkManager.shared().request(API.forgotPassword, method: .post, parameters: paramters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                
            case .success(_):
                let statusCode = response.response?.statusCode
                if let jsonData = response.data {
                    switch statusCode {
                    case 404:
                        let decodedObj = try? JSONDecoder().decode(ForgetPasswordResponseModel.self, from: jsonData)
                        self.onFailure()
                        completion?(false, ErrorModel(type: .requestFailed, message: decodedObj!.msg))
                    case 200:
                        let decodedObj = try? JSONDecoder().decode(ForgetPasswordResponseModel.self, from: jsonData)
                        self.onSuccess()
                        completion?(true, ErrorModel(type: .requestSucceeded, message: decodedObj!.msg))
                        
                    default:
                        completion?(false, ErrorModel(type: .loginNotAuthorised, message:"The request failed for an unknown reason"))
                    }
                }
                
            case .failure(_):
                self.onFailure()
                completion?(false, ErrorModel(type: .loginNotAuthorised, message:"The request failed for an unknown reason"))
            }
        }
        
    }
    
    func onSuccess() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.TokenKey.rawValue)
        UserDefaults.standard.set(false, forKey: UserDefaults.Keys.isLoggedIn.rawValue)
        NetworkManager.shared().deregisterAccessToken()
        self.dataTaskInProgress = false
    }
    
    func onFailure() {
        self.dataTaskInProgress = false
    }
    
}
