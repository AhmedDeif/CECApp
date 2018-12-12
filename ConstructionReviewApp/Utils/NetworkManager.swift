//
//  NetworkManager.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/10/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: Alamofire.SessionManager {
    
    private static var sharedManager:NetworkManager = {
        let configuration: URLSessionConfiguration = .default
        var headers = SessionManager.defaultHTTPHeaders
        headers.updateValue("application/json", forKey: "Content-Type")
        configuration.httpAdditionalHeaders = headers
        let networkManager = NetworkManager(configuration: configuration, delegate: SessionManager.default.delegate)
        return networkManager
    }()
    
    
    private override init(configuration: URLSessionConfiguration, delegate: SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
    }

    
    static func shared() -> NetworkManager {
        return sharedManager
    }
    
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func registerAccessToken(accessToken:String) {
        NetworkManager.shared().adapter = AccessTokenAdapter(accessToken:"token")
    }
    
    func deregisterAccessToken() {
        NetworkManager.shared().adapter = AccessTokenAdapter(accessToken:"")
    }
    
}


class AccessTokenAdapter: RequestAdapter {
    
    private let accessToken: String
    var authorizationRequiredEndPoints : [String] = []
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var requestWithAuthorization = urlRequest
        let urlRequestString = urlRequest.url?.absoluteString

        for url in authorizationRequiredEndPoints {
            if (urlRequestString?.hasPrefix(url))! {
                requestWithAuthorization.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
                return requestWithAuthorization
            }
        }
        return requestWithAuthorization
    }
}

