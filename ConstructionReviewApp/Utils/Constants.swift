//
//  Constants.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/10/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct API {
    static let baseURL = "https://desolate-tor-65119.herokuapp.com"
    static let tokenType = ""
    static let validateToken = baseURL + "/api/validateToken"
    static let login = baseURL + "/api/login"
    static let getProjects = baseURL + "/api/projects"
    static let imagesURLPrefix = baseURL + "/images/issues"
    static let forgotPassword = baseURL + "/api/forgot"
//    @POST("forgot")
    
    static let closeIssue = baseURL + ""
//    @POST("issues/{issueId}/close")
    
    static let rateIssue = baseURL + ""
//    @POST("issues/{issueId}/rate")
    
    
    static let getProjectIssues = baseURL + "/api/issues/{projectId}"
    //    @GET("issues/{projectId}")
    
    static let postProjectIssue = baseURL + "/api/issues/{projectId}"
//    @Multipart
//    @POST("issues/{projectId}")
//    Call<ResponseBody> reportIssue(@Path("projectId") int projectID,
//    @Part("type") RequestBody type,
//    @Part("description") RequestBody description,
//    @Part ArrayList<MultipartBody.Part> images);

}

struct constants {
    
}
