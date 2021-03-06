//
//  LoginViewModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/12/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire

class LoginViewModel {
    
    var dataTaskInProgress = false
    
    func validateEmailField(text:String) -> (Bool, ErrorModel?) {
        if !text.isValidEmail() {
            return (false, ErrorModel(type: .invalidEmailFormat, message: "Please use an email with an appropriate format"))
        }
        if text.isEmpty {
            return (false, ErrorModel(type: .emptyField, message: "This field is required"))

        }
        return (true, nil)
    }
    
    
    func validatePasswordField(text:String) -> (Bool, ErrorModel?) {
        if text.isEmpty {
            return (false, ErrorModel(type: .emptyField, message: "This field is required"))
        }
        return (true, nil)
    }
    
    
    func login(username:String, password:String,  completion: ((_ loginAuthorised: Bool, _ error: ErrorModel?) -> ())?) {
        
        if NetworkManager.isConnectedToInternet() {
            
            self.dataTaskInProgress = true
            let paramters = ["email":username,
                             "password":password]
            
            NetworkManager.shared().request(API.login, method: .post, parameters: paramters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                    
                case .success(_):
                    let statusCode = response.response?.statusCode
                    if let jsonData = response.data {
                        switch statusCode {
                        case 401:
                            let decodedObj = try? JSONDecoder().decode(LoginFailureResponse.self, from: jsonData)
                            self.onFailure()
                            completion?(false, ErrorModel(type: .loginNotAuthorised, message: decodedObj?.msg ?? "Your email or password is wrong."))
                        case 200:
                            let decodedObj = try? JSONDecoder().decode(LoginResponse.self, from: jsonData)
                            if let token = decodedObj?.token {
                                self.onSuccess(token: token)
                                completion?(true, nil)
                            }
                            else {
                                self.onFailure()
                                completion?(false, ErrorModel(type: .loginNotAuthorised, message: "Your email or password is wrong."))
                            }
                            
                            
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
        else {
            completion?(false, ErrorModel(type: .noNetworkConnection, message:"You are not connected to the internet"))

        }
    }
    
    
    func onSuccess(token: String) {
        self.dataTaskInProgress = false
        UserDefaults.standard.set(token, forKey: UserDefaults.Keys.TokenKey.rawValue)
        UserDefaults.standard.set(true, forKey: UserDefaults.Keys.isLoggedIn.rawValue)
        NetworkManager.shared().registerAccessToken(accessToken: token)
    }
    
    
    func onFailure() {
        self.dataTaskInProgress = false
    }
}
