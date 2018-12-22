//
//  IssueModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/18/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct IssueModel: Codable {
    
    var id: Int
    var status: String
    var description: String
//    var rating: String
    var type: String
    var userId: Int
    var projectId: Int
    var createdAt: String
    var updatedAt: String
    var images: [ImageModel]
    
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        let index = self.createdAt.index(of: ".")
        var newDate: String = ""
        if index != nil {
            newDate = String(self.createdAt.prefix(upTo: index!))
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: newDate)
        dateFormatter.dateFormat = "dd MMM yy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    func issueResolved() -> Bool {
        if self.status == "done" {
            return true
        }
        return false
    }
    
}

struct ProjectIssuesModel: Codable {
    
    var error: Bool
    var result: [IssueModel]
}

