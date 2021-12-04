//
//  AppAPIRouter.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//


import Foundation

import Alamofire

class AppAPIRouter {
    enum Router<T:Codable>: URLRequestConvertible {
        
        case GetEmployeeList(id: String)

        var method: HTTPMethod {
            switch self {
            case .GetEmployeeList:
                return .get
            }
        }

        var path: String {
            switch self {
                case .GetEmployeeList(let id):
                    return id
                }
        }

        func asURLRequest() throws -> URLRequest {
            
            let url = try EndPoint.baseURLString.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            return urlRequest
        }
    }
}
