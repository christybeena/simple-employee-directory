//
//  Connectivity.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//


import Foundation

import Alamofire

class Connectivity {
    
    class var isConnectedToInternet: Bool {
      
      return  NetworkReachabilityManager()?.isReachable ?? false
        
        }
        
    }
