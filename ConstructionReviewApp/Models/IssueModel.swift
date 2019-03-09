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
    var status: String?
    var description: String?
    var type: String?
    var userId: Int?
    var projectId: Int
    var createdAt: String?
    var updatedAt: String?
    var images: [ImageModel]
    
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        var newDate: String = ""
        if let createdAt = self.createdAt {
            let index = createdAt.index(of: ".")
            if index != nil {
                newDate = String(createdAt.prefix(upTo: index!))
            }
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        
        let date = dateFormatter.date(from: newDate)
        dateFormatter.dateFormat = "dd MMM yy"
        if date != nil {
            return dateFormatter.string(from: date!)
        }
        return newDate
    }
    
    func issueResolved() -> Bool {
        if self.status == "done" {
            return true
        }
        return false
    }
    
    func issueClosed() -> Bool {
        if self.status == "closed" {
            return true
        }
        return false
    }
    
}


struct ProjectIssuesModel: Codable {
    var error: Bool
    var result: [IssueModel]
}

struct CloseIssueResponse: Codable {
    var error: Bool
    var result: String
}
