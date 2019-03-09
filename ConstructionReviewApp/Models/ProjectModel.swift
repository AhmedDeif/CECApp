//
//  ProjectModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/12/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct ProjectModel: Codable {
    
    var id: Int
    var name: String?
    var description: String?
    var phase: String?
    var startAt: String?
    var endAt: String?
    var employees: [EmployeeModel]
    
    enum projectType {
        case Construction
        case Support
    }
    
    
    func getProjectManager() -> String {
        for employee in self.employees {
            if employee.role == "PM" {
                return employee.name ?? "No Project Manager Set"
            }
        }
        return "No manager allocated"
    }
    
    func getProjectEmployees() -> [EmployeeModel] {
        return self.employees
    }
    
    
    func getStartDate(withFormat: String = "dd-MM-yy") -> String {
        let dateFormatter = DateFormatter()
        var newDate: String = ""
        if let startAt = self.startAt {
            let index = startAt.index(of: ".")
            if index != nil {
                newDate = String(startAt.prefix(upTo: index!))
            }
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        let date = dateFormatter.date(from: newDate)
        dateFormatter.dateFormat = withFormat
        if date != nil {
            return dateFormatter.string(from: date!)
        }
        return newDate
    }
    
    
    func getEndDate(withFormat: String = "dd-MM-yy") -> String {
        let dateFormatter = DateFormatter()
        var newDate: String = ""
        
        if let endAt = self.endAt {
            let index = endAt.index(of: ".")
            if index != nil {
                newDate = String(endAt.prefix(upTo: index!))
            }
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        let date = dateFormatter.date(from: newDate)
        dateFormatter.dateFormat = withFormat
        if date != nil {
            return dateFormatter.string(from: date!)
        }
        return newDate
    }
    
    
    func getProjectPhase() -> String {
        return self.phase?.lowercased() ?? ""
    }
    
    func getProjectType() -> projectType {
        if getProjectPhase() == "support" {
            return projectType.Support
        }
        return projectType.Construction
    }
}

struct ProjectResponseModel: Codable {
    var error: Bool
    var result: [ProjectModel]
}



