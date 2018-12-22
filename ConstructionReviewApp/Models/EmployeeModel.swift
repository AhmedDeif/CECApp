//
//  EmployeeModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/12/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct EmployeeModel: Codable {

    var id: Int
    var name: String
    var email: String
    var phone: String
    var role: String
    var EmployeeProjects: EmployeePorjects
    
    func employeeRoleString() -> String {
        switch self.role {
        case "PM" :
            return "Project Manager"
        case "TM" :
            return "Team member"
        default:
            return "No role deifned"
        }
    }
    
}

struct EmployeePorjects: Codable {
    
    var id: Int
    var employeeId: Int
    var projectId: Int
    
}
