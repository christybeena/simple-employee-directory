//
//  WebServiceManager.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//


import Foundation
import Alamofire

class WebServiceManager{
    
    static var sessionManger = { () -> Session in
        var baseURLString: String = EndPoint.baseURLString.replacingOccurrences(of: "https://", with: "")
        var sessionManager: Session!
        let config = URLSessionConfiguration.default
        config.urlCache = nil

        sessionManager = Session.default
        return sessionManager
    }
    static var manager = WebServiceManager.sessionManger()
    
    
    public static func request<T: Decodable>(withRequest request: URLRequest, resultModelType: T.Type, withCompletionHandler handler: @escaping ((_ result: T?, _ error: String?) -> Void)){
        
        guard Connectivity.isConnectedToInternet else {
            handler(nil, "Network Not Reachable")
                 return
        }
        debugPrint(request)
        
        manager.request(request).validate().responseData { response in
            
            debugPrint(response)

                switch response.result {
                case .success:
                    guard let data = response.data else{
                        return
                    }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(T.self, from: data)
                        handler(responseModel,nil)
                    }
                    catch let error {
                        handler(nil,"failed to decode response data \(error.localizedDescription)")
                    }
                case .failure:
                    break

                }
        }
        
        
    }
    
}
