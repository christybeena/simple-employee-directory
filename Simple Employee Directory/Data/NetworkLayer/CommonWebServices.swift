//
//  CommonWebServices.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//


import Foundation

typealias webServiceCompletionhandler = (_ result : Any?, _ error : String?) -> Void

class CommonWebservice{
    
    static let shared = CommonWebservice()

    func getEmployeeList(of id : String,completionHandler : @escaping webServiceCompletionhandler){
        do{
            let employeeListrequest = try AppAPIRouter.Router<String>.GetEmployeeList(id: id).asURLRequest()
            WebServiceManager.request(withRequest: employeeListrequest, resultModelType: EmployeeList.self) { result, error in
                completionHandler(result,error)
            }

        }catch let exception{
            completionHandler(nil,exception.localizedDescription)
            
        }
      
    }
}



