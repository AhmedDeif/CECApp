//
//  EmployeeModel.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/12/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct EmployeeModel {

    var id: Int
    var name: String
    var email: String
    var phone: String
    var role: String
    var EmployeeProjects: [EmployeePorjects]
    
}

struct EmployeePorjects {
    
    var id: Int
    var employeeId: Int
    var projectId: Int
    
}
