//
//  EmployeeListViewModel.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//


import Foundation
import CoreData
import UIKit
import SwiftUI

typealias DefaultCallBack = (()->())

protocol EmployeeFetchedFromServiceProtocol{
    func fetchedResults(isCompleted:Bool)
}


class EmployeeListViewModel{
    
    var delegate: EmployeeFetchedFromServiceProtocol!
    
    
    fileprivate let commonServices = CommonWebservice.shared
    
    var employeeList = [Employee]()
    var selectedEmployee : Employee? = nil
    var executedserviceCall = false


    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getEmployeeListFromCoreData(with request : NSFetchRequest<Employee> = Employee.fetchRequest(),completion : DefaultCallBack?){
        
        do{
            let emplist = try self.context.fetch(request)
        
            employeeList = emplist
            
        }
        catch{
            print("Error in fetching data")
        }
        
        completion?()

    }

    
    func fetchEmployeeListFromService(of id: String){
            
            commonServices.getEmployeeList(of: id) { result, error in
                guard let list = result as? EmployeeList else {return}
                
                let listOfEmployees = list?.compactMap { $0 }
                listOfEmployees?.forEach({ emp in
                    print(emp)
                    
                    let employee = Employee(context: self.context)
                    employee.id = Int64(emp.id!)
                    employee.name = emp.name
                    employee.username = emp.username
                    employee.email = emp.email
                    employee.profileImage = emp.profile_image
                    let adress = Address(context: self.context)
                    adress.street = emp.address?.street
                    adress.suite = emp.address?.suite
                    adress.city = emp.address?.city
                    adress.zipcode = emp.address?.zipcode
                    employee.address = adress
                    employee.phone = emp.phone
                    employee.website = emp.website
                    let company = Company(context: self.context)
                    company.bs = emp.company?.bs
                    company.catchPhrase = emp.company?.catchPhrase
                    company.name = emp.company?.name
                    employee.company = company
                    
                    do{
                        try self.context.save()
                      


                    }
                    catch{
                        print("Error in saving data to coredata\(error)")

                    }
               
                })
                
                do{
                    let request : NSFetchRequest<Employee> = Employee.fetchRequest()
                    
                    self.employeeList = try self.context.fetch(request)
                    self.delegate.fetchedResults(isCompleted: true)

                }
                catch{
                    print("error in getting data from coredata")
                    self.delegate.fetchedResults(isCompleted: false)

                }
     
            }

    }
    
    
    
}
