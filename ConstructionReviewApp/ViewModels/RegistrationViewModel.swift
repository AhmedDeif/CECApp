//
//  RegistrationViewModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/11/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire


class RegistrationViewModel {
    
    var dataTaskInProgress: Bool = false
    var token: String?
    
    func validateTokenField(fieldInput:String) -> (Bool,ErrorModel?) {
        if fieldInput.isEmpty {
            let error = ErrorModel(type: .emptyField, message: "This field is required")
            return (false,error)
        }
        if fieldInput.count < 4 {
            let error = ErrorModel(type: .fieldTooShort, message: "The token must be 4 digits long")
            return (false,error)
        }
        if fieldInput.count > 4 {
            let error = ErrorModel(type: .fieldTooLong, message: "The token must be 4 digits long")
            return (false,error)
        }
        return (true, nil)
    }
    
    
    func validatePasswordField(fieldInput:String) -> (Bool, ErrorModel?) {
        if fieldInput.isEmpty {
            let error = ErrorModel(type: .emptyField, message: "The password field cannot be empty")
            return (false,error)
        }
        return (true, nil)
    }
    
    
    func validateConfirmPasswordField(password:String, confirmPassword:String) -> (Bool, ErrorModel?) {
        if password != confirmPassword {
            let error = ErrorModel(type: .passwordsDoNotMatch, message: "The passwords do not match")
            return (false,error)
        }
        return (true, nil)
    }
    
    func validateAllFields(token:String, password:String, confirmPassword:String) -> Bool{
        let tokenValidation = self.validateTokenField(fieldInput: token)
        let passwordValidation = self.validatePasswordField(fieldInput: password)
        let confirmPasswordValidation = self.validateConfirmPasswordField(password: password, confirmPassword: confirmPassword)
        if tokenValidation.0 && passwordValidation.0 && confirmPasswordValidation.0 {
            return true
        }
        return false
    }

    
    
    
    func registerUser(token:String, password:String, confirmPassword:String, completion: (() -> ())?) {
        
        if NetworkManager.isConnectedToInternet() {
            self.dataTaskInProgress = true
            let paramters = ["token":token,
                             "password":password,
                             "confirm":confirmPassword]
            
            NetworkManager.shared().request(API.validateToken, method: .post, parameters: paramters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                    
                case .success(_):
                    if let jsonData = response.data {
                        let decodedObj = try? JSONDecoder().decode(ValidateToken.self, from: jsonData)
                        self.token = decodedObj?.token
                    }
                    self.onSuccess()
                    if completion != nil {
                        completion!()
                    }
                    
                case .failure(_):
                    self.onFailure()
                    if completion != nil {
                        completion!()
                    }
                }
            }
        }
        else {
            self.onFailure()
        }
        
    }
   
    
    func onFailure() {
        self.dataTaskInProgress = false
    }
    
    
    func onSuccess() {
        self.dataTaskInProgress = false
        UserDefaults.standard.set(self.token, forKey: UserDefaults.Keys.TokenKey.rawValue)
        UserDefaults.standard.set(true, forKey: UserDefaults.Keys.isLoggedIn.rawValue)
        NetworkManager.shared().registerAccessToken(accessToken: self.token!)
        self.token = nil
    }
    
    
}






