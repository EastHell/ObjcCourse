//
//  RequestData.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

struct RequestData {
    let path: String
    let method: HTTPMethod
    let parameters: [String : Any]
    let headers: Set<HTTPHeader>
    let body: Body
    
    init(path: String,
         method: HTTPMethod,
         parameters: [String : Any] = [:],
         headers: Set<HTTPHeader> = [],
         body: Body) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.body = body
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPHeader: Hashable {
    
    var key: String {
        switch self {
        }
    }
    
    var value: String {
        switch self {
        }
    }
    
    static var `default`: [HTTPHeader] {
        return []
    }
}

enum Body {
    case empty
    case dict([String: Any])
    case data(Data)
}
