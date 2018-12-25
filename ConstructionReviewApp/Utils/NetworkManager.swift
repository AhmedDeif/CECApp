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
        NetworkManager.shared().adapter = AccessTokenAdapter(accessToken:accessToken)
    }
    
    func deregisterAccessToken() {
        NetworkManager.shared().adapter = AccessTokenAdapter(accessToken:"")
    }
    
}


class AccessTokenAdapter: RequestAdapter {
    
    private let accessToken: String
    var authorizationRequiredEndPoints : [String] = [
        API.getProjects,
        API.getProjectIssues.replacingOccurrences(of: "{projectId}", with: ""),
        API.forgotPassword,
        API.postProjectIssue.replacingOccurrences(of: "{projectId}", with: ""),
        API.imagesURLPrefix,
        API.closeIssue.replacingOccurrences(of: "{issueId}/close", with: ""),
        API.rateIssue.replacingOccurrences(of: "{issueId}/rate", with: "")
    ]
    
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

extension NetworkManager {
    
    func downloadImage(sender: ImageLoadingCompletionHandler? ,url: URL, cellIndex: Int?, completion: @escaping (_ image: UIImage?, _ error: Error?, _ cellIndex: Int? ) -> Void) {
        
        if NetworkManager.isConnectedToInternet() {
            NetworkManager.shared().request(url).responseData { (response) in
                if let data = response.data {
                    if let image = UIImage(data: data) {
                        if sender != nil {
                            sender?.onImageDownloadComplete(downloadedImage: image, cellIndex:cellIndex )
                        }
                        completion(image, nil, nil)
                    }
                }
            }
        }
    }
}

