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
    
    
    
    func validateTokenField(fieldInput:String) -> (Bool,RegistrationError?) {
        if fieldInput.isEmpty {
            let error = RegistrationError(type: .emptyField, message: "This field is required")
            return (false,error)
        }
        if fieldInput.count < 4 {
            let error = RegistrationError(type: .fieldTooShort, message: "The token must be 4 digits long")
            return (false,error)
        }
        if fieldInput.count > 4 {
            let error = RegistrationError(type: .fieldTooLong, message: "The token must be 4 digits long")
            return (false,error)
        }
        return (true, nil)
    }
    
    
    func validatePasswordField(fieldInput:String) -> (Bool, RegistrationError?) {
        if fieldInput.isEmpty {
            let error = RegistrationError(type: .emptyField, message: "The password field cannot be empty")
            return (false,error)
        }
        return (true, nil)
    }
    
    
    func validateConfirmPasswordField(password:String, confirmPassword:String) -> (Bool, RegistrationError?) {
        if password != confirmPassword {
            let error = RegistrationError(type: .passwordsDoNotMatch, message: "The passwords do not match")
            return (false,error)
        }
        return (true, nil)
    }

    
    
    
    func registerUser(token:String, password:String, confirmPassword:String, completion: (() -> ())?) {
        
        let paramters = ["token":token,
                         "password":password,
                         "confirm":confirmPassword]
        
        NetworkManager.shared().request(API.validateToken, method: .post, parameters: paramters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                
            case let .success(value):
                print("Token unregistered successfully")
                if let jsonData = response.data {
                    let decodedObj = try? JSONDecoder().decode(ValidateToken.self, from: jsonData)
                    print(jsonData)
                    print(decodedObj)
                }
                self.onSuccess()
                if completion != nil {
                    completion!()
                }
                
            case let .failure(error):
                print("Failed to unregister token.")
                self.onFailure()
                if completion != nil {
                    completion!()
                }
            }
        }
    }
   
    
    func onFailure() {
        
    }
    
    
    func onSuccess() {
        // ToDo: Save token in userdefaults
    }
    
    
}


struct RegistrationError: Error {
    
    enum errorType {
        case emptyField
        case fieldTooShort
        case fieldTooLong
        case invalidToken
        case passwordsDoNotMatch
    }
    
    var message: String
    var type: errorType
    
    init(type: errorType, message:String) {
        self.type = type
        self.message = message
    }

    
}




