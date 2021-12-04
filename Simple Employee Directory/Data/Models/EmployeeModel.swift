//
//  EmployeeModel.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//

import Foundation


typealias EmployeeList = [EmployeeDataModel]?

struct EmployeeDataModel : Codable{
    let id : Int?
    let name,username,email,profile_image : String?
    let address : AddressDataModel?
    let phone,website : String?
    let company : CompanyDataModel?
}

struct AddressDataModel : Codable{
    let street,suite,city,zipcode : String?
}

struct CompanyDataModel : Codable{
    let name,catchPhrase,bs : String?
}

