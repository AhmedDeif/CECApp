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
    var name: String
    var description: String
    var phase: String
    var startAt: String
    var endAt: String
    var employees: [EmployeeModel]
    
    enum projectType {
        case Construction
        case Support
    }
    
    
    func getProjectManager() -> String {
        for employee in self.employees {
            if employee.role == "PM" {
                return employee.name
            }
        }
        return "No manager allocated"
    }
    
    func getProjectEmployees() -> [EmployeeModel] {
        return self.employees
    }
    
    
    func getStartDate(withFormat: String = "dd-MM-yy") -> String {
        let dateFormatter = DateFormatter()
        let index = self.startAt.index(of: ".")
        var newDate: String = ""
        if index != nil {
            newDate = String(self.startAt.prefix(upTo: index!))
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: newDate)
        dateFormatter.dateFormat = withFormat
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    
    func getEndDate(withFormat: String = "dd-MM-yy") -> String {
        let dateFormatter = DateFormatter()
        let index = self.endAt.index(of: ".")
        var newDate: String = ""
        if index != nil {
            newDate = String(self.endAt.prefix(upTo: index!))
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: newDate)
        dateFormatter.dateFormat = withFormat
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    
    func getProjectPhase() -> String {
        return self.phase.lowercased()
    }
    
    func getProjectType() -> projectType {
        if getProjectPhase() == "SUPPORT" {
            return projectType.Support
        }
        return projectType.Construction
    }
}

struct ProjectResponseModel: Codable {
    var error: Bool
    var result: [ProjectModel]
}



