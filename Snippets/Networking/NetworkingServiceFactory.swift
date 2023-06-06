//
//  NetworkingServiceFactory.swift
//  Snippets
//
//  Created by Bartosz Wojtkowiak on 06/06/2023.
//

import Foundation

class NetworkServiceFactory {
    static func create() -> NetworkService {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        
        if let environment = environment {
            if environment == "TEST" {
//                return MockWebservice()
                return Webservice()
            } else {
                return Webservice()
            }
        } else {
            return Webservice()
        }
    }
}
